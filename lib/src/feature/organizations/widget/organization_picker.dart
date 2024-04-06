import 'dart:async';

import 'package:flutter/material.dart';
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

  static String? _lastSearchText;
  Future<List<Organization>> optionsBuilder(BuildContext context, TextEditingValue value) async {
    final text = _lastSearchText = value.text.trim().toLowerCase();
    final organizations = OrganizationsScope.getOrganizations(context, listen: false);
    final where = filter?.call ?? (_) => true;
    if (text.isEmpty) return organizations.where(where).take(suggestionsLimit).toList(growable: false);
    final result = <Organization>[];
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Autocomplete<Organization>(
                initialValue: initialValue ?? TextEditingValue(text: controller.value?.name ?? ''),
                fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) => TextField(
                  controller: textController,
                  focusNode: focusNode,
                  maxLines: 1,
                  expands: false,
                  keyboardType: TextInputType.text,
                  autofillHints: const <String>[AutofillHints.organizationName],
                  autocorrect: true,
                  textInputAction: textInputAction,
                  /* onFieldSubmitted: (value) {
                    onFieldSubmitted();
                    controller.text = value;
                  }, */
                  decoration: InputDecoration(
                    isCollapsed: false,
                    isDense: false,
                    filled: true,
                    labelText: label,
                    hintText: hint,
                    helperText: null,
                    floatingLabelBehavior: floatingLabelBehavior,
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
                    prefixIcon: prefixIcon,
                    prefixIconConstraints: const BoxConstraints.expand(width: 48, height: 48),
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
                    suffixIconConstraints: const BoxConstraints.expand(width: 48, height: 48),
                    counter: const SizedBox.shrink(),
                    errorText: null,
                    helperMaxLines: 0,
                    errorMaxLines: 0,
                  ),
                ),
                optionsBuilder: (textEditingValue) => optionsBuilder(context, textEditingValue),
                displayStringForOption: (option) => option.name,
                onSelected: (value) => controller.value = value,
              ),
            ),
          ),
        ),
      );
}
