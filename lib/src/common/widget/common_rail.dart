import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/common/constant/config.dart';
import 'package:invoice/src/common/router/routes.dart';
import 'package:octopus/octopus.dart';

/// {@template common_rail}
/// CommonRail widget.
/// {@endtemplate}
class CommonRail extends StatelessWidget {
  /// {@macro common_rail}
  const CommonRail({
    required this.child,
    super.key, // ignore: unused_element
  });

  final Widget child;

  static final List<({String name, NavigationRailDestination destination})> _destinations = [
    (
      name: Routes.invoices.name,
      destination: const NavigationRailDestination(icon: Icon(Icons.home), label: Text('Invoices')),
    ),
    /* NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorite'),
      ), */
    (
      name: Routes.settings.name,
      destination: const NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
    ),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final mediaQueryData = MediaQuery.of(context);
          final wide = constraints.maxWidth >= Config.maxScreenLayoutWidth + 256;
          return Row(
            children: <Widget>[
              RepaintBoundary(
                child: ValueListenableBuilder(
                  valueListenable: Octopus.instance.observer,
                  builder: (context, state, _) {
                    final currentName = state.children.last.name;
                    int? currentIdx = _destinations.indexWhere((element) => element.name == currentName);
                    if (currentIdx == -1) currentIdx = null;
                    return NavigationRail(
                      selectedIndex: currentIdx,
                      destinations: _destinations.map((e) => e.destination).toList(growable: false),
                      onDestinationSelected: (index) {
                        if (index == currentIdx) return;
                        if (index == 0) {
                          Octopus.instance.setState(
                              (state) => state..removeWhere((element) => element.name != Routes.invoices.name));
                        } else {
                          final destination = _destinations[index];
                          Octopus.instance.setState((state) {
                            state.removeWhere(
                                (element) => element.name != destination.name && element.name != Routes.invoices.name);
                            if (state.children.none((element) => element.name == destination.name))
                              state.add(OctopusNode.mutable(destination.name));
                            return state;
                          });
                        }
                      },
                      extended: wide,
                      minWidth: 72,
                      minExtendedWidth: 256,
                    );
                  },
                ),
              ),
              Expanded(
                child: RepaintBoundary(
                  child: MediaQuery(
                    data: mediaQueryData.copyWith(
                      size: Size(constraints.maxWidth - (wide ? 256 : 72), constraints.maxHeight),
                      textScaler: TextScaler.noScaling,
                    ),
                    child: child,
                  ),
                ),
              ),
            ],
          );
        },
      );
}
