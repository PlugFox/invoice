import 'package:flutter/material.dart';
import 'package:invoice/src/common/constant/config.dart';

class InvoiceFormSection extends StatelessWidget {
  const InvoiceFormSection({
    required this.children,
    super.key, // ignore: unused_element
  });

  final List<Widget> children;

  static List<Widget> _buildOneColumn(List<Widget> children) => List<Widget>.generate(
        children.length,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 64,
            child: children[i],
          ),
        ),
        growable: false,
      );

  static List<Widget> _buildTwoColumn(List<Widget> children) => List<Widget>.generate(
        (children.length / 2).ceil(),
        (i) {
          final index = i * 2;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: children[index]),
                  const SizedBox(width: 16),
                  Expanded(child: index + 1 < children.length ? children[index + 1] : const SizedBox.shrink()),
                ],
              ),
            ),
          );
        },
        growable: false,
      );

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final twoColumn = constraints.maxWidth >= Config.maxScreenLayoutWidth * 0.75;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: twoColumn ? _buildTwoColumn(children) : _buildOneColumn(children),
              );
            },
          ),
        ),
      );
}
