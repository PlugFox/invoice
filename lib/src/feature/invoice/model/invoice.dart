import 'package:invoice/src/feature/organization/model/organization.dart';
import 'package:meta/meta.dart';

@immutable
class Invoice implements Comparable<Invoice> {
  const Invoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isseuedAt,
    required this.dueAt,
    required this.paidAt,
    required this.organization,
    required this.counterparty,
    required this.status,
    required this.number,
    required this.currency,
    required this.total,
    required this.description,
  });

  final int id;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime isseuedAt;

  final DateTime? dueAt;

  final DateTime? paidAt;

  final Organization? organization;

  final Organization? counterparty;

  final InvoiceStatus status;

  final String number;

  final String currency;

  final double total;

  final String? description;

  @override
  int compareTo(covariant Invoice other) =>
      createdAt.compareTo(other.createdAt);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Invoice && id == other.id;
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
