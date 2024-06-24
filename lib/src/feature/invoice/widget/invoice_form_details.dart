import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/adaptive_date_picker.dart';
import 'package:invoice/src/common/widget/currency_picker.dart';
import 'package:invoice/src/common/widget/input_text_field.dart';
import 'package:invoice/src/common/widget/output_text_field.dart';
import 'package:invoice/src/feature/invoice/controller/invoice_form_controller.dart';
import 'package:invoice/src/feature/invoice/widget/invoice_form_section.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:invoice/src/feature/organizations/widget/organization_dialog.dart';
import 'package:invoice/src/feature/organizations/widget/organization_picker.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_scope.dart';

class InvoiceFormDetails extends StatelessWidget {
  const InvoiceFormDetails({
    required this.paddingH,
    required this.form,
    super.key, // ignore: unused_element
  });

  final double paddingH;
  final InvoiceFormController form;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        primary: true,
        padding: EdgeInsets.symmetric(
          horizontal: paddingH,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InvoiceFormSection(
              children: <Widget>[
                InputTextField(
                  controller: form.number,
                  label: 'Number',
                  prefixIcon: const Icon(Icons.numbers),
                  suffixIcon: IconButton(
                    // Generate new number
                    icon: const Icon(Icons.restore),
                    onPressed: form.generateNumber,
                  ),
                  multiline: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                ),
                AdaptiveDatePicker(
                  label: 'Issued at',
                  controller: form.issuedAt,
                  isRequired: true,
                ),
                AdaptiveDatePicker(
                  label: 'Due at',
                  controller: form.dueAt,
                ),
                AdaptiveDatePicker(
                  label: 'Paid at',
                  controller: form.paidAt,
                ),
              ],
            ),
            const SizedBox(height: 16),
            InvoiceFormSection(
              children: <Widget>[
                OrganizationPicker(
                  label: 'Organization',
                  controller: form.organization,
                  prefixIcon: const Icon(Icons.business),
                  filter: (organization) => organization.type.isOrganization,
                  createNew: (context, onSelected) => ListTile(
                    title: const Text('Create new organization'),
                    onTap: () => OrganizationsScope.of(context).createOrganization(
                      name: 'New organization',
                      type: OrganizationType.organization,
                      onSuccess: (organization) {
                        onSelected(organization);
                        OrganizationDialog.show(context, organization).then<void>((value) {
                          if (value != null) onSelected(value);
                        }).ignore();
                      },
                    ),
                  ),
                ),
                OrganizationPicker(
                  label: 'Counterparty',
                  controller: form.counterparty,
                  prefixIcon: const Icon(Icons.person),
                  filter: (organization) => organization.type.isCounterparty,
                  createNew: (context, onSelected) => ListTile(
                    title: const Text('Create new counterparty'),
                    onTap: () => OrganizationsScope.of(context).createOrganization(
                      name: 'New counterparty',
                      type: OrganizationType.counterparty,
                      onSuccess: (counterparty) {
                        onSelected(counterparty);
                        OrganizationDialog.show(context, counterparty).then<void>((value) {
                          if (value != null) onSelected(value);
                        }).ignore();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InvoiceFormSection(
              children: <Widget>[
                CurrencyPicker(
                  label: 'Currency',
                  controller: form.currency,
                  prefixIcon: const Icon(Icons.money),
                ),
                OutputTextField(
                  label: 'Total',
                  enabled: false,
                  controller: form.total,
                  output: (value) => value.amount.toString(),
                  prefixIcon: const Icon(Icons.monetization_on),
                  multiline: false,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ],
            ),
            /* const SizedBox(height: 16),
            const InvoiceFormSection(
              children: <Widget>[
                ColoredBox(color: Colors.red, child: SizedBox.expand()),
                ColoredBox(color: Colors.blue, child: SizedBox.expand()),
              ],
            ), */
          ],
        ),
      );
}
