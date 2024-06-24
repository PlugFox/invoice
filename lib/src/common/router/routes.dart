import 'package:flutter/material.dart';
import 'package:invoice/src/feature/developer/widget/about_screen.dart';
import 'package:invoice/src/feature/developer/widget/developer_screen.dart';
import 'package:invoice/src/feature/invoice/widget/invoice_screen.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_screen.dart';
import 'package:invoice/src/feature/organizations/widget/organizations_screen.dart';
import 'package:invoice/src/feature/settings/widget/settings_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  invoices('invoices', title: 'Invoices'),
  invoice('invoice', title: 'Invoice'),
  organizations('organizations', title: 'Organizations'),
  settings('settings', title: 'Settings'),
  about('about', title: 'About'),
  developer('developer', title: 'Developer');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.invoices => const InvoicesScreen(),
        Routes.invoice => InvoiceScreen(id: node.arguments['id']),
        Routes.organizations => const OrganizationsScreen(),
        Routes.settings => const SettingsScreen(),
        Routes.about => const AboutScreen(),
        Routes.developer => const DeveloperScreen(),
      };
}
