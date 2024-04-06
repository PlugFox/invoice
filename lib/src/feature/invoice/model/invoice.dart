import 'package:flutter/foundation.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:money2/money2.dart';

typedef InvoiceId = int;

@immutable
class Invoice implements Comparable<Invoice> {
  Invoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.issuedAt,
    required this.dueAt,
    required this.paidAt,
    required this.organization,
    required this.counterparty,
    required this.status,
    required this.total,
    required this.services,
    required this.description,
    String? number,
    this.deleted = false,
  }) : number = switch (number?.trim()) {
          String it when it.isNotEmpty => it,
          _ => generateNumber(id, issuedAt),
        };

  /// Generate invoice number
  static String generateNumber(InvoiceId id, DateTime issuedAt) {
    final dt = issuedAt.toUtc();
    return 'INV-${dt.month + dt.year * 100}-${id.toRadixString(36)}';
  }

  /// Invoice id
  final InvoiceId id;

  /// Whether the invoice is deleted
  final bool deleted;

  /// Created at
  final DateTime createdAt;

  /// Updated at
  final DateTime updatedAt;

  /// Issued at
  final DateTime issuedAt;

  /// Due at
  final DateTime? dueAt;

  /// Paid at
  final DateTime? paidAt;

  /// Organization
  final Organization? organization;

  /// Counterparty
  final Organization? counterparty;

  /// Invoice status
  final InvoiceStatus status;

  /// Invoice number
  final String number;

  /// Currency
  Currency get currency => total.currency;

  /// Total amount
  final Money total;

  /// Services provided
  final List<ProvidedService> services;

  /// Description
  final String? description;

  @override
  int compareTo(covariant Invoice other) => other.createdAt.compareTo(createdAt);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Invoice && id == other.id && updatedAt == other.updatedAt && listEquals(services, other.services);

  @override
  String toString() => 'Invoice{number: $number, status: $status}';
}

enum InvoiceStatus {
  draft('Draft'),
  issued('Issued'),
  paid('Paid'),
  overdue('Overdue');

  const InvoiceStatus(this.name);

  final String name;

  @override
  String toString() => name;
}

@immutable
class ProvidedService implements Comparable<ProvidedService> {
  const ProvidedService({
    required this.number,
    required this.name,
    required this.amount,
  });

  final int number;

  final String name;

  final Money amount;

  ProvidedService copyWith({
    int? number,
    String? name,
    Money? amount,
  }) =>
      ProvidedService(
        number: number ?? this.number,
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );

  @override
  int compareTo(covariant ProvidedService other) => number.compareTo(other.number);

  @override
  int get hashCode => number ^ name.hashCode ^ amount.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvidedService && number == other.number && name == other.name && amount == other.amount;

  @override
  String toString() => 'ProvidedService{name: $name}';
}
