import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/app_text_field.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_scope.dart';

/// {@template organization_dialog}
/// OrganizationDialog widget.
/// {@endtemplate}
class OrganizationDialog extends StatefulWidget {
  /// {@macro organization_dialog}
  const OrganizationDialog({
    required this.organization,
    super.key, // ignore: unused_element
  });

  final Organization organization;

  /// Show the organization dialog.
  static Future<Organization?> show(BuildContext context, Organization organization) =>
      showAdaptiveDialog<Organization>(
        context: context,
        builder: (context) => Dialog(
          child: OrganizationDialog(
            organization: organization,
          ),
        ),
      );

  @override
  State<OrganizationDialog> createState() => _OrganizationDialogState();
}

class _OrganizationDialogState extends State<OrganizationDialog> {
  late final ValueNotifier<OrganizationType> _type;
  late final TextEditingController _name, _address, _tax, _description;
  late final List<ValueNotifier<Object?>> _listenables;
  late final Listenable _formListenable;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _type = ValueNotifier<OrganizationType>(widget.organization.type);
    _name = TextEditingController(text: widget.organization.name);
    _address = TextEditingController(text: widget.organization.address);
    _tax = TextEditingController(text: widget.organization.tax);
    _description = TextEditingController(text: widget.organization.description);
    _listenables = <ValueNotifier<Object?>>[_type, _name, _address, _tax, _description];
    _formListenable = Listenable.merge(_listenables)..addListener(_onFormChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  void dispose() {
    _formListenable.removeListener(_onFormChanged);
    for (final listenable in _listenables) {
      listenable.dispose();
    }
    super.dispose();
  }

  void save() {
    final org = Organization(
      id: widget.organization.id,
      createdAt: widget.organization.createdAt,
      updatedAt: widget.organization.updatedAt,
      type: _type.value,
      name: _name.text.trim(),
      address: _address.text,
      tax: _tax.text,
      description: _description.text,
    );
    if (org.name.isEmpty) return;
    OrganizationsScope.of(context).updateOrganization(
        organization: org,
        onSuccess: (org) {
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true).pop(org);
        });
  }

  void _onFormChanged() {}

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: ValueListenableBuilder<OrganizationType>(
              valueListenable: _type,
              builder: (context, type, _) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          type.isOrganization ? Icons.business : Icons.person,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            type.isOrganization ? 'Organization' : 'Counterparty',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.titleMedium?.copyWith(height: 1, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _name,
                    label: 'Name',
                    autocorrect: true,
                    order: 0,
                    hint: '${type.isOrganization ? 'Organization' : 'Counterparty'} name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    multiline: false,
                    suffixIcon: Icon(type.isOrganization ? Icons.business : Icons.person),
                    autofillHints: const <String>[AutofillHints.name],
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _address,
                    label: 'Address',
                    autocorrect: true,
                    order: 1,
                    hint: 'Address',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    multiline: false,
                    suffixIcon: const Icon(Icons.location_on),
                    autofillHints: const <String>[AutofillHints.streetAddressLine1],
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _tax,
                    label: 'Tax',
                    autocorrect: false,
                    order: 2,
                    hint: 'Tax',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    multiline: false,
                    suffixIcon: const Icon(Icons.monetization_on),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _description,
                    label: 'Description',
                    autocorrect: true,
                    order: 3,
                    hint: 'Description',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    expands: false,
                    multiline: true,
                    minLines: 3,
                    suffixIcon: const Icon(Icons.description),
                  ),
                  SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListenableBuilder(
                          listenable: _formListenable,
                          builder: (context, _) {
                            final updated = _type.value != widget.organization.type ||
                                _name.text != widget.organization.name ||
                                _address.text != widget.organization.address ||
                                _tax.text != widget.organization.tax ||
                                _description.text != widget.organization.description;
                            return TextButton.icon(
                              icon: const Icon(Icons.save),
                              onPressed: _name.text.isEmpty || !updated ? null : save,
                              label: const Text(
                                'Save',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

/*
  ValueListenableBuilder<OrganizationType>(
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
  CommonHeader(
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
  ),
  ListTile(
    leading: const Icon(Icons.business),
    title: Text(widget.organization.name),
    subtitle: Text(widget.organization.tax ?? ''),
  ),
  ListTile(
    leading: const Icon(Icons.email),
    title: Text(widget.organization.email),
  ),
  ListTile(
    leading: const Icon(Icons.phone),
    title: Text(widget.organization.phone),
  ),
*/