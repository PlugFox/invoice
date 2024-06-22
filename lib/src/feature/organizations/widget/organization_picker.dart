import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/input_text_field.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_scope.dart';

/// {@template organization_picker}
/// OrganizationPicker widget.
/// {@endtemplate}
class OrganizationPicker extends StatelessWidget {
  /// {@macro organization_picker}
  const OrganizationPicker({
    required this.label,
    required this.controller,
    this.initialValue,
    this.hint,
    this.suggestionsLimit = 10,
    this.order,
    this.textInputAction,
    this.floatingLabelBehavior,
    this.prefixIcon,
    this.filter,
    this.createNew,
    super.key, // ignore: unused_element
  });

  final TextEditingValue? initialValue;
  final String label;
  final String? hint;
  final int suggestionsLimit;
  final double? order;
  final TextInputAction? textInputAction;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Widget? prefixIcon;
  final ValueNotifier<Organization?> controller;
  final bool Function(Organization organization)? filter;
  final Widget Function(BuildContext context)? createNew;

  static String? _lastSearchText;
  Future<List<Organization>> optionsBuilder(BuildContext context, TextEditingValue value) async {
    final createNewPlaceholder = createNew != null
        ? Organization(
            id: -1,
            name: 'Create new organization',
            tax: null,
            address: null,
            description: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            type: OrganizationType.organization,
          )
        : null;
    final text = _lastSearchText = value.text.trim().toLowerCase();
    final organizations = OrganizationsScope.getOrganizations(context, listen: false);
    final where = filter?.call ?? (_) => true;
    if (text.isEmpty)
      return <Organization>[
        if (createNewPlaceholder != null) createNewPlaceholder,
        ...organizations.where(where).take(suggestionsLimit),
      ];
    final result = <Organization>[
      if (createNewPlaceholder != null) createNewPlaceholder,
    ];
    final stopwatch = Stopwatch()..start();
    try {
      for (final org in organizations) {
        final Organization(:name, :tax, :address, :description) = org;
        final contains = name.toLowerCase().contains(text) ||
            tax != null && tax.toLowerCase().contains(text) ||
            address != null && address.toLowerCase().contains(text) ||
            description != null && description.toLowerCase().contains(text);
        if (contains && where(org)) result.add(org);
        if (result.length >= suggestionsLimit) break;
        if (stopwatch.elapsedMilliseconds > 8) {
          await Future<void>.delayed(Duration.zero);
          if (text != _lastSearchText) break;
          stopwatch.reset();
        }
      }
    } finally {
      stopwatch.stop();
    }
    return result;
  }

  Widget focusOrder({required Widget child}) {
    if (order case double value) return FocusTraversalOrder(order: NumericFocusOrder(value), child: child);
    return child;
  }

  @override
  Widget build(BuildContext context) => focusOrder(
        child: SizedBox(
          height: 56,
          child: Center(
            child: Autocomplete<Organization>(
              initialValue: initialValue ?? TextEditingValue(text: controller.value?.name ?? ''),
              optionsBuilder: (textEditingValue) => optionsBuilder(context, textEditingValue),
              displayStringForOption: (option) => option.name,
              onSelected: (value) => controller.value = value,
              optionsViewOpenDirection: OptionsViewOpenDirection.down,
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: math.min(options.length * 48.0, 5 * 48.0),
                  width: 320,
                  child: Material(
                    elevation: 4,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemExtent: 48,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        if (index == 0 && createNew != null) return createNew!.call(context);
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(option.name),
                          onTap: () => onSelected(option),
                        );
                      },
                    ),
                  ),
                ),
              ),
              fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) => InputTextField(
                controller: textController,
                focusNode: focusNode,
                expands: false,
                keyboardType: TextInputType.text,
                autofillHints: const <String>[AutofillHints.organizationName],
                autocorrect: true,
                textInputAction: textInputAction,
                /* onFieldSubmitted: (value) {
                  onFieldSubmitted();
                  controller.text = value;
                }, */
                label: label,
                hint: hint,
                floatingLabelBehavior: floatingLabelBehavior,
                prefixIcon: prefixIcon,
                suffixIcon: ValueListenableBuilder<Organization?>(
                  valueListenable: controller,
                  builder: (context, value, child) => IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: value == null
                        ? null
                        : () {
                            textController.clear();
                            controller.value = null;
                          },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
