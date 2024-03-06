import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/common_header.dart';
import 'package:invoice/src/common/widget/scaffold_padding.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:invoice/src/feature/organizations/widget/organization_bottom_sheet.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_scope.dart';

/// {@template organizations_screen}
/// OrganizationsScreen widget.
/// {@endtemplate}
class OrganizationsScreen extends StatelessWidget {
  /// {@macro organizations_screen}
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgAndClients = OrganizationsScope.getOrganizations(context);
    final organizations =
        orgAndClients.where((org) => org.type == OrganizationType.organization).toList(growable: false);
    final counterparties =
        orgAndClients.where((org) => org.type == OrganizationType.counterparty).toList(growable: false);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => OrganizationBottomSheet.show(
            context,
            Organization(
              id: -1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: 'New',
              address: null,
              description: null,
              tax: null,
              type: OrganizationType.organization,
            ),
            create: true,
          ),
          tooltip: 'Create new organization or counterparty',
          child: const Icon(Icons.add),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverCommonHeader(
            title: const Text('Organizations and Clients'),
            pinned: false,
          ),

          /* const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Organizations'),
                ],
              ),
            ),
          ), */

          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(
              top: 16,
              bottom: 8,
            ),
            sliver: const SliverToBoxAdapter(
              child: Text('Organizations', style: TextStyle(fontSize: 18)),
            ),
          ),
          if (organizations.isEmpty)
            ScaffoldPadding.sliver(
              context,
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No organizations found'),
                ),
              ),
            )
          else
            ScaffoldPadding.sliver(
              context,
              SliverFixedExtentList.builder(
                itemCount: organizations.length,
                itemExtent: 64,
                itemBuilder: (context, index) {
                  final organization = organizations[index];
                  return _OrganizationTile(
                    key: ValueKey<OrganizationId>(organization.id),
                    organization: organization,
                  );
                },
              ),
            ),
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(
              top: 24,
            ),
            sliver: const SliverToBoxAdapter(
              child: Divider(),
            ),
          ),
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(
              top: 16,
              bottom: 8,
            ),
            sliver: const SliverToBoxAdapter(
              child: Text('Counterparties', style: TextStyle(fontSize: 18)),
            ),
          ),
          if (counterparties.isEmpty)
            ScaffoldPadding.sliver(
              context,
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No counterparties found'),
                ),
              ),
            )
          else
            ScaffoldPadding.sliver(
              context,
              SliverFixedExtentList.builder(
                itemCount: counterparties.length,
                itemExtent: 64,
                itemBuilder: (context, index) {
                  final counterparty = counterparties[index];
                  return _OrganizationTile(
                    key: ValueKey<OrganizationId>(counterparty.id),
                    organization: counterparty,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _OrganizationTile extends StatelessWidget {
  const _OrganizationTile({
    required this.organization,
    super.key, // ignore: unused_element
  });

  final Organization organization;

  /// Open organization
  static void openOrganization(BuildContext context, Organization organization) {
    if (!context.mounted) return;
    OrganizationBottomSheet.show(context, organization);
  }

  /// Clone organization
  static void cloneOrganization(BuildContext context, OrganizationId id) {
    if (!context.mounted) return;
    final controller = OrganizationsScope.of(context);
    controller.fetchOrganizationById(
      id,
      onSuccess: (organization) => controller.createOrganization(
        name: '${organization.name} (copy)',
        onSuccess: (organization) => controller.updateOrganization(
          organization: Organization(
            id: organization.id,
            createdAt: organization.createdAt,
            updatedAt: organization.updatedAt,
            name: organization.name,
            address: organization.address,
            description: organization.description,
            tax: organization.tax,
            type: organization.type,
          ),
        ),
      ),
    );
  }

  /// Delete organization
  static void deleteOrganization(BuildContext context, OrganizationId id) {
    if (!context.mounted) return;
    final controller = OrganizationsScope.of(context);
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
        title: const Text('Delete organization'),
        titlePadding: const EdgeInsets.all(16),
        icon: const Icon(Icons.warning, color: Colors.red),
        iconColor: Colors.red,
        content: const Text('Are you sure you want to delete this organization?'),
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
              controller.deleteOrganization(id: id);
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
          onTap: () => openOrganization(context, organization),
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
                        organization.id.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1),
                      ),
                      Text(
                        organization.createdAt.toString(),
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
                          _OrganizationPopupMenuItem(
                            value: 'edit',
                            icon: const Icon(Icons.edit_document, size: 20),
                            label: const Text('Edit'),
                            onTap: () => openOrganization(context, organization),
                          ),
                          _OrganizationPopupMenuItem(
                            value: 'clone',
                            icon: const Icon(Icons.content_copy, size: 20),
                            label: const Text('Copy'),
                            onTap: () => cloneOrganization(context, organization.id),
                          ),
                          const PopupMenuDivider(),
                          _OrganizationPopupMenuItem(
                            value: 'delete',
                            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                            label: const Text('Delete', style: TextStyle(color: Colors.red)),
                            onTap: () => deleteOrganization(context, organization.id),
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

class _OrganizationPopupMenuItem extends PopupMenuItem<String> {
  _OrganizationPopupMenuItem({
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
