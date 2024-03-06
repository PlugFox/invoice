import 'package:flutter/material.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';

/// {@template organization_bottom_sheet}
/// OrganizationBottomSheet widget.
/// {@endtemplate}
class OrganizationBottomSheet extends StatefulWidget {
  /// {@macro organization_bottom_sheet}
  const OrganizationBottomSheet({
    required this.organization,
    this.create = false,
    super.key, // ignore: unused_element
  });

  final Organization organization;
  final bool create;

  /// Show the organization dialog.
  static PersistentBottomSheetController show(BuildContext context, Organization organization, {bool create = false}) =>
      showBottomSheet(
        context: context,
        builder: (context) => OrganizationBottomSheet(organization: organization, create: create),
      );

  @override
  State<OrganizationBottomSheet> createState() => _OrganizationBottomSheetState();
}

class _OrganizationBottomSheetState extends State<OrganizationBottomSheet> {
  late final ValueNotifier<OrganizationType> _type;
  @override
  void initState() {
    super.initState();
    _type = ValueNotifier<OrganizationType>(widget.organization.type);
  }

  @override
  void dispose() {
    _type.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: _type,
              builder: (context, value, _) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (widget.create)
                    ToggleButtons(
                      isSelected: <bool>[
                        value == OrganizationType.organization,
                        value == OrganizationType.counterparty
                      ],
                      onPressed: (index) =>
                          _type.value = index == 0 ? OrganizationType.organization : OrganizationType.counterparty,
                      children: const <Widget>[
                        Icon(Icons.business),
                        Icon(Icons.person),
                      ],
                    ),
                  const SizedBox(width: 16),
                  Text(value.name),
                ],
              ),
            ),
            /* CommonHeader(
            title: Text(widget.organization.name),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //Navigator.of(context).pop();
                  //OrganizationsScope.of(context).editOrganization(widget.organization);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  //Navigator.of(context).pop();
                  //OrganizationsScope.of(context).deleteOrganization(widget.organization);
                },
              ),
            ],
          ), */
            ListTile(
              leading: const Icon(Icons.business),
              title: Text(widget.organization.name),
              subtitle: Text(widget.organization.tax ?? ''),
            ),
            /* ListTile(
            leading: const Icon(Icons.email),
            title: Text(widget.organization.email),
          ), */
            /* ListTile(
            leading: const Icon(Icons.phone),
            title: Text(widget.organization.phone),
          ), */
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(widget.organization.address ?? ''),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (!widget.create)
                  TextButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      //OrganizationsScope.of(context).deleteOrganization(widget.organization);
                    },
                    label: const Text(
                      'Save',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (widget.create)
                  TextButton.icon(
                    icon: const Icon(Icons.create),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      //OrganizationsScope.of(context).deleteOrganization(widget.organization);
                    },
                    label: const Text(
                      'Create',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
}
