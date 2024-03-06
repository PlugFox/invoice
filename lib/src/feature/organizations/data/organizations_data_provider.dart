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
  Future<Organization> createOrganization(String name);

  /// Update organization.
  Future<Organization> updateOrganization(Organization organization);

  /// Delete organization by id.
  Future<void> deleteOrganizationById(OrganizationId id);
}

class OrganizationsLocalDataProviderDriftImpl implements IOrganizationsLocalDataProvider {
  OrganizationsLocalDataProviderDriftImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<Organization> createOrganization(String name) => _db
      .into(_db.organizationTbl)
      .insert(OrganizationTblCompanion.insert(name: name), mode: InsertMode.insert)
      .then(getOrganizationById);

  @override
  Future<void> deleteOrganizationById(OrganizationId id) =>
      _db.update(_db.organizationTbl).replace(OrganizationTblCompanion(
            id: Value(id),
            deleted: const Value(1),
          ));

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
    inn: org.inn,
    description: org.description,
    type: OrganizationType.values[org.type],
  );
}

OrganizationTblCompanion _encodeOrganization(Organization inv) => OrganizationTblCompanion(
      id: Value(inv.id),
      deleted: const Value.absent(),
      createdAt: const Value.absent(),
      updatedAt: const Value.absent(),
      description: Value(inv.description),
      name: Value(inv.name),
      address: Value(inv.address),
      inn: Value(inv.inn),
      type: Value(inv.type.index),
    );
