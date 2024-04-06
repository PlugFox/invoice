import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/input_text_field.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';

class InvoiceFormDescription extends StatelessWidget {
  const InvoiceFormDescription({
    required this.paddingH,
    required this.form,
    super.key, // ignore: unused_element
  });

  final double paddingH;
  final InvoiceFormController form;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: paddingH),
        child: InputTextField(
          controller: form.description,
          expands: true,
          minLines: null,
          multiline: true,
          label: 'Description',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hint: '________________________\n'
              '_________________________\n'
              '___________\n'
              '_________________________\n'
              '______________\n'
              '_________________',
          autocorrect: true,
          keyboardType: TextInputType.multiline,
        ),
      );
}
