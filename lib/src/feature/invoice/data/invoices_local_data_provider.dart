import 'package:invoice/src/common/database/database.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/organization/model/organization.dart';
import 'package:money2/money2.dart';

abstract interface class IInvoicesLocalDataProvider {
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

class InvoicesLocalDataProviderDriftImpl implements IInvoicesLocalDataProvider {
  InvoicesLocalDataProviderDriftImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<Invoice> createInvoice() =>
      _db.into(_db.invoiceTbl).insert(InvoiceTblCompanion.insert(), mode: InsertMode.insert).then(getInvoiceById);

  @override
  Future<void> deleteInvoiceById(InvoiceId id) => _db.transaction(() async {
        await (_db.delete(_db.invoiceTbl)..where((tbl) => tbl.id.equals(id))).go();
        await (_db.delete(_db.serviceTbl)..where((tbl) => tbl.invoiceId.equals(id))).go();
      });

  @override
  Future<List<Invoice>> getAllInvoices() async {
    final organization = _db.alias(_db.organizationTbl, 'organization');
    final counterparty = _db.alias(_db.organizationTbl, 'counterparty');
    final rows = await (_db.select(_db.invoiceTbl).join([
      leftOuterJoin(organization, organization.id.equalsExp(_db.invoiceTbl.organizationId)),
      leftOuterJoin(counterparty, counterparty.id.equalsExp(_db.invoiceTbl.counterpartyId)),
    ])
          ..orderBy([OrderingTerm.desc(_db.invoiceTbl.createdAt)]))
        .get();
    return List<Invoice>.generate(rows.length, (i) {
      final row = rows[i];
      final invoiceRow = row.readTableOrNull(_db.invoiceTbl)!;
      final organizationRow = row.readTableOrNull(organization);
      final counterpartyRow = row.readTableOrNull(counterparty);
      return _decodeInvoice(
        inv: invoiceRow,
        org: organizationRow,
        cnt: counterpartyRow,
      );
    });
  }

  @override
  Future<Invoice> getInvoiceById(InvoiceId id) => _db.transaction<Invoice>(() async {
        final organization = _db.alias(_db.organizationTbl, 'organization');
        final counterparty = _db.alias(_db.organizationTbl, 'counterparty');
        final result = await (_db.select(_db.invoiceTbl).join([
          leftOuterJoin(organization, organization.id.equalsExp(_db.invoiceTbl.organizationId)),
          leftOuterJoin(counterparty, counterparty.id.equalsExp(_db.invoiceTbl.counterpartyId)),
        ])
              ..where(_db.invoiceTbl.id.equals(id))
              ..limit(1))
            .getSingleOrNull();
        if (result == null) throw Exception('Invoice not found');
        final invoiceRow = result.readTableOrNull(_db.invoiceTbl);
        if (invoiceRow == null) throw Exception('Invoice not found');
        final organizationRow = result.readTableOrNull(organization);
        final counterpartyRow = result.readTableOrNull(counterparty);
        final services = await (_db.select(_db.serviceTbl)..where((tbl) => tbl.invoiceId.equals(id))).get();
        return _decodeInvoice(
          inv: invoiceRow,
          org: organizationRow,
          cnt: counterpartyRow,
          srv: services,
        );
      });

  @override
  Future<Invoice> updateInvoice(Invoice invoice) {
    final data = _encodeInvoice(invoice);
    return _db.transaction(() async {
      await _db.update(_db.invoiceTbl).replace(data.invoice);
      await (_db.delete(_db.serviceTbl)..where((tbl) => tbl.invoiceId.equals(invoice.id))).go();
      await _db.batch((b) => b.insertAll(_db.serviceTbl, data.services, mode: InsertMode.insertOrReplace));
    }).then((_) => getInvoiceById(invoice.id));
  }
}

Invoice _decodeInvoice({
  required InvoiceTblData inv,
  OrganizationTblData? org,
  OrganizationTblData? cnt,
  List<ServiceTblData> srv = const [],
}) {
  DateTime decodeDateTime(int unixtime) => DateTime.fromMillisecondsSinceEpoch(unixtime * 1000);
  DateTime? decodeDateTimeNullable(int? timestamp) => switch (timestamp) {
        int unixtime => DateTime.fromMillisecondsSinceEpoch(unixtime * 1000),
        null => null,
      };
  Organization? decodeOrganization(OrganizationTblData? org) => switch (org) {
        OrganizationTblData it => Organization(
            id: it.id,
            name: it.name,
            address: it.address,
            createdAt: decodeDateTime(it.createdAt),
            updatedAt: decodeDateTime(it.updatedAt),
            inn: it.inn,
            description: it.description,
            type: OrganizationType.values[it.type],
          ),
        null => null,
      };
  final total = Money.fromInt(inv.total, code: inv.currency);
  return Invoice(
    id: inv.id,
    createdAt: decodeDateTime(inv.createdAt),
    updatedAt: decodeDateTime(inv.updatedAt),
    issuedAt: decodeDateTime(inv.issuedAt),
    dueAt: decodeDateTimeNullable(inv.dueAt),
    paidAt: decodeDateTimeNullable(inv.paidAt),
    organization: decodeOrganization(org),
    counterparty: decodeOrganization(cnt),
    status: InvoiceStatus.values[inv.status],
    number: inv.number,
    currency: total.currency,
    total: total,
    description: inv.description,
    services: <ProvidedService>[
      for (final service in srv)
        ProvidedService(
          id: service.id,
          name: service.name,
          amount: Money.fromInt(service.amount, code: inv.currency),
        ),
    ]..sort(),
  );
}

({InvoiceTblCompanion invoice, List<ServiceTblCompanion> services}) _encodeInvoice(Invoice inv) {
  Value<int> encodeDateTime(DateTime dt) => Value(dt.millisecondsSinceEpoch ~/ 1000);
  Value<int?> encodeDateTimeNullable(DateTime? dt) => switch (dt) {
        DateTime dt => Value(dt.millisecondsSinceEpoch ~/ 1000),
        null => const Value.absent(),
      };
  return (
    invoice: InvoiceTblCompanion(
      id: Value(inv.id),
      createdAt: encodeDateTime(inv.createdAt),
      updatedAt: encodeDateTime(inv.updatedAt),
      issuedAt: encodeDateTime(inv.issuedAt),
      dueAt: encodeDateTimeNullable(inv.dueAt),
      paidAt: encodeDateTimeNullable(inv.paidAt),
      organizationId: Value(inv.organization?.id),
      counterpartyId: Value(inv.counterparty?.id),
      status: Value(InvoiceStatus.values.indexOf(inv.status)),
      number: Value(inv.number),
      currency: Value(inv.currency.code),
      total: Value(inv.total.minorUnits.toInt()),
      description: Value(inv.description),
    ),
    services: <ServiceTblCompanion>[
      for (final service in inv.services)
        ServiceTblCompanion.insert(
          id: Value(service.id),
          invoiceId: inv.id,
          name: service.name,
          amount: service.amount.minorUnits.toInt(),
        ),
    ],
  );
}
