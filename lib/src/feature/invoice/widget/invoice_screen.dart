import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/common/widget/scaffold_padding.dart';
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
  late Invoice invoice;

  @override
  void initState() {
    super.initState();
    invoice = widget.invoice;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CommonHeader(
          title: const Text('Invoice Detail'),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: ScaffoldPadding.of(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Invoice: ${invoice.id}'),
                  Text('Created at: ${invoice.createdAt}'),
                ],
              ),
            ),
          ),
        ),
      );
}
