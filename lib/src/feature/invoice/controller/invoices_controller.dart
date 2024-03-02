import 'package:control/control.dart';
import 'package:meta/meta.dart';

/// {@template invoices_state_placeholder}
/// Entity placeholder for InvoicesState
/// {@endtemplate}
typedef InvoicesEntity = List<Invoice>;

/// {@template invoices_state}
/// InvoicesState.
/// {@endtemplate}
sealed class InvoicesState extends _$InvoicesStateBase {
  /// {@macro invoices_state}
  const InvoicesState({required super.data, required super.message});

  /// Idling state
  /// {@macro invoices_state}
  const factory InvoicesState.idle({
    required InvoicesEntity data,
    String message,
  }) = InvoicesState$Idle;

  /// Processing
  /// {@macro invoices_state}
  const factory InvoicesState.processing({
    required InvoicesEntity data,
    String message,
  }) = InvoicesState$Processing;

  /// Successful
  /// {@macro invoices_state}
  const factory InvoicesState.successful({
    required InvoicesEntity data,
    String message,
  }) = InvoicesState$Successful;

  /// An error has occurred
  /// {@macro invoices_state}
  const factory InvoicesState.error({
    required InvoicesEntity data,
    String message,
  }) = InvoicesState$Error;
}

/// Idling state
final class InvoicesState$Idle extends InvoicesState {
  const InvoicesState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
final class InvoicesState$Processing extends InvoicesState {
  const InvoicesState$Processing(
      {required super.data, super.message = 'Processing'});
}

/// Successful
final class InvoicesState$Successful extends InvoicesState {
  const InvoicesState$Successful(
      {required super.data, super.message = 'Successful'});
}

/// Error
final class InvoicesState$Error extends InvoicesState {
  const InvoicesState$Error(
      {required super.data, super.message = 'An error has occurred.'});
}

/// Pattern matching for [InvoicesState].
typedef InvoicesStateMatch<R, S extends InvoicesState> = R Function(S state);

@immutable
abstract base class _$InvoicesStateBase {
  const _$InvoicesStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final InvoicesEntity data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [InvoicesState].
  R map<R>({
    required InvoicesStateMatch<R, InvoicesState$Idle> idle,
    required InvoicesStateMatch<R, InvoicesState$Processing> processing,
    required InvoicesStateMatch<R, InvoicesState$Successful> successful,
    required InvoicesStateMatch<R, InvoicesState$Error> error,
  }) =>
      switch (this) {
        InvoicesState$Idle s => idle(s),
        InvoicesState$Processing s => processing(s),
        InvoicesState$Successful s => successful(s),
        InvoicesState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [InvoicesState].
  R maybeMap<R>({
    required R Function() orElse,
    InvoicesStateMatch<R, InvoicesState$Idle>? idle,
    InvoicesStateMatch<R, InvoicesState$Processing>? processing,
    InvoicesStateMatch<R, InvoicesState$Successful>? successful,
    InvoicesStateMatch<R, InvoicesState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [InvoicesState].
  R? mapOrNull<R>({
    InvoicesStateMatch<R, InvoicesState$Idle>? idle,
    InvoicesStateMatch<R, InvoicesState$Processing>? processing,
    InvoicesStateMatch<R, InvoicesState$Successful>? successful,
    InvoicesStateMatch<R, InvoicesState$Error>? error,
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
  String toString() => 'InvoicesState(data: $data, message: $message)';
}

final class InvoicesController extends StateController<InvoicesState>
    with ConcurrentControllerHandler {
  InvoicesController() : super(const InvoicesState());

  /* void fetchInvoices() => handle(); */
}
