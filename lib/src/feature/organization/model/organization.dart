import 'package:meta/meta.dart';

@immutable
class Organization implements Comparable<Organization> {
  const Organization({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.name,
    required this.address,
    required this.inn,
    required this.description,
  });

  final int id;

  final DateTime createdAt;

  final DateTime updatedAt;

  final OrganizationType type;

  final String name;

  final String? address;

  final String? inn;

  final String? description;

  @override
  int compareTo(Organization other) => name.compareTo(other.name);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Organization && id == other.id;

  @override
  String toString() => 'Organization{id: $id, name: $name}';
}

enum OrganizationType {
  organization('Organization'),
  counterparty('Counterparty');

  const OrganizationType(this.name);

  final String name;

  @override
  String toString() => name;
}
