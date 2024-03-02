import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/common_actions.dart';
import 'package:invoice/src/common/widget/scaffold_padding.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_scope.dart';

/// {@template invoices_screen}
/// InvoicesScreen widget.
/// {@endtemplate}
class InvoicesScreen extends StatelessWidget {
  /// {@macro invoices_screen}
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoices = InvoicesScope.getInvoices(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => InvoicesScope.of(context).createInvoice(),
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: const Text('Invoices'),
            leading: const SizedBox.shrink(),
            actions: CommonActions(),
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
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
