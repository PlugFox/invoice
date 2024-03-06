import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/common/model/dependencies.dart';
import 'package:invoice/src/feature/organizations/controller/organizations_controller.dart';
import 'package:invoice/src/feature/organizations/controller/organizations_state.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';

/// {@template organizations_scope}
/// OrganizationsScope widget.
/// {@endtemplate}
class OrganizationsScope extends StatefulWidget {
  /// {@macro organizations_scope}
  const OrganizationsScope({
    required this.child,
    super.key, // ignore: unused_element
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Get [OrganizationsController] from the closest instance of this class
  static OrganizationsController of(BuildContext context) =>
      _InheritedOrganizationsScope.of(context, listen: false).scope._controller;

  /// Fetch organizations
  static void fetchOrganizations(BuildContext context) => of(context).fetchOrganizations();

  /// Get all organizations from the closest instance of this class
  static List<Organization> getOrganizations(BuildContext context, {bool listen = true}) =>
      _InheritedOrganizationsScope.maybeOf(context, listen: listen)?.list ?? const [];

  /// Get [Organization] by [OrganizationId]
  static Organization? getById(BuildContext context, OrganizationId id, {bool listen = true}) =>
      _InheritedOrganizationsScope.getById(context, id, listen: listen);

  @override
  State<OrganizationsScope> createState() => _OrganizationsScopeState();
}

/// State for widget OrganizationsScope.
class _OrganizationsScopeState extends State<OrganizationsScope> {
  List<Organization> _list = const [];
  Map<OrganizationId, Organization> _table = const {};
  late final OrganizationsController _controller = _initController();

  late ScaffoldMessengerState _scaffoldMessenger;

  OrganizationsController _initController() => OrganizationsController(
        repository: Dependencies.of(context).organizationsRepository,
      )
        ..fetchOrganizations()
        ..addListener(_onStateChanged);

  void _onStateChanged() {
    if (!mounted) return;
    final state = _controller.state;
    switch (state) {
      case OrganizationsState$Error state:
        _scaffoldMessenger
          ..clearSnackBars()
          ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
      case OrganizationsState$Successful _:
      case OrganizationsState$Processing _:
      case OrganizationsState$Idle _:
        break;
    }
    final newOrganizations = state.data;
    if (listEquals(newOrganizations, _list)) return;
    setState(() {
      _list = List<Organization>.unmodifiable(newOrganizations);
      _table = <OrganizationId, Organization>{
        for (final org in newOrganizations) org.id: org,
      };
    });
  }

  /* #region Lifecycle */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onStateChanged)
      ..dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => _InheritedOrganizationsScope(
        list: _list,
        table: _table,
        scope: this,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedOrganizationsScope extends InheritedModel<OrganizationId> {
  const _InheritedOrganizationsScope({
    required this.list,
    required this.table,
    required this.scope,
    required super.child,
  });

  final _OrganizationsScopeState scope;

  final List<Organization> list;
  final Map<OrganizationId, Organization> table;

  static _InheritedOrganizationsScope? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedOrganizationsScope>()
      : context.getInheritedWidgetOfExactType<_InheritedOrganizationsScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedInvoicesScope of the exact type',
        'out_of_scope',
      );

  static _InheritedOrganizationsScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  /// Get [Organization] by [OrganizationId]
  static Organization? getById(BuildContext context, OrganizationId id, {bool listen = true}) => (listen
          ? InheritedModel.inheritFrom<_InheritedOrganizationsScope>(context, aspect: id)
          : maybeOf(context, listen: false))
      ?.table[id];

  @override
  bool updateShouldNotify(covariant _InheritedOrganizationsScope oldWidget) => !listEquals(list, oldWidget.list);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedOrganizationsScope oldWidget, Set<OrganizationId> aspects) {
    for (final id in aspects) if (table[id] != oldWidget.table[id]) return true;
    return false;
  }
}
