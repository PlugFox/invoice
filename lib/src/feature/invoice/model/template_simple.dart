// ignore_for_file: always_put_control_body_on_new_line

part of 'template.dart';

class InvoiceTemplate$Simple extends InvoiceTemplate {
  const InvoiceTemplate$Simple({
    this.font = InvoiceTemplateFont.roboto,
    this.format = InvoiceTemplateFormat.a4,
    this.color = 0xFF000000,
  });

  @override
  String get name => 'Simple';

  @override
  final InvoiceTemplateFont font;

  @override
  final InvoiceTemplateFormat format;

  @override
  final int color;

  @override
  Widget get preview => const SizedBox.shrink(); // Image.asset('assets/images/invoice_simple.png');

  @override
  Future<Uint8List> buildPDF(Invoice invoice, Map<String, Object?> context) async {
    T extract<T>(String key, T Function() fallback) {
      final path = key.split('.');
      if (path.isEmpty) return fallback();
      Object? obj = context;
      for (final part in path) {
        if (obj is Map) {
          obj = obj[part];
        } else {
          return fallback();
        }
      }
      return switch (obj) {
        final T value => value,
        _ => fallback(),
      };
    }

    final doc = pw.Document(
      title: extract('title', () => 'Invoice'),
      subject: extract('subject', () => 'Invoice'),
      producer: extract('producer', () => ''),
      author: extract('author', () => ''),
      creator: extract('author', () => ''),
      keywords: extract('keywords', () => 'invoice'),
      theme: await InvoicesPDFResourcesHelper().getThemeDataFromFont(font),
      /* compress: ,
      deflate: ,
      metadata: ,
      pageMode: ,
      verbose: , */
    );

    // Create theme
    final pageTheme = pw.PageTheme(
      pageFormat: InvoicesPDFResourcesHelper().getPageFormat(format),
      orientation: pw.PageOrientation.portrait,
      margin: const pw.EdgeInsets.fromLTRB(
        PdfPageFormat.inch * 0.5,
        PdfPageFormat.inch * 0.25,
        PdfPageFormat.inch * 0.5,
        PdfPageFormat.inch * 0.25,
      ),
    );

    // Load the logo
    pw.ImageProvider? logo;
    try {
      switch (context['logo']) {
        case final Uint8List value:
          logo = pw.MemoryImage(value);
        case final pw.MemoryImage value:
          logo = value;
        case final pw.ImageProvider value:
          logo = value;
        default:
          /* logo = await rootBundle
              .load('assets/images/logo.png')
              .then<pw.MemoryImage>((bytes) => pw.MemoryImage(bytes.buffer.asUint8List())); */
          context['logo'] = logo;
      }
    } on Object catch (_, __) {
      logo = null;
    }

    doc.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        // --- Page Header --- //
        header: (context) => _InvoiceTemplate$Simple$PageHeader(
          logo: logo,
          color: PdfColor.fromInt(color),
        ),
        // --- Page Footer --- //
        footer: (context) => _InvoiceTemplate$Simple$PageFooter(
          invoice: invoice,
          color: PdfColor.fromInt(color),
        ),
        // --- Body --- //
        build: (context) => <pw.Widget>[
          // --- Invoice Header --- //
          _InvoiceTemplate$Simple$InvoiceInfo(
            invoice: invoice,
            color: PdfColor.fromInt(color),
          ),

          // --- Invoice description --- //
          pw.SizedBox(height: 24),
          _InvoiceTemplate$Simple$InvoiceDescription(
            text: '____ ______ _____ ____ ______ _____ ___\n'
                '___ __ ______ ___ ____ ___ ____ ___ ______\n'
                '_________ _________ ______\n'
                '_____ _______ _______ __________ ____ _________\n'
                '__ _______ _______ __________ _____\n'
                '___ __ ______ ___ ____ ___ ____ ___ ______\n'
                '_________ _________ ______\n'
                '_____ _______ _______ __________ ____ _________\n'
                '__ _______ _______ __________ _____\n'
                '______ _____ __ ____ ___',
          ),

          // --- Invoices table --- //
          pw.SizedBox(height: 24),
          _InvoiceTemplate$Simple$InvoicesTable(invoice: invoice),

          // --- Terms and conditions --- //
          /* if (data['termsAndConditions'] case final String? value)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 24),
              child: _InvoiceTemplate$Simple$TextBlock(
                label: 'Terms and conditions',
                text: value,
              ),
            ), */

          // --- Notes --- //
          /* if (data['notes'] case final String value)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 24),
              child: _InvoiceTemplate$Simple$TextBlock(
                label: 'Notes',
                text: value,
              ),
            ), */
        ],
      ),
    );
    return doc.save();
  }

  @override
  InvoiceTemplate copyWith({
    InvoiceTemplateFont? font,
    InvoiceTemplateFormat? format,
    int? color,
  }) =>
      InvoiceTemplate$Simple(
        font: font ?? this.font,
        format: format ?? this.format,
        color: color ?? this.color,
      );
}

class _InvoiceTemplate$Simple$InvoiceInfo extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoiceInfo({
    required this.invoice,
    this.color,
  });

  final Invoice invoice;
  final PdfColor? color;

  @override
  pw.Widget build(pw.Context context) => pw.Inseparable(
        child: pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.SizedBox(
            width: 128,
            child: pw.DefaultTextStyle(
              style: pw.TextStyle(
                color: color,
                fontSize: 12,
                height: 1.2,
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(invoice.id.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Issued: ${invoice.issuedAt}'),
                  pw.Text('Due: ${invoice.dueAt}'),
                ],
              ),
            ),
          ),
        ),
      );
}

class _InvoiceTemplate$Simple$InvoiceDescription extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoiceDescription({
    required this.text,
  });

  final String text;

  @override
  pw.Widget build(pw.Context context) => pw.Inseparable(
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Align(
              child: pw.Text(
                'Invoice',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(text),
          ],
        ),
      );
}

class _InvoiceTemplate$Simple$InvoicesTable extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoicesTable({
    required this.invoice,
  });

  final Invoice invoice;

  @override
  pw.Widget build(pw.Context context) => pw.DefaultTextStyle(
        style: pw.TextStyle(
          fontSize: 10,
          height: 1,
          fontWeight: pw.FontWeight.normal,
        ),
        child: pw.TableHelper.fromTextArray(
          context: context,
          defaultColumnWidth: const pw.IntrinsicColumnWidth(flex: 1),
          columnWidths: <int, pw.TableColumnWidth>{
            0: const pw.FixedColumnWidth(50),
            1: const pw.FlexColumnWidth(5),
            2: const pw.FixedColumnWidth(150),
          },
          border: pw.TableBorder.all(),
          headerAlignments: <int, pw.AlignmentGeometry>{
            0: pw.Alignment.center,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
          },
          rowDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          oddRowDecoration: const pw.BoxDecoration(color: PdfColors.white),
          headers: <pw.Widget>[
            pw.Text(
              'No.',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Description',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Amount',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 12,
                height: 1,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
          cellAlignments: <int, pw.AlignmentGeometry>{
            0: pw.Alignment.center,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerRight,
          },
          data: <List<pw.Widget>>[
            // --- Rows --- //
            for (final service in invoice.services)
              <pw.Widget>[
                pw.Text(
                  service.number.toString(),
                  maxLines: 1,
                  textAlign: pw.TextAlign.center,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 8),
                  child: pw.Text(
                    service.name,
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 8),
                  child: pw.Text(
                    service.amount.toString(),
                    maxLines: 1,
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ],
          ],
        ),
      );
}

class _InvoiceTemplate$Simple$TextBlock extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$TextBlock({
    required this.label,
    required this.text,
  });

  final String label;
  final String? text;

  @override
  pw.Widget build(pw.Context context) => switch (text) {
        null => pw.SizedBox.shrink(),
        final String text when text.isEmpty => pw.SizedBox.shrink(),
        final String text => pw.Inseparable(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 8),
                  child: pw.Text(
                    label,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(text),
              ],
            ),
          ),
      };
}

class _InvoiceTemplate$Simple$PageHeader extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$PageHeader({
    this.logo,
    this.color,
  });

  final pw.ImageProvider? logo;
  final PdfColor? color;

  @override
  pw.Widget build(pw.Context context) => pw.Align(
        child: logo != null
            ? pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 16),
                child: pw.SizedBox(
                  height: 48,
                  child: pw.Image(logo!),
                ),
              )
            : null,
      );
}

class _InvoiceTemplate$Simple$PageFooter extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$PageFooter({
    required this.invoice,
    this.color,
  });

  final Invoice invoice;
  final PdfColor? color;

  @override
  pw.Widget build(pw.Context context) => pw.DefaultTextStyle(
        style: pw.TextStyle(
          color: color,
          fontSize: 8,
          height: 1,
        ),
        overflow: pw.TextOverflow.clip,
        child: pw.SizedBox(
          height: 72,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Divider(
                thickness: 1,
                height: 6,
                color: PdfColors.grey,
              ),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  '${context.pageNumber}/${context.pagesCount}',
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: <pw.Widget>[
                    // --- Address --- //
                    pw.SizedBox(width: 16),
                    pw.SizedBox(
                      width: 128,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Address', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          /* if (supplierAddress['country'] case final String value) pw.Text(value),
                          if (supplierAddress['state'] case final String value) pw.Text(value),
                          if (supplierAddress['city'] case final String value) pw.Text(value),
                          if (supplierAddress['street'] case final String value) pw.Text(value),
                          if (supplierAddress['zipCode'] case final String value) pw.Text(value), */
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    // --- Contacts --- //
                    pw.SizedBox(
                      width: 128,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          /* if (supplierContact['phone'] case final String value) ...[
                            pw.Text('Phone', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.Text(value),
                            pw.SizedBox(height: 4),
                          ],
                          if (supplierContact['email'] case final String value) ...[
                            pw.Text('Email', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.Text(value),
                          ], */
                        ],
                      ),
                    ),
                    pw.Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
