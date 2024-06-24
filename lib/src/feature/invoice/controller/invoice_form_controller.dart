import 'package:collection/collection.dart';
import 'package:control/control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:money2/money2.dart';

final class InvoiceFormController extends Controller with ConcurrentControllerHandler {
  InvoiceFormController(Invoice invoice)
      : _changed = false,
        _invoice = invoice,
        issuedAt = ValueNotifier<DateTime>(invoice.issuedAt),
        dueAt = ValueNotifier<DateTime?>(invoice.dueAt),
        paidAt = ValueNotifier<DateTime?>(invoice.paidAt),
        organization = ValueNotifier<Organization?>(invoice.organization),
        counterparty = ValueNotifier<Organization?>(invoice.counterparty),
        status = ValueNotifier<InvoiceStatus>(invoice.status),
        number = TextEditingController(text: invoice.number),
        currency = ValueNotifier<Currency>(invoice.currency),
        _total = ValueNotifier<Money>(invoice.total),
        services = ValueNotifier<List<ProvidedService>>(invoice.services),
        description = TextEditingController(text: invoice.description) {
    final notifiers = _notifiers = <ValueNotifier<Object?>>[
      issuedAt,
      dueAt,
      paidAt,
      organization,
      counterparty,
      status,
      number,
      currency,
      _total,
      services,
      description,
    ];
    for (final n in notifiers) n.addListener(_onChanged);
    _evalTotal();
  }

  /// Invoice changed?
  bool _changed;
  bool get changed => _changed;

  Invoice _invoice;
  Invoice get invoice => _invoice;

  InvoiceId get id => _invoice.id;

  DateTime get createdAt => _invoice.createdAt;

  DateTime get updatedAt => _invoice.updatedAt;

  final ValueNotifier<DateTime> issuedAt;

  final ValueNotifier<DateTime?> dueAt;

  final ValueNotifier<DateTime?> paidAt;

  final ValueNotifier<Organization?> organization;

  final ValueNotifier<Organization?> counterparty;

  final ValueNotifier<InvoiceStatus> status;

  final TextEditingController number;

  final ValueNotifier<Currency> currency;

  final ValueNotifier<Money> _total;
  ValueListenable<Money> get total => _total;

  final ValueNotifier<List<ProvidedService>> services;

  final TextEditingController description;

  late final List<ValueNotifier<Object?>> _notifiers;

  /// Update from invoice
  void update(Invoice invoice) => handle(() async {
        _invoice = invoice;
        issuedAt.value = invoice.issuedAt;
        dueAt.value = invoice.dueAt;
        paidAt.value = invoice.paidAt;
        organization.value = invoice.organization;
        counterparty.value = invoice.counterparty;
        status.value = invoice.status;
        number.text = invoice.number;
        currency.value = invoice.currency;
        _total.value = invoice.total;
        services.value = invoice.services;
        description.text = invoice.description ?? '';
        _changed = false;
        _evalTotal();
        notifyListeners();
      });

  /// Generate new invoice number based on [issuedAt] and [id]
  void generateNumber() => number.text = Invoice.generateNumber(_invoice.id, issuedAt.value);

  /// Generate new invoice number based on [issuedAt] and [id]
  String _generateNumber() {
    final dt = issuedAt.value.toUtc();
    return '${dt.day + dt.month * 100 + dt.year * 10000}-${id.toRadixString(36)}';
  }

  /// Change services list
  void changeServices(Iterable<ProvidedService> Function(List<ProvidedService> services) fn) {
    final list = fn(services.value);
    if (identical(list, services.value)) return;
    final copy = list.mapIndexed((i, s) => s.copyWith(number: i + 1)).toList(growable: false);
    services.value = copy;
  }

  /// Re eval total
  void _evalTotal() {
    var total = Fixed.zero;
    for (final s in services.value) total += s.amount;
    _total.value = Money.fromFixedWithCurrency(total, currency.value);
  }

  /// On notifiers changed
  void _onChanged() {
    _evalTotal();
    //if (_changed) return;
    _changed = true;
    notifyListeners();
  }

  /// Build a new invoice based on form data
  Invoice createInvoice() => Invoice(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        issuedAt: issuedAt.value,
        dueAt: dueAt.value,
        paidAt: paidAt.value,
        organization: organization.value,
        counterparty: counterparty.value,
        status: status.value,
        number: switch (number.text) {
          String text when text.trim().isNotEmpty => text.trim(),
          _ => _generateNumber(),
        },
        total: total.value,
        services: services.value,
        description: description.text,
      );

  @override
  void dispose() {
    for (final n in _notifiers) n.dispose();
    super.dispose();
  }
}
