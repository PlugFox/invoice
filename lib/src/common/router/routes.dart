import 'package:flutter/material.dart';
import 'package:invoice/src/feature/account/widget/profile_screen.dart';
import 'package:invoice/src/feature/account/widget/settings_dialog.dart';
import 'package:invoice/src/feature/developer/widget/developer_screen.dart';
import 'package:invoice/src/feature/home/widget/home_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  home('home', title: 'Octopus'),
  profile('profile', title: 'Profile'),
  developer('developer', title: 'Developer'),
  settingsDialog('settings-dialog', title: 'Settings');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.home => const HomeScreen(),
        Routes.profile => const ProfileScreen(),
        Routes.developer => const DeveloperScreen(),
        Routes.settingsDialog => const SettingsDialog(),
      };
}
