import 'package:invoice/src/feature/organizations/model/organization.dart';
import 'package:meta/meta.dart';

/// {@template organizations_state}
/// OrganizationsState.
/// {@endtemplate}
sealed class OrganizationsState extends _$OrganizationsStateBase {
  /// {@macro organizations_state}
  const OrganizationsState({required super.data, required super.message});

  /// Idling state
  /// {@macro organizations_state}
  const factory OrganizationsState.idle({
    required List<Organization> data,
    String message,
  }) = OrganizationsState$Idle;

  /// Processing
  /// {@macro organizations_state}
  const factory OrganizationsState.processing({
    required List<Organization> data,
    String message,
  }) = OrganizationsState$Processing;

  /// Successful
  /// {@macro organizations_state}
  const factory OrganizationsState.successful({
    required List<Organization> data,
    String message,
  }) = OrganizationsState$Successful;

  /// An error has occurred
  /// {@macro organizations_state}
  const factory OrganizationsState.error({
    required List<Organization> data,
    String message,
  }) = OrganizationsState$Error;
}

/// Idling state
final class OrganizationsState$Idle extends OrganizationsState {
  const OrganizationsState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
final class OrganizationsState$Processing extends OrganizationsState {
  const OrganizationsState$Processing({required super.data, super.message = 'Processing'});
}

/// Successful
final class OrganizationsState$Successful extends OrganizationsState {
  const OrganizationsState$Successful({required super.data, super.message = 'Successful'});
}

/// Error
final class OrganizationsState$Error extends OrganizationsState {
  const OrganizationsState$Error({required super.data, super.message = 'An error has occurred.'});
}

/// Pattern matching for [OrganizationsState].
typedef OrganizationsStateMatch<R, S extends OrganizationsState> = R Function(S state);

@immutable
abstract base class _$OrganizationsStateBase {
  const _$OrganizationsStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final List<Organization> data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [OrganizationsState].
  R map<R>({
    required OrganizationsStateMatch<R, OrganizationsState$Idle> idle,
    required OrganizationsStateMatch<R, OrganizationsState$Processing> processing,
    required OrganizationsStateMatch<R, OrganizationsState$Successful> successful,
    required OrganizationsStateMatch<R, OrganizationsState$Error> error,
  }) =>
      switch (this) {
        OrganizationsState$Idle s => idle(s),
        OrganizationsState$Processing s => processing(s),
        OrganizationsState$Successful s => successful(s),
        OrganizationsState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [OrganizationsState].
  R maybeMap<R>({
    required R Function() orElse,
    OrganizationsStateMatch<R, OrganizationsState$Idle>? idle,
    OrganizationsStateMatch<R, OrganizationsState$Processing>? processing,
    OrganizationsStateMatch<R, OrganizationsState$Successful>? successful,
    OrganizationsStateMatch<R, OrganizationsState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [OrganizationsState].
  R? mapOrNull<R>({
    OrganizationsStateMatch<R, OrganizationsState$Idle>? idle,
    OrganizationsStateMatch<R, OrganizationsState$Processing>? processing,
    OrganizationsStateMatch<R, OrganizationsState$Successful>? successful,
    OrganizationsStateMatch<R, OrganizationsState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() => 'OrganizationsState(data: $data, message: $message)';
}
