// ignore_for_file: always_put_control_body_on_new_line

import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:invoice/src/feature/invoice/model/template.dart';
import 'package:money2/money2.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

@immutable
final class InvoicePDFState {
  const InvoicePDFState({
    required this.template,
    required this.invoice,
    required this.pdf,
    required this.context,
    this.loading = false,
    this.error,
  });

  /// Invoices template
  final InvoiceTemplate template;

  /// Invoices data
  final Invoice invoice;

  /// PDF data
  final Uint8List pdf;

  /// Processing state
  final bool loading;

  /// Error message
  final String? error;

  /// Check if the PDF is not empty
  bool get hasPDF => pdf.isNotEmpty;

  /// Check if there is an error
  bool get hasError => error != null;

  /// Persistent context
  final Map<String, Object?> context;
}

class InvoicePDFController with ChangeNotifier implements ValueListenable<InvoicePDFState> {
  InvoicePDFController({InvoicePDFState? state})
      : _state = state ??
            InvoicePDFState(
              template: const InvoiceTemplate.simple(),
              invoice: Invoice(
                id: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                issuedAt: DateTime.now(),
                dueAt: null,
                paidAt: null,
                organization: null,
                counterparty: null,
                status: InvoiceStatus.draft,
                total: Money.fromInt(0, isoCode: 'USD'),
                services: const [],
                description: '',
              ),
              pdf: Uint8List(0),
              context: const <String, Object?>{},
            );

  InvoicePDFState _state;
  Timer? _throttleTimer;
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  @override
  InvoicePDFState get value => _state;

  void _setState(InvoicePDFState state) {
    if (_isDisposed) return;
    _state = state;
    notifyListeners();
  }

  /// Set the new template
  void setTemplate(InvoiceTemplate template) {
    if (_isDisposed) return;
    _setState(
      InvoicePDFState(
        template: template,
        invoice: _state.invoice,
        pdf: _state.pdf,
        context: _state.context,
        loading: true,
        error: _state.error,
      ),
    );
  }

  /// Rebuild the PDF
  Future<void> rebuild(Invoice invoice, [Map<String, Object?>? context]) async {
    if (_isDisposed) return;
    final mutableContext = <String, Object?>{
      ..._state.context,
      ...?context,
    };
    _setState(
      InvoicePDFState(
        template: _state.template,
        invoice: invoice,
        pdf: _state.pdf,
        context: UnmodifiableMapView<String, Object?>(mutableContext),
        loading: true,
        error: _state.error,
      ),
    );
    try {
      /* final json = const JsonEncoder.withIndent('  ').convert(snapshot.toJson());
      print(json); */
      final newPdf = await _state.template.buildPDF(invoice, mutableContext);
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: newPdf,
          context: UnmodifiableMapView<String, Object?>(mutableContext),
        ),
      );
    } on Object catch (error, _) {
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: _state.pdf,
          context: _state.context,
          error: kDebugMode ? error.toString() : 'An error occurred while generating the PDF.',
        ),
      );
    }
    return;
  }

  /// Share the PDF
  Future<void> share([Map<String, Object?>? context]) async {
    if (_isDisposed) return;
    final mutableContext = <String, Object?>{
      ..._state.context,
      ...?context,
    };
    _setState(
      InvoicePDFState(
        template: _state.template,
        invoice: value.invoice,
        pdf: _state.pdf,
        context: UnmodifiableMapView<String, Object?>(mutableContext),
        loading: true,
        error: _state.error,
      ),
    );
    try {
      /* final json = const JsonEncoder.withIndent('  ').convert(snapshot.toJson());
      print(json); */
      final dateFormat = DateFormat('d MMMM yyyy');
      final newPdf = await _state.template.buildPDF(value.invoice, mutableContext);
      await Printing.sharePdf(
        bytes: newPdf,
        filename: '${_state.invoice.organization?.name} - ${dateFormat.format(_state.invoice.issuedAt)} invoice.pdf',
        /* bounds: bounds,
        body: body,
        subject: subject,
        emails: emails, */
      );
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: newPdf,
          context: UnmodifiableMapView<String, Object?>(mutableContext),
        ),
      );
    } on Object catch (error, _) {
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: _state.pdf,
          context: _state.context,
          error: kDebugMode ? error.toString() : 'An error occurred while generating the PDF.',
        ),
      );
    }
  }

  /// Print the PDF
  Future<bool> layout([Map<String, Object?>? context]) async {
    if (_isDisposed) return false;
    final mutableContext = <String, Object?>{
      ..._state.context,
      ...?context,
    };
    _setState(
      InvoicePDFState(
        template: _state.template,
        invoice: _state.invoice,
        pdf: _state.pdf,
        context: UnmodifiableMapView<String, Object?>(mutableContext),
        loading: true,
        error: _state.error,
      ),
    );
    try {
      final dateFormat = DateFormat('d MMMM yyyy');
      final result = Printing.layoutPdf(
        onLayout: (format) => _state.template.buildPDF(
          _state.invoice,
          mutableContext,
        ),
        name: '${_state.invoice.organization?.name} - ${dateFormat.format(_state.invoice.issuedAt)} invoice.pdf',
        format: switch (_state.template.format) {
          InvoiceTemplateFormat.a4 => PdfPageFormat.a4,
          InvoiceTemplateFormat.letter => PdfPageFormat.letter,
        },
      );
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: _state.pdf,
          context: UnmodifiableMapView<String, Object?>(mutableContext),
        ),
      );
      return result;
    } on Object catch (error, _) {
      _setState(
        InvoicePDFState(
          template: _state.template,
          invoice: _state.invoice,
          pdf: _state.pdf,
          context: _state.context,
          error: kDebugMode ? error.toString() : 'An error occurred while generating the PDF.',
        ),
      );
      return false;
    }
  }

  /// Convert the PDF to images
  Future<List<Uint8List>> images() {
    if (_state.pdf.isEmpty) return Future.value(<Uint8List>[]);
    return Printing.raster(_state.pdf).asyncMap((img) => img.toPng()).toList();
  }

  @override
  void dispose() {
    _throttleTimer?.cancel();
    _throttleTimer = null;
    _state = InvoicePDFState(
      template: _state.template,
      invoice: _state.invoice,
      pdf: _state.pdf,
      context: const <String, Object?>{},
    );
    _isDisposed = true;
    super.dispose();
  }
}
