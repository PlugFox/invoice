import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/src/common/constant/config.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_pdf_controller.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_controller.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/invoice/widget/invoice_form_description.dart';
import 'package:invoice/src/feature/invoice/widget/invoice_form_details.dart';
import 'package:invoice/src/feature/invoice/widget/invoice_form_services.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_scope.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

// TODO(plugfox): add form validators

/// {@template invoice_screen}
/// InvoiceScreen widget.
/// {@endtemplate}
class InvoiceScreen extends StatefulWidget {
  /// {@macro invoice_screen}
  const InvoiceScreen({
    this.id,
    super.key, // ignore: unused_element
  });

  final Object? id;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  Invoice? invoice;

  @override
  void initState() {
    super.initState();
    final id = switch (widget.id) {
      int id => id,
      String id => int.tryParse(id),
      _ => null,
    };
    if (id != null) invoice = InvoicesScope.getById(context, id, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (invoice case Invoice invoice)
      return _InvoiceScaffold(invoice: invoice);
    else
      return const _InvoiceNotFound();
  }
}

class _InvoiceNotFound extends StatelessWidget {
  const _InvoiceNotFound({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CommonHeader(
          title: const Text('Not Found'),
        ),
        body: const SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Invoice not found'),
              ],
            ),
          ),
        ),
      );
}

class _InvoiceScaffold extends StatefulWidget {
  const _InvoiceScaffold({
    required this.invoice,
    super.key, // ignore: unused_element
  });

  final Invoice invoice;

  @override
  State<_InvoiceScaffold> createState() => _InvoiceScaffoldState();
}

class _InvoiceScaffoldState extends State<_InvoiceScaffold> {
  late final InvoiceFormController form;
  late InvoicesController _controller;
  final FocusNode _focusNode = FocusNode();

  Timer? _debounceTimer;
  final InvoicePDFController _pdfController = InvoicePDFController();

  late final Widget _layout = SafeArea(
    child: CustomMultiChildLayout(
      delegate: _InvoicePositionDelegate(),
      children: <LayoutId>[
        LayoutId(
          id: 'form',
          child: const _InvoiceFormColumn(),
        ),
        LayoutId(
          id: 'preview',
          child: _PreviewInvoice(
            pdfController: _pdfController,
          ),
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    form = InvoiceFormController(widget.invoice)..addListener(_onFormChanged);
    _controller = InvoicesScope.of(context)
      ..fetchInvoiceById(widget.invoice.id)
      ..addListener(_onInvoicesChanged);
    _onInvoicesChanged();
  }

  void _onFormChanged() {
    if (!mounted) return;
    // Update PDF preview
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;
        _pdfController.rebuild(form.createInvoice()).ignore();
      },
    );
  }

  /// When invoices changed
  void _onInvoicesChanged() {
    if (!mounted) return;
    if (_controller.state.isProcessing) return;
    final updatedInvoice = _controller.state.data.firstWhereOrNull((i) => i.id == form.id);
    if (updatedInvoice == null) return;
    _fillForm(updatedInvoice);
  }

  /// Fill form from upcoming invoice
  void _fillForm(Invoice invoice) => form.update(invoice);

  /// Save invoice
  void _saveForm() => _controller.updateInvoice(invoice: form.createInvoice());

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _focusNode.dispose();
    form
      ..removeListener(_onFormChanged)
      ..dispose();
    _controller.removeListener(_onInvoicesChanged);
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.keyS, control: true): _saveForm,
          const SingleActivator(LogicalKeyboardKey.save): _saveForm,
          const SingleActivator(LogicalKeyboardKey.f5): _saveForm,
        },
        child: Scaffold(
          appBar: CommonHeader(
            title: ValueListenableBuilder(
              valueListenable: form.number,
              builder: (context, number, _) => ValueListenableBuilder(
                valueListenable: form.status,
                builder: (context, status, _) => Text(
                  'Invoice #${number.text} (${status.name.toUpperCase()})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          body: DefaultTabController(
            length: 3,
            child: _InheritedInvoiceForm(
              form: form,
              scope: this,
              child: Focus(
                autofocus: true,
                focusNode: _focusNode,
                canRequestFocus: true,
                child: _layout,
              ),
            ),
          ),
        ),
      );
}

class _InheritedInvoiceForm extends InheritedNotifier<InvoiceFormController> {
  const _InheritedInvoiceForm({
    required this.form,
    required this.scope,
    required super.child,
    super.key, // ignore: unused_element
  }) : super(notifier: form);

  final InvoiceFormController form;
  final _InvoiceScaffoldState scope;

  static _InvoiceScaffoldState of(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedInvoiceForm>()!.scope
      : context.getInheritedWidgetOfExactType<_InheritedInvoiceForm>()!.scope;
}

class _InvoicePositionDelegate extends MultiChildLayoutDelegate {
  _InvoicePositionDelegate();

  static final double maxScreenLayoutWidth = Config.maxScreenLayoutWidth.toDouble();

  @override
  void performLayout(Size size) {
    const formId = 'form', previewId = 'preview';

    const padding = 16;
    if (size.width < (maxScreenLayoutWidth * 1.25 + padding * 3)) {
      layoutChild(formId, BoxConstraints.loose(size));
      positionChild(formId, Offset.zero);
      layoutChild(previewId, BoxConstraints.loose(Size.zero));
      positionChild(previewId, Offset.zero);
    } else {
      final maxHeight = size.height;
      final previewSize = layoutChild(
        previewId,
        BoxConstraints.loose(
          Size(
            math.min(
              math.max(size.width - maxScreenLayoutWidth - padding, size.width / 2),
              (maxHeight - padding * 2) * 210 / 297 + padding,
            ),
            maxHeight - padding * 2,
          ),
        ),
      );
      final formSize =
          layoutChild(formId, BoxConstraints.loose(Size(size.width - previewSize.width - padding, size.height)));
      positionChild(formId, Offset.zero);
      positionChild(previewId, Offset(formSize.width, (size.height - previewSize.height) / 2));
    }
  }

  @override
  bool shouldRelayout(covariant _InvoicePositionDelegate oldDelegate) => false;
}

class _InvoiceFormColumn extends StatelessWidget {
  const _InvoiceFormColumn({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final paddingH = math.max<double>(8, (constraints.maxWidth - Config.maxScreenLayoutWidth) / 2);
          final form = _InheritedInvoiceForm.of(context, listen: true).form;
          final changed = form.changed;
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _InvoiceHeaderButtons(paddingH: paddingH, changed: changed),
              const SizedBox(height: 4),
              //Divider(height: 1, indent: paddingH, endIndent: paddingH),
              _InvoiceHeaderTabBar(paddingH: paddingH),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    InvoiceFormDetails(paddingH: paddingH, form: form),
                    InvoiceFormServices(paddingH: paddingH, form: form),
                    InvoiceFormDescription(paddingH: paddingH, form: form),
                  ],
                ),
              ),
            ],
          );
        },
      );
}

class _InvoiceHeaderTabBar extends StatelessWidget {
  const _InvoiceHeaderTabBar({
    required this.paddingH,
    super.key, // ignore: unused_element
  });

  final double paddingH;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: TabBar(
          tabAlignment: TabAlignment.fill,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.symmetric(horizontal: paddingH),
          tabs: const <Widget>[
            Tab(/* text: 'Form', */ icon: Icon(Icons.edit, size: 20)),
            Tab(/* text: 'Services', */ icon: Icon(Icons.list, size: 20)),
            Tab(/* text: 'Description', */ icon: Icon(Icons.description, size: 20)),
          ],
        ),
      );
}

class _InvoiceHeaderButtons extends StatelessWidget {
  const _InvoiceHeaderButtons({
    required this.paddingH,
    required this.changed,
    super.key, // ignore: unused_element
  });

  final double paddingH;
  final bool changed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingH),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'Save changes (Ctrl + S)',
                  onPressed: changed ? () => _InheritedInvoiceForm.of(context, listen: false)._saveForm() : null,
                ),
              ),
              const SizedBox(width: 8),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.copy),
                  tooltip: 'Dublicate invoice',
                  onPressed: null,
                ),
              ),
              const SizedBox(width: 8),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.preview),
                  tooltip: 'Preview PDF',
                  onPressed: null,
                ),
              ),
              const Spacer(),
              /* const VerticalDivider(),
              const Spacer(), */
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: const Icon(Icons.print),
                  tooltip: 'Print invoice',
                  onPressed: () => context.findAncestorStateOfType<_InvoiceScaffoldState>()?._pdfController.layout(),
                ),
              ),
              /* const SizedBox(width: 8),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.share),
                  tooltip: 'Share invoice',
                  onPressed: null,
                ),
              ), */
              const SizedBox(width: 8),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.email),
                  tooltip: 'Send email',
                  onPressed: null,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: const Icon(Icons.file_download),
                  tooltip: 'Download pdf',
                  onPressed: () => context.findAncestorStateOfType<_InvoiceScaffoldState>()?._pdfController.share(),
                ),
              ),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.data_object),
                  tooltip: 'Export to JSON',
                  onPressed: null,
                ),
              ),
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.copy_all),
                  tooltip: 'Copy to clipboard',
                  onPressed: null,
                ),
              ),
              const Spacer(),
              /* const VerticalDivider(),
              const Spacer(), */
              const SizedBox.square(
                dimension: 48,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete invoice',
                  color: Colors.red,
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      );
}

class _PreviewInvoice extends StatefulWidget {
  const _PreviewInvoice({
    required this.pdfController,
    super.key, // ignore: unused_element
  });

  final InvoicePDFController pdfController;

  @override
  State<_PreviewInvoice> createState() => _PreviewInvoiceState();
}

class _PreviewInvoiceState extends State<_PreviewInvoice> {
  final ValueNotifier<bool> _loading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> _error = ValueNotifier<String?>(null);
  final ValueNotifier<Uint8List?> _pdf = ValueNotifier<Uint8List?>(null);
  //final ValueNotifier<PdfPageFormat> _format = ValueNotifier<PdfPageFormat>(PdfPageFormat.letter);

  @override
  void initState() {
    super.initState();
    widget.pdfController.addListener(_onStateChanged);
    _onStateChanged();
  }

  @override
  void didUpdateWidget(covariant _PreviewInvoice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.pdfController, oldWidget.pdfController)) {
      oldWidget.pdfController.removeListener(_onStateChanged);
      widget.pdfController.addListener(_onStateChanged);
      _onStateChanged();
    }
  }

  @override
  void dispose() {
    widget.pdfController.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (!mounted) return;
    final state = widget.pdfController.value;
    _loading.value = state.loading;
    _error.value = state.error;
    _pdf.value = state.pdf.isEmpty ? null : state.pdf;
    /* _format.value = switch (state.template.format) {
      InvoiceTemplateFormat.a4 => PdfPageFormat.a4,
      InvoiceTemplateFormat.letter => PdfPageFormat.letter,
    }; */
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => constraints.biggest.width == 0
            ? const SizedBox.shrink()
            : AspectRatio(
                aspectRatio: 210 / 297,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ValueListenableBuilder<Uint8List?>(
                    valueListenable: _pdf,
                    builder: (context, bytes, _) {
                      if (bytes == null) return const Center(child: CircularProgressIndicator());
                      return PdfPreviewCustom(
                        build: (_) => bytes,
                        maxPageWidth: 880,
                        padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                        scrollViewDecoration: const BoxDecoration(),
                        loadingWidget: const CircularProgressIndicator(),
                        pageFormat: PdfPageFormat.a4,
                      );
                    },
                  ),
                ),
              ),
      );
}
