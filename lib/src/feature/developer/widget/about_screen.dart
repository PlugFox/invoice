import 'package:flutter/material.dart';
import 'package:invoice/src/common/constant/pubspec.yaml.g.dart';

/// {@template about_screen}
/// AboutScreen widget.
/// {@endtemplate}
class AboutScreen extends StatelessWidget {
  /// {@macro about_screen}
  const AboutScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => LicensePage(
        applicationName: 'Invoice',
        applicationVersion: Pubspec.version.representation,
        applicationIcon: const FlutterLogo(),
        applicationLegalese: '© ${DateTime.now().year} Invoice',
      );
}
