import 'dart:async';

import 'package:control/control.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice/src/feature/organizations/controller/organizations_state.dart';
import 'package:invoice/src/feature/organizations/data/organizations_repository.dart';
import 'package:invoice/src/feature/organizations/model/organization.dart';

final class OrganizationsController extends StateController<OrganizationsState> with ConcurrentControllerHandler {
  OrganizationsController({
    required IOrganizationsRepository repository,
    /* OrganizationsState? state, */
  })  : _repository = repository,
        super(initialState: const OrganizationsState.idle(data: []));

  final IOrganizationsRepository _repository;

  /// Fetch organizations
  FutureOr<void> fetchOrganizations() => handle(
        () async {
          setState(OrganizationsState.processing(data: state.data));
          final organizations = await _repository.getAllOrganizations();
          setState(OrganizationsState.successful(data: organizations..sort()));
          setState(OrganizationsState.idle(data: state.data));
        },
        error: (error, stackTrace) {
          setState(OrganizationsState.error(
            data: state.data,
            message: kDebugMode ? error.toString() : 'An error has occurred',
          ));
        },
      );

  /// Fetch organization by id
  FutureOr<void> fetchOrganizationById(
    OrganizationId id, {
    void Function(Organization organization)? onSuccess,
  }) =>
      handle(
        () async {
          setState(OrganizationsState.processing(data: state.data));
          final organization = await _repository.getOrganizationById(id);
          final newData = state.data.toList();
          final index = newData.indexWhere((element) => element.id == id);
          if (index == -1) {
            newData.insert(0, organization);
          } else {
            newData[index] = organization;
          }
          setState(OrganizationsState.successful(data: newData..sort()));
          onSuccess?.call(organization);
        },
        error: (error, stackTrace) {
          setState(OrganizationsState.error(
            data: state.data,
            message: kDebugMode ? error.toString() : 'An error has occurred',
          ));
        },
      );

  /// Create new organization
  FutureOr<void> createOrganization({
    required String name,
    OrganizationType? type,
    String? address,
    String? tax,
    String? description,
    void Function(Organization organization)? onSuccess,
  }) {
    if (name.isEmpty) return null;
    return handle(() async {
      setState(OrganizationsState.processing(data: state.data));
      final organization = await _repository.createOrganization(
        name: name,
        type: type,
        address: address,
        tax: tax,
        description: description,
      );
      setState(OrganizationsState.successful(data: [organization, ...state.data]..sort()));
      onSuccess?.call(organization);
    }, error: (error, stackTrace) {
      setState(OrganizationsState.error(
        data: state.data,
        message: kDebugMode ? error.toString() : 'An error has occurred',
      ));
    }, done: () {
      setState(OrganizationsState.idle(data: state.data));
    });
  }

  /// Update organization
  FutureOr<void> updateOrganization({
    required Organization organization,
    void Function(Organization organization)? onSuccess,
  }) {
    if (organization.name.isEmpty) return null;
    return handle(() async {
      setState(OrganizationsState.processing(data: state.data));
      final updatedOrganization = await _repository.updateOrganization(organization);
      final newData = state.data.toList();
      final index = newData.indexWhere((element) => element.id == updatedOrganization.id);
      if (index == -1) {
        newData.insert(0, updatedOrganization);
      } else {
        newData[index] = updatedOrganization;
      }
      setState(OrganizationsState.successful(data: newData..sort()));
      onSuccess?.call(updatedOrganization);
    }, error: (error, stackTrace) {
      setState(OrganizationsState.error(
        data: state.data,
        message: kDebugMode ? error.toString() : 'An error has occurred',
      ));
    }, done: () {
      setState(OrganizationsState.idle(data: state.data));
    });
  }

  /// Delete organization
  FutureOr<void> deleteOrganization({
    required OrganizationId id,
    void Function()? onSuccess,
  }) =>
      handle(() async {
        setState(OrganizationsState.processing(data: state.data));
        await _repository.deleteOrganizationById(id);
        final newData = state.data.where((element) => element.id != id).toList(growable: false);
        setState(OrganizationsState.successful(data: newData));
        onSuccess?.call();
      }, error: (error, stackTrace) {
        setState(OrganizationsState.error(
          data: state.data,
          message: kDebugMode ? error.toString() : 'An error has occurred',
        ));
      }, done: () {
        setState(OrganizationsState.idle(data: state.data));
      });
}
