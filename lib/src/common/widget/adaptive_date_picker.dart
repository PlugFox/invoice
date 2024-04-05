import 'package:flutter/material.dart';

/// {@template adaptive_date_picker}
/// AdaptiveDatePicker widget.
/// {@endtemplate}
class AdaptiveDatePicker extends StatelessWidget {
  /// {@macro adaptive_date_picker}
  const AdaptiveDatePicker({
    required this.labelText,
    required this.controller,
    this.isRequired = false,
    super.key, // ignore: unused_element
  });

  final String labelText;
  final bool isRequired;
  final ValueNotifier<DateTime?> controller;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return GestureDetector(
      onTap: () => showDatePicker(
        context: context,
        initialDate: controller.value ?? now,
        firstDate: now.subtract(const Duration(days: 365 * 100)),
        lastDate: now.add(const Duration(days: 365 * 100)),
      ).then<void>((value) => controller.value = value ?? controller.value),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: const Icon(Icons.calendar_today),
          suffixIcon: isRequired
              ? null
              : ValueListenableBuilder<DateTime?>(
                  valueListenable: controller,
                  builder: (context, value, child) => IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: value == null ? null : () => controller.value = null,
                  ),
                ),
        ),
        child: ValueListenableBuilder<DateTime?>(
          valueListenable: controller,
          builder: (context, value, child) => Text(
            value?.toIso8601String() ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
