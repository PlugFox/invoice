import 'package:flutter/material.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_scope.dart';

/// {@template organization_picker}
/// OrganizationPicker widget.
/// {@endtemplate}
class OrganizationPicker extends StatelessWidget {
  /// {@macro organization_picker}
  const OrganizationPicker({
    required this.labelText,
    required this.controller,
    this.hintText,
    super.key, // ignore: unused_element
  });

  final String labelText;
  final String? hintText;
  final ValueNotifier<Organization?> controller;

  @override
  Widget build(BuildContext context) => Autocomplete<Organization>(
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => TextField(
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
          controller: controller,
          focusNode: focusNode,
          maxLines: 1,
          expands: false,
          keyboardType: TextInputType.text,
          /* onFieldSubmitted: (value) {
            onFieldSubmitted();
            controller.text = value;
          }, */
        ),
        optionsBuilder: (textEditingValue) {
          final text = textEditingValue.text.trim().toLowerCase();
          return OrganizationsScope.getOrganizations(context, listen: false)
              .where((org) => org.name.toLowerCase().contains(text));
        },
        displayStringForOption: (option) => option.name,
        onSelected: (value) => controller.value = value,
      );
}
