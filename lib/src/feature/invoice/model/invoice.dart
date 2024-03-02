import 'package:flutter/foundation.dart';
import 'package:invoice/src/feature/organization/model/organization.dart';
import 'package:money2/money2.dart';

typedef InvoiceId = int;

@immutable
class Invoice implements Comparable<Invoice> {
  const Invoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.issuedAt,
    required this.dueAt,
    required this.paidAt,
    required this.organization,
    required this.counterparty,
    required this.status,
    required this.number,
    required this.currency,
    required this.total,
    required this.services,
    required this.description,
  });

  final InvoiceId id;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime issuedAt;

  final DateTime? dueAt;

  final DateTime? paidAt;

  final Organization? organization;

  final Organization? counterparty;

  final InvoiceStatus status;

  final String? number;

  final Currency currency;

  final Money total;

  /// Services provided
  final List<ProvidedService> services;

  final String? description;

  @override
  int compareTo(covariant Invoice other) => other.createdAt.compareTo(createdAt);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Invoice && id == other.id && updatedAt == other.updatedAt && listEquals(services, other.services);
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
    required this.id,
    required this.name,
    required this.amount,
  });

  final int id;

  final String name;

  final Money amount;

  @override
  int compareTo(covariant ProvidedService other) => name.compareTo(other.name);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvidedService && id == other.id && name == other.name && amount == other.amount;
}
