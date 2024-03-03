import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/src/common/constant/config.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_controller.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_scope.dart';

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

  final Widget _layout = SafeArea(
    child: CustomMultiChildLayout(
      delegate: _InvoicePositionDelegate(),
      children: <LayoutId>[
        LayoutId(
          id: 'form',
          child: const _InvoiceFormColumn(),
        ),
        LayoutId(
          id: 'preview',
          child: const _PreviewInvoicePreviewColumn(),
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    form = InvoiceFormController(widget.invoice);
    _controller = InvoicesScope.of(context)
      ..fetchInvoiceById(widget.invoice.id)
      ..addListener(_onInvoicesChanged);
  }

  /// When invoices changed
  void _onInvoicesChanged() {
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
    _focusNode.dispose();
    _controller.removeListener(_onInvoicesChanged);
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
          final paddingH = math.max<double>(16, (constraints.maxWidth - Config.maxScreenLayoutWidth) / 2);
          final form = _InheritedInvoiceForm.of(context, listen: true).form;
          final changed = form.changed;
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
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
                          onPressed:
                              changed ? () => _InheritedInvoiceForm.of(context, listen: false)._saveForm() : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(Icons.copy),
                          tooltip: 'Copy invoice',
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
                      const SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(Icons.print),
                          tooltip: 'Print invoice',
                          onPressed: null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(Icons.share),
                          tooltip: 'Share invoice',
                          onPressed: null,
                        ),
                      ),
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
                      const SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(Icons.file_download),
                          tooltip: 'Download pdf',
                          onPressed: null,
                        ),
                      ),
                      const VerticalDivider(),
                      const SizedBox.square(
                        dimension: 48,
                        child: IconButton(
                          icon: Icon(Icons.data_object),
                          tooltip: 'Export to JSON',
                          onPressed: null,
                        ),
                      ),
                      const Spacer(),
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
              ),
              const SizedBox(height: 4),
              //Divider(height: 1, indent: paddingH, endIndent: paddingH),
              SizedBox(
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
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      primary: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingH,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _InvoiceFormSection(
                            children: <Widget>[
                              TextField(
                                controller: form.number,
                                decoration: InputDecoration(
                                  labelText: 'Number',
                                  suffixIcon: IconButton(
                                    // Generate new number
                                    icon: const Icon(Icons.restore),
                                    onPressed: form.generateNumber,
                                  ),
                                ),
                              ),
                              const ColoredBox(color: Colors.red, child: SizedBox.expand()),
                              const ColoredBox(color: Colors.blue, child: SizedBox.expand()),
                              const ColoredBox(color: Colors.green, child: SizedBox.expand()),
                              const ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const _InvoiceFormSection(
                            children: <Widget>[
                              ColoredBox(color: Colors.grey, child: SizedBox.expand()),
                              ColoredBox(color: Colors.red, child: SizedBox.expand()),
                              ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const _InvoiceFormSection(
                            children: <Widget>[
                              ColoredBox(color: Colors.grey, child: SizedBox.expand()),
                              ColoredBox(color: Colors.red, child: SizedBox.expand()),
                              ColoredBox(color: Colors.green, child: SizedBox.expand()),
                              ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const _InvoiceFormSection(
                            children: <Widget>[
                              ColoredBox(color: Colors.red, child: SizedBox.expand()),
                              ColoredBox(color: Colors.blue, child: SizedBox.expand()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 6,
                      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
                      itemExtent: 64 + 16,
                      itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ColoredBox(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: form.description,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
}

class _InvoiceFormSection extends StatelessWidget {
  const _InvoiceFormSection({
    required this.children,
    super.key, // ignore: unused_element
  });

  final List<Widget> children;

  static List<Widget> _buildOneColumn(List<Widget> children) => List<Widget>.generate(
        children.length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 64,
            child: children[i],
          ),
        ),
        growable: false,
      );

  static List<Widget> _buildTwoColumn(List<Widget> children) => List<Widget>.generate(
        (children.length / 2).ceil(),
        (i) {
          final index = i * 2;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: children[index]),
                  const SizedBox(width: 16),
                  Expanded(child: index + 1 < children.length ? children[index + 1] : const SizedBox.shrink()),
                ],
              ),
            ),
          );
        },
        growable: false,
      );

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final twoColumn = constraints.maxWidth >= Config.maxScreenLayoutWidth * 0.75;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: twoColumn ? _buildTwoColumn(children) : _buildOneColumn(children),
              );
            },
          ),
        ),
      );
}

class _PreviewInvoicePreviewColumn extends StatelessWidget {
  const _PreviewInvoicePreviewColumn({
    super.key, // ignore: unused_element
  });

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
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Placeholder(),
                  ),
                ),
              ),
      );
}
