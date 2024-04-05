import 'package:invoice/src/common/database/database.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';

/// Interface for local data provider of organizations.
abstract interface class IOrganizationsLocalDataProvider {
  /// Get all organizations.
  /// Returns a list of organizations sorted by createdAt in descending order.
  /// If there are no organizations, an empty list is returned.
  /// Returns without services (use [getOrganizationById] to get services).
  Future<List<Organization>> getAllOrganizations();

  /// Get organization by id.
  Future<Organization> getOrganizationById(OrganizationId id);

  /// Create organization.
  Future<Organization> createOrganization({
    required String name,
    OrganizationType? type,
    String? address,
    String? tax,
    String? description,
  });

  /// Update organization.
  Future<Organization> updateOrganization(Organization organization);

  /// Delete organization by id.
  Future<void> deleteOrganizationById(OrganizationId id);
}

class OrganizationsLocalDataProviderDriftImpl implements IOrganizationsLocalDataProvider {
  OrganizationsLocalDataProviderDriftImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<Organization> createOrganization({
    required String name,
    OrganizationType? type,
    String? address,
    String? tax,
    String? description,
  }) {
    Value<String?> mullIfEmpty(String? value) =>
        value == null || value.isEmpty ? const Value<String?>(null) : Value<String?>(value);
    return _db
        .into(_db.organizationTbl)
        .insert(
          OrganizationTblCompanion.insert(
            name: name,
            type: Value<int>.absentIfNull(type?.index),
            address: mullIfEmpty(address),
            tax: mullIfEmpty(tax),
            description: mullIfEmpty(description),
          ),
          mode: InsertMode.insert,
        )
        .then(getOrganizationById);
  }

  @override
  Future<void> deleteOrganizationById(OrganizationId id) =>
      (_db.update(_db.organizationTbl)..where((tbl) => tbl.id.equals(id)))
          .write(const OrganizationTblCompanion(deleted: Value(1)));

  @override
  Future<List<Organization>> getAllOrganizations() async {
    final rows = await (_db.select(_db.organizationTbl)
          ..where((tbl) => tbl.deleted.equals(0))
          ..orderBy([(u) => OrderingTerm.asc(u.name)]))
        .get();
    return rows.map(_decodeOrganization).toList(growable: false);
  }

  @override
  Future<Organization> getOrganizationById(OrganizationId id) => _db.transaction<Organization>(() async {
        final row = await (_db.select(_db.organizationTbl)
              ..where((tbl) => tbl.id.equals(id))
              ..limit(1))
            .getSingleOrNull();
        if (row == null) throw Exception('Organization not found');
        return _decodeOrganization(row);
      });

  @override
  Future<Organization> updateOrganization(Organization organization) => _db
      .update(_db.organizationTbl)
      .replace(_encodeOrganization(organization))
      .then((_) => getOrganizationById(organization.id));
}

Organization _decodeOrganization(OrganizationTblData org) {
  DateTime decodeDateTime(int unixtime) => DateTime.fromMillisecondsSinceEpoch(unixtime * 1000);
  return Organization(
    id: org.id,
    name: org.name,
    address: org.address,
    createdAt: decodeDateTime(org.createdAt),
    updatedAt: decodeDateTime(org.updatedAt),
    tax: org.tax,
    description: org.description,
    type: OrganizationType.values[org.type],
  );
}

OrganizationTblCompanion _encodeOrganization(Organization inv) {
  Value<String?> mullIfEmpty(String? value) =>
      value == null || value.isEmpty ? const Value<String?>(null) : Value<String?>(value);
  return OrganizationTblCompanion(
    id: Value(inv.id),
    deleted: const Value<int>.absent(),
    createdAt: const Value<int>.absent(),
    updatedAt: const Value<int>.absent(),
    name: Value<String>(inv.name),
    type: Value<int>(inv.type.index),
    description: mullIfEmpty(inv.description),
    address: mullIfEmpty(inv.address),
    tax: mullIfEmpty(inv.tax),
  );
}
