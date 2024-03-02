import 'package:flutter/material.dart';
import 'package:invoice/src/common/widget/common_actions.dart';

class SliverCommonHeader extends SliverAppBar {
  SliverCommonHeader({
    super.leading,
    super.pinned = true,
    super.title = const Text('Invoices'),
    List<Widget>? actions,
    super.key,
  }) : super(
          actions: actions ?? CommonActions(),
        );
}

class CommonHeader extends AppBar {
  CommonHeader({
    super.leading,
    super.title = const Text('Invoices'),
    List<Widget>? actions,
    super.key,
  }) : super(
          actions: actions ?? CommonActions(),
        );
}
