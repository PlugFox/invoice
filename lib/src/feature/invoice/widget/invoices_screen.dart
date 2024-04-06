import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/common/router/routes.dart';
import 'package:invoice/src/common/util/date_util.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/common/widget/scaffold_padding.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_scope.dart';
import 'package:octopus/octopus.dart';

/// {@template invoices_screen}
/// InvoicesScreen widget.
/// {@endtemplate}
class InvoicesScreen extends StatelessWidget {
  /// {@macro invoices_screen}
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var invoices = InvoicesScope.getInvoices(context);
    /* invoices = [
      for (var i = 0; i < 100; i++) ...invoices,
    ]; */

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => InvoicesScope.of(context).createInvoice(
          onSuccess: (invoice) => _InvoiceTile.openInvoice(context, invoice.id),
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
            SliverFixedExtentList.builder(
              itemCount: invoices.length,
              itemExtent: 64,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return _InvoiceTile(
                  key: ValueKey<InvoiceId>(invoice.id),
                  invoice: invoice,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceTile extends StatelessWidget {
  const _InvoiceTile({
    required this.invoice,
    super.key, // ignore: unused_element
  });

  final Invoice invoice;

  /// Open invoice
  static void openInvoice(BuildContext context, InvoiceId id) {
    if (!context.mounted) return;
    Octopus.of(context).pushNamed(Routes.invoice.name, arguments: {'id': id.toString()});
  }

  /// Clone invoice
  static void cloneInvoice(BuildContext context, InvoiceId id) {
    if (!context.mounted) return;
    final controller = InvoicesScope.of(context);
    controller.fetchInvoiceById(
      id,
      onSuccess: (invoice) => controller.createInvoice(
        onSuccess: (invoice) => controller.updateInvoice(
          invoice: Invoice(
            id: invoice.id,
            createdAt: invoice.createdAt,
            updatedAt: invoice.updatedAt,
            number: invoice.number,
            status: invoice.status,
            total: invoice.total,
            services: invoice.services,
            description: invoice.description,
            organization: invoice.organization,
            counterparty: invoice.counterparty,
            issuedAt: invoice.issuedAt,
            dueAt: invoice.dueAt,
            paidAt: invoice.paidAt,
          ),
        ),
      ),
    );
  }

  /// Delete invoice
  static void deleteInvoice(BuildContext context, InvoiceId id) {
    if (!context.mounted) return;
    final controller = InvoicesScope.of(context);
    final theme = Theme.of(context);

    Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          return TextButton(onPressed: onPressed, child: child);
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoDialogAction(onPressed: onPressed, child: child);
      }
    }

    showAdaptiveDialog<void>(
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Delete invoice'),
        titlePadding: const EdgeInsets.all(16),
        icon: const Icon(Icons.warning, color: Colors.red),
        iconColor: Colors.red,
        content: const Text('Are you sure you want to delete this invoice?'),
        actions: <Widget>[
          adaptiveAction(
            context: context,
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: theme.textTheme.labelLarge,
            ),
          ),
          adaptiveAction(
            context: context,
            onPressed: () {
              controller.deleteInvoice(id: id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: theme.textTheme.labelLarge?.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 64,
        child: InkWell(
          onTap: () => openInvoice(context, invoice.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox.square(
                  dimension: 48,
                  child: Icon(Icons.receipt),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        switch (invoice.number) {
                          String text when text.isNotEmpty => text,
                          _ => invoice.id.toString().padLeft(6, '0'),
                        },
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1),
                      ),
                      Text(
                        DateUtil.format(invoice.createdAt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox.square(
                  dimension: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Material(
                      color: Colors.transparent,
                      child: PopupMenuButton<String>(
                        splashRadius: 18,
                        constraints: const BoxConstraints(minWidth: 124, minHeight: 48),
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          _InvoicePopupMenuItem(
                            value: 'edit',
                            icon: const Icon(Icons.edit_document, size: 20),
                            label: const Text('Edit'),
                            onTap: () => openInvoice(context, invoice.id),
                          ),
                          _InvoicePopupMenuItem(
                            value: 'clone',
                            icon: const Icon(Icons.content_copy, size: 20),
                            label: const Text('Copy'),
                            onTap: () => cloneInvoice(context, invoice.id),
                          ),
                          _InvoicePopupMenuItem(
                            enabled: false,
                            value: 'print',
                            icon: const Icon(Icons.print, size: 20),
                            label: const Text('Print'),
                            onTap: () {},
                          ),
                          _InvoicePopupMenuItem(
                            enabled: false,
                            value: 'preview',
                            icon: const Icon(Icons.document_scanner, size: 20),
                            label: const Text('Preview'),
                            onTap: () {},
                          ),
                          _InvoicePopupMenuItem(
                            enabled: false,
                            value: 'send',
                            icon: const Icon(Icons.email, size: 20),
                            label: const Text('Send'),
                            onTap: () {},
                          ),
                          const PopupMenuDivider(),
                          _InvoicePopupMenuItem(
                            value: 'delete',
                            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                            label: const Text('Delete', style: TextStyle(color: Colors.red)),
                            onTap: () => deleteInvoice(context, invoice.id),
                          ),
                        ],
                        child: const Icon(Icons.more_vert),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _InvoicePopupMenuItem extends PopupMenuItem<String> {
  _InvoicePopupMenuItem({
    required super.value,
    required super.onTap,
    required Widget icon,
    required Widget label,
    super.enabled = true, // ignore: unused_element
    super.key, // ignore: unused_element
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              icon,
              const SizedBox(width: 16),
              label,
            ],
          ),
        );
}
