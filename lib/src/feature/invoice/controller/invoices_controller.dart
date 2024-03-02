import 'dart:async';

import 'package:control/control.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice/src/feature/invoice/controller/invoices_state.dart';
import 'package:invoice/src/feature/invoice/data/invoices_repository.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';

final class InvoicesController extends StateController<InvoicesState> with ConcurrentControllerHandler {
  InvoicesController({
    required IInvoicesRepository repository,
    /* InvoicesState? state, */
  })  : _repository = repository,
        super(initialState: const InvoicesState.idle(data: []));

  final IInvoicesRepository _repository;

  /// Fetch invoices
  FutureOr<void> fetchInvoices() => handle(
        () async {
          setState(InvoicesState.processing(data: state.data));
          final invoices = await _repository.getAllInvoices();
          setState(InvoicesState.successful(data: invoices..sort()));
          setState(InvoicesState.idle(data: state.data));
        },
        error: (error, stackTrace) {
          setState(InvoicesState.error(
            data: state.data,
            message: kDebugMode ? error.toString() : 'An error has occurred',
          ));
        },
      );

  /// Fetch invoice by id
  FutureOr<void> fetchInvoiceById(InvoiceId id) => handle(
        () async {
          setState(InvoicesState.processing(data: state.data));
          final invoice = await _repository.getInvoiceById(id);
          final newData = state.data.toList();
          final index = newData.indexWhere((element) => element.id == id);
          if (index == -1) {
            newData.insert(0, invoice);
          } else {
            newData[index] = invoice;
          }
          setState(InvoicesState.successful(data: newData..sort()));
        },
        error: (error, stackTrace) {
          setState(InvoicesState.error(
            data: state.data,
            message: kDebugMode ? error.toString() : 'An error has occurred',
          ));
        },
      );

  /// Create new invoice
  FutureOr<void> createInvoice({
    void Function(Invoice invoice)? onSuccess,
  }) =>
      handle(() async {
        setState(InvoicesState.processing(data: state.data));
        final invoice = await _repository.createInvoice();
        setState(InvoicesState.successful(data: [invoice, ...state.data]..sort()));
        onSuccess?.call(invoice);
      }, error: (error, stackTrace) {
        setState(InvoicesState.error(
          data: state.data,
          message: kDebugMode ? error.toString() : 'An error has occurred',
        ));
      }, done: () {
        setState(InvoicesState.idle(data: state.data));
      });

  /// Update invoice
  FutureOr<void> updateInvoice({
    required Invoice invoice,
    void Function(Invoice invoice)? onSuccess,
  }) =>
      handle(() async {
        setState(InvoicesState.processing(data: state.data));
        final updatedInvoice = await _repository.updateInvoice(invoice);
        final newData = state.data.toList();
        final index = newData.indexWhere((element) => element.id == updatedInvoice.id);
        if (index == -1) {
          newData.insert(0, updatedInvoice);
        } else {
          newData[index] = updatedInvoice;
        }
        setState(InvoicesState.successful(data: newData..sort()));
        onSuccess?.call(updatedInvoice);
      }, error: (error, stackTrace) {
        setState(InvoicesState.error(
          data: state.data,
          message: kDebugMode ? error.toString() : 'An error has occurred',
        ));
      }, done: () {
        setState(InvoicesState.idle(data: state.data));
      });

  /// Delete invoice
  FutureOr<void> deleteInvoice({
    required InvoiceId id,
    void Function(Invoice invoice)? onSuccess,
  }) =>
      handle(() async {
        setState(InvoicesState.processing(data: state.data));
        await _repository.deleteInvoiceById(id);
        final newData = state.data.where((element) => element.id != id).toList(growable: false);
        setState(InvoicesState.successful(data: newData));
        onSuccess?.call(state.data.firstWhere((element) => element.id == id));
      }, error: (error, stackTrace) {
        setState(InvoicesState.error(
          data: state.data,
          message: kDebugMode ? error.toString() : 'An error has occurred',
        ));
      }, done: () {
        setState(InvoicesState.idle(data: state.data));
      });
}
