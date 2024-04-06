import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice/src/common/util/date_util.dart';

/// {@template adaptive_date_picker}
/// AdaptiveDatePicker widget.
/// {@endtemplate}
class AdaptiveDatePicker extends StatelessWidget {
  /// {@macro adaptive_date_picker}
  const AdaptiveDatePicker({
    required this.label,
    required this.controller,
    this.isRequired = false,
    super.key, // ignore: unused_element
  });

  final String label;
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
          labelText: label,
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
            DateUtil.format(value, format: DateFormat.yMMMd()),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
