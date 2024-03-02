import 'dart:async';

import 'package:control/control.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_state.dart';
import 'package:invoice/src/feature/invoice/data/invoices_repository.dart';

final class InvoicesController extends StateController<InvoicesState> with ConcurrentControllerHandler {
  InvoicesController({
    required IInvoicesRepository repository,
    /* InvoicesState? state, */
  })  : _repository = repository,
        super(initialState: const InvoicesState.idle(data: []));

  final IInvoicesRepository _repository;

  FutureOr<void> fetchInvoices() => handle(
        () async {
          setState(const InvoicesState.processing());
          final invoices = await _repository.getAllInvoices();
          setState(const InvoicesState.successful(data: invoices));
          setState(const InvoicesState.idle(data: state.data));
        },
        error: (error, stackTrace) {
          setState(const InvoicesState.error(
            data: state.data,
            message: kDebugMode ? error.toString() : 'An error has occurred',
          ));
        },
      );
}
