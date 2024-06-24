import 'package:invoice/src/feature/invoice/data/invoices_local_data_provider.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';

abstract interface class IInvoicesRepository {
  /// Get all invoices.
  /// Returns a list of invoices sorted by createdAt in descending order.
  /// If there are no invoices, an empty list is returned.
  /// Returns without services (use [getInvoiceById] to get services).
  Future<List<Invoice>> getAllInvoices();

  /// Get invoice by id.
  Future<Invoice> getInvoiceById(InvoiceId id);

  /// Create invoice.
  Future<Invoice> createInvoice();

  /// Update invoice.
  Future<Invoice> updateInvoice(Invoice invoice);

  /// Delete invoice by id.
  Future<void> deleteInvoiceById(InvoiceId id);
}

class InvoicesRepositoryImpl implements IInvoicesRepository {
  InvoicesRepositoryImpl({required IInvoicesLocalDataProvider localDataProvider})
      : _localDataProvider = localDataProvider;

  final IInvoicesLocalDataProvider _localDataProvider;

  @override
  Future<Invoice> createInvoice() => _localDataProvider.createInvoice();

  @override
  Future<void> deleteInvoiceById(InvoiceId id) => _localDataProvider.deleteInvoiceById(id);

  @override
  Future<List<Invoice>> getAllInvoices() => _localDataProvider.getAllInvoices();

  @override
  Future<Invoice> getInvoiceById(InvoiceId id) => _localDataProvider.getInvoiceById(id);

  @override
  Future<Invoice> updateInvoice(Invoice invoice) => _localDataProvider.updateInvoice(invoice);
}
