import 'package:invoice/src/feature/organizations/data/organizations_data_provider.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';

abstract interface class IOrganizationsRepository {
  /// Get all organizations.
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

class OrganizationsRepositoryImpl implements IOrganizationsRepository {
  OrganizationsRepositoryImpl({required IOrganizationsLocalDataProvider localDataProvider})
      : _localDataProvider = localDataProvider;

  final IOrganizationsLocalDataProvider _localDataProvider;

  @override
  Future<Organization> createOrganization({
    required String name,
    OrganizationType? type,
    String? address,
    String? tax,
    String? description,
  }) =>
      _localDataProvider.createOrganization(
        name: name,
        type: type,
        address: address,
        tax: tax,
        description: description,
      );

  @override
  Future<void> deleteOrganizationById(OrganizationId id) => _localDataProvider.deleteOrganizationById(id);

  @override
  Future<List<Organization>> getAllOrganizations() => _localDataProvider.getAllOrganizations();

  @override
  Future<Organization> getOrganizationById(OrganizationId id) => _localDataProvider.getOrganizationById(id);

  @override
  Future<Organization> updateOrganization(Organization organization) =>
      _localDataProvider.updateOrganization(organization);
}
