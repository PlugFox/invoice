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
  late InvoicesController _controller;

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
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            bool preview;
            double column;
            if (constraints.maxWidth >= Config.maxScreenLayoutWidth * 0.75) {
              preview = true;
              column = constraints.maxWidth / 2;
            } else {
              preview = false;
              column = constraints.maxWidth;
            }
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  key: const ValueKey('form'),
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: math.max(16, (column - Config.maxScreenLayoutWidth) / 2),
                      vertical: 16,
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 400,
                          child: Placeholder(),
                        ),
                        SizedBox(
                          height: 400,
                          child: Placeholder(),
                        ),
                        //Text('Invoice: ${invoice.id}'),
                        //Text('Created at: ${invoice.createdAt}'),
                      ],
                    ),
                  ),
                ),
                if (preview)
                  Expanded(
                    key: const ValueKey('preview'),
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: math.min(column, Config.maxScreenLayoutWidth.toDouble()),
                        child: Center(
                          child: AspectRatio(
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
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      );
}
