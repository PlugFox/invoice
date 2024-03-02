import 'package:flutter/material.dart';
import 'package:invoice/src/common/router/routes.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/common/widget/scaffold_padding.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_scope.dart';
import 'package:octopus/octopus.dart';

/// {@template invoices_screen}
/// InvoicesScreen widget.
/// {@endtemplate}
class InvoicesScreen extends StatelessWidget {
  /// {@macro invoices_screen}
  const InvoicesScreen({super.key});

  void openInvoice(int id) => Octopus.instance.pushNamed(Routes.invoice.name, arguments: {'id': id.toString()});

  @override
  Widget build(BuildContext context) {
    var invoices = InvoicesScope.getInvoices(context);
    /* invoices = [
      for (var i = 0; i < 100; i++) ...invoices,
    ]; */

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => InvoicesScope.of(context).createInvoice(
          onSuccess: (invoice) => openInvoice(invoice.id),
        ),
        tooltip: 'Create new invoice',
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverCommonHeader(
            title: const Text('Invoices'),
            pinned: false,
          ),

          /* const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Invoices'),
                ],
              ),
            ),
          ), */

          ScaffoldPadding.sliver(
            context,
            SliverList.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return ListTile(
                  title: Text(invoice.id.toString()),
                  subtitle: Text(invoice.createdAt.toString()),
                  onTap: () => openInvoice(invoice.id),
                  // TODO(plugfox): Delete, edit, clone
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
