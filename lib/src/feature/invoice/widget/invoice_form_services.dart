import 'package:flutter/material.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';

class InvoiceFormServices extends StatelessWidget {
  const InvoiceFormServices({
    required this.paddingH,
    required this.form,
    super.key, // ignore: unused_element
  });

  final double paddingH;
  final InvoiceFormController form;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: 6,
        padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
        itemExtent: 64 + 16,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ColoredBox(
            color: Colors.grey,
          ),
        ),
      );
}
