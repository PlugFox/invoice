import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/common/model/dependencies.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_controller.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_state.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';

/// {@template invoices_scope}
/// InvoicesScope widget.
/// {@endtemplate}
class InvoicesScope extends StatefulWidget {
  /// {@macro invoices_scope}
  const InvoicesScope({
    required this.child,
    this.lazy = false,
    super.key, // ignore: unused_element
  });

  /// Whether the controller should be initialized lazily.
  final bool lazy;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Get [InvoicesController] from the closest instance of this class
  static InvoicesController of(BuildContext context) =>
      _InheritedInvoicesScope.of(context, listen: false).scope._controller;

  /// Fetch invoices
  static void fetchInvoices(BuildContext context) => of(context).fetchInvoices();

  /// Get all invoices from the closest instance of this class
  static List<Invoice> getInvoices(BuildContext context, {bool listen = true}) =>
      _InheritedInvoicesScope.maybeOf(context, listen: listen)?.invoices ?? const [];

  /// Get [Invoice] by [InvoiceId]
  static Invoice? getById(BuildContext context, InvoiceId id, {bool listen = true}) =>
      _InheritedInvoicesScope.getById(context, id, listen: listen);

  @override
  State<InvoicesScope> createState() => _InvoicesScopeState();
}

/// State for widget InvoicesScope.
class _InvoicesScopeState extends State<InvoicesScope> {
  InvoicesController get _controller => _$controller ??= _initController();
  late ScaffoldMessengerState _scaffoldMessenger;
  InvoicesController? _$controller;
  List<Invoice> _invoices = const [];
  Map<InvoiceId, Invoice> _table = const {};

  InvoicesController _initController() => InvoicesController(
        repository: Dependencies.of(context).invoicesRepository,
      )
        ..fetchInvoices()
        ..addListener(_onStateChanged);

  @override
  void initState() {
    super.initState();
    if (!widget.lazy) _controller;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  void _onStateChanged() {
    if (!mounted) return;
    final state = _controller.state;
    switch (state) {
      case InvoicesState$Error state:
        _scaffoldMessenger
          ..clearSnackBars()
          ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
      case InvoicesState$Successful _:
      case InvoicesState$Processing _:
      case InvoicesState$Idle _:
        break;
    }
    final newInvoices = state.data;
    if (listEquals(newInvoices, _invoices)) return;
    setState(() {
      _invoices = List<Invoice>.unmodifiable(newInvoices);
      _table = <InvoiceId, Invoice>{
        for (final invoice in newInvoices) invoice.id: invoice,
      };
    });
  }

  @override
  void dispose() {
    _$controller?.removeListener(_onStateChanged);
    _$controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedInvoicesScope(
        scope: this,
        invoices: _invoices,
        table: _table,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedInvoicesScope extends InheritedModel<InvoiceId> {
  const _InheritedInvoicesScope({
    required this.scope,
    required this.invoices,
    required this.table,
    required super.child,
  });

  final _InvoicesScopeState scope;
  final List<Invoice> invoices;
  final Map<InvoiceId, Invoice> table;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `InvoicesScope.maybeOf(context)`.
  static _InheritedInvoicesScope? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedInvoicesScope>()
      : context.getInheritedWidgetOfExactType<_InheritedInvoicesScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedInvoicesScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `InvoicesScope.of(context)`.
  static _InheritedInvoicesScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  /// Get [Invoice] by [InvoiceId]
  static Invoice? getById(BuildContext context, InvoiceId id, {bool listen = true}) => (listen
          ? InheritedModel.inheritFrom<_InheritedInvoicesScope>(context, aspect: id)
          : maybeOf(context, listen: false))
      ?.table[id];

  @override
  bool updateShouldNotify(covariant _InheritedInvoicesScope oldWidget) => !listEquals(invoices, oldWidget.invoices);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedInvoicesScope oldWidget, Set<InvoiceId> aspects) {
    for (final id in aspects) if (table[id] != oldWidget.table[id]) return true;
    return false;
  }
}
