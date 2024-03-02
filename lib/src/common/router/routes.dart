import 'package:flutter/material.dart';
import 'package:invoice/src/feature/developer/widget/developer_screen.dart';
import 'package:invoice/src/feature/invoice/widget/invoices_screen.dart';
import 'package:invoice/src/feature/settings/widget/settings_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  invoices('invoices', title: 'Invoices'),
  settings('settings', title: 'Settings'),
  developer('developer', title: 'Developer');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.invoices => const InvoicesScreen(),
        Routes.settings => const SettingsScreen(),
        Routes.developer => const DeveloperScreen(),
      };
}
