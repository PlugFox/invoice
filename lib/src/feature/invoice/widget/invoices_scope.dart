import 'package:flutter/widgets.dart';

/// {@template invoices_scope}
/// InvoicesScope widget.
/// {@endtemplate}
class InvoicesScope extends StatefulWidget {
  /// {@macro invoices_scope}
  const InvoicesScope({
    required this.child,
    super.key, // ignore: unused_element
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<InvoicesScope> createState() => _InvoicesScopeState();
}

/// State for widget InvoicesScope.
class _InvoicesScopeState extends State<InvoicesScope> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(InvoicesScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */

  @override
  Widget build(BuildContext context) => _InheritedInvoicesScope(
        state: this,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedInvoicesScope extends InheritedWidget {
  const _InheritedInvoicesScope({
    required this.state,
    required super.child,
  });

  final _InvoicesScopeState state;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `InvoicesScope.maybeOf(context)`.
  static _InheritedInvoicesScope? maybeOf(BuildContext context,
          {bool listen = true}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_InheritedInvoicesScope>()
          : context.getInheritedWidgetOfExactType<_InheritedInvoicesScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedInvoicesScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `InvoicesScope.of(context)`.
  static _InheritedInvoicesScope of(BuildContext context,
          {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedInvoicesScope oldWidget) => false;
}
