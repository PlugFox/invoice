import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:invoice/src/common/constant/config.dart';
import 'package:invoice/src/common/widget/common_header.dart';
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
  // TODO(plugfox): form controller
  late InvoicesController _controller;

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
    _controller = InvoicesScope.of(context)..fetchInvoiceById(widget.invoice.id, onSuccess: _fillForm);
    _fillForm(widget.invoice);
  }

  void _fillForm(Invoice invoice) {
    // TODO(plugfox):
  }

  void _saveForm() {
    // TODO(plugfox):
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CommonHeader(
          title: const Text('Invoice Detail'),
        ),
        body: _layout,
      );
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
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 48,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingH),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      SizedBox(width: 8),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      Spacer(),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      SizedBox(width: 8),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      VerticalDivider(),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      SizedBox(width: 8),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                      SizedBox(width: 8),
                      SizedBox.square(dimension: 48, child: Placeholder()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Divider(height: 1, indent: paddingH, endIndent: paddingH),
              Expanded(
                child: SingleChildScrollView(
                  primary: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingH,
                    vertical: 16,
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _InvoiceFormSection(
                        children: <Widget>[
                          ColoredBox(color: Colors.grey, child: SizedBox.expand()),
                          ColoredBox(color: Colors.red, child: SizedBox.expand()),
                          ColoredBox(color: Colors.blue, child: SizedBox.expand()),
                          ColoredBox(color: Colors.green, child: SizedBox.expand()),
                          ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                        ],
                      ),
                      SizedBox(height: 16),
                      _InvoiceFormSection(
                        children: <Widget>[
                          ColoredBox(color: Colors.grey, child: SizedBox.expand()),
                          ColoredBox(color: Colors.red, child: SizedBox.expand()),
                          ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                        ],
                      ),
                      SizedBox(height: 16),
                      _InvoiceFormSection(
                        children: <Widget>[
                          ColoredBox(color: Colors.grey, child: SizedBox.expand()),
                          ColoredBox(color: Colors.red, child: SizedBox.expand()),
                          ColoredBox(color: Colors.green, child: SizedBox.expand()),
                          ColoredBox(color: Colors.yellow, child: SizedBox.expand()),
                        ],
                      ),
                      SizedBox(height: 16),
                      _InvoiceFormSection(
                        children: <Widget>[
                          ColoredBox(color: Colors.red, child: SizedBox.expand()),
                          ColoredBox(color: Colors.blue, child: SizedBox.expand()),
                        ],
                      ),
                    ],
                  ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
