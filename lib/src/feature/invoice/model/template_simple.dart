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
      margin: pw.EdgeInsets.zero,
      /* margin: const pw.EdgeInsets.fromLTRB(
        PdfPageFormat.inch * 0.5,
        PdfPageFormat.inch * 0.25,
        PdfPageFormat.inch * 0.5,
        PdfPageFormat.inch * 0.25,
      ), */
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
        header: (context) => pw.SizedBox(height: PdfPageFormat.inch * 0.5),
        // --- Page Footer --- //
        footer: (context) => context.pagesCount == 1
            ? pw.SizedBox(
                height: PdfPageFormat.inch * 0.75,
              )
            : pw.Padding(
                padding: const pw.EdgeInsets.only(
                  bottom: PdfPageFormat.inch * 0.5,
                  top: PdfPageFormat.inch * 0.25,
                  right: PdfPageFormat.inch * 0.5,
                  left: PdfPageFormat.inch * 0.5,
                ),
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    '${context.pageNumber}/${context.pagesCount}',
                    style: const pw.TextStyle(
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
        // --- Body --- //
        build: (context) => <pw.Widget>[
          // --- Invoice Header --- //

          _InvoiceTemplate$Simple$PageHeader(
            invoice: invoice,
            logo: logo,
            color: PdfColor.fromInt(color),
          ),

          pw.SizedBox(height: PdfPageFormat.inch * 0.25),

          // --- Organization --- //

          if (invoice.organization case Organization organization)
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.inch * 0.5),
              child: _InvoiceTemplate$Simple$InvoiceOrganization(
                organization: organization,
              ),
            ),

          pw.SizedBox(height: PdfPageFormat.inch * 0.25),

          // --- Invoice description --- //
          if (invoice.description case String description when description.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.inch * 0.5),
              child: _InvoiceTemplate$Simple$InvoiceDescription(
                text: description,
              ),
            ),

          pw.SizedBox(height: PdfPageFormat.inch * 0.25),

          // --- Invoices table --- //
          if (invoice.services.isNotEmpty) ...<pw.Widget>[
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.inch * 0.5),
              child: _InvoiceTemplate$Simple$InvoicesTable(invoice: invoice),
            ),
            pw.SizedBox(height: PdfPageFormat.inch * 0.25),
            _InvoiceTemplate$Simple$InvoicesTotal(invoice: invoice),
          ],

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

class _InvoiceTemplate$Simple$InvoiceOrganization extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoiceOrganization({
    required this.organization,
  });

  final Organization organization;

  @override
  pw.Widget build(pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Text(
            organization.name,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              height: 1,
            ),
          ),
          if (organization.address case String address when address.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.RichText(
                text: pw.TextSpan(
                  text: 'Address: ',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    height: 1,
                  ),
                  children: <pw.TextSpan>[
                    pw.TextSpan(
                      text: address,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (organization.tax case String tax when tax.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.RichText(
                text: pw.TextSpan(
                  text: 'Tax identification number: ',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    height: 1,
                  ),
                  children: <pw.TextSpan>[
                    pw.TextSpan(
                      text: tax,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
}

class _InvoiceTemplate$Simple$InvoiceDescription extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoiceDescription({
    required this.text,
  });

  final String text;

  @override
  pw.Widget build(pw.Context context) => pw.Text(
        text,
        textAlign: pw.TextAlign.justify,
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.normal,
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
          fontSize: 12,
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
          border: pw.TableBorder.all(
            color: PdfColors.white,
            width: 2,
            style: pw.BorderStyle.solid,
          ),
          headerAlignments: <int, pw.AlignmentGeometry>{
            0: pw.Alignment.center,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
          },
          rowDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey100),
          oddRowDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey50),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.red600),
          headers: <pw.Widget>[
            pw.Text(
              'No.',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
            pw.Text(
              'Description',
              textAlign: pw.TextAlign.left,
              style: pw.TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
            pw.Text(
              'Amount',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
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
                  style: const pw.TextStyle(
                    fontSize: 12,
                    height: 1,
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 8),
                  child: pw.Text(
                    service.name,
                    maxLines: 1,
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(
                      fontSize: 12,
                      height: 1,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 8),
                  child: pw.Text(
                    service.amount.toString(),
                    maxLines: 1,
                    textAlign: pw.TextAlign.right,
                    style: const pw.TextStyle(
                      fontSize: 12,
                      height: 1,
                    ),
                  ),
                ),
              ],
          ],
        ),
      );
}

class _InvoiceTemplate$Simple$InvoicesTotal extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$InvoicesTotal({
    required this.invoice,
  });

  final Invoice invoice;

  @override
  pw.Widget build(pw.Context context) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.SizedBox(
          height: 40,
          child: pw.DecoratedBox(
            decoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey800,
              shape: pw.BoxShape.rectangle,
              borderRadius: pw.BorderRadius.horizontal(left: pw.Radius.circular(20)),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(16, 8, PdfPageFormat.inch * 0.5, 8),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.min,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Text(
                    'Total:',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    invoice.total.toString(),
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

/* class _InvoiceTemplate$Simple$TextBlock extends pw.StatelessWidget {
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
} */

class _InvoiceTemplate$Simple$PageHeader extends pw.StatelessWidget {
  _InvoiceTemplate$Simple$PageHeader({
    required this.invoice,
    this.logo,
    this.color,
  });

  final pw.ImageProvider? logo;
  final PdfColor? color;
  final Invoice invoice;

  static final DateFormat _dateFormatter = DateFormat('d MMM yyyy');

  @override
  pw.Widget build(pw.Context context) => pw.DecoratedBox(
        decoration: const pw.BoxDecoration(
          color: PdfColors.blueGrey800,
        ),
        child: pw.SizedBox(
          width: double.infinity,
          height: 124,
          child: pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              vertical: PdfPageFormat.inch * 0.25,
              horizontal: PdfPageFormat.inch * 0.5,
            ),
            child: pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: <pw.Widget>[
                if (logo case pw.ImageProvider image)
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: const pw.Alignment(-.75, 0),
                      child: pw.FittedBox(
                        child: pw.Image(image),
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                  )
                else
                  pw.Spacer(flex: 1),
                pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.max,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: <pw.Widget>[
                      pw.Text(
                        'INVOICE',
                        maxLines: 1,
                        textAlign: pw.TextAlign.right,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 42,
                          fontWeight: pw.FontWeight.bold,
                          height: 1,
                          letterSpacing: -.5,
                        ),
                      ),
                      pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: <pw.Widget>[
                          pw.Text(
                            invoice.number,
                            maxLines: 1,
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          pw.Text(
                            _dateFormatter.format(invoice.issuedAt),
                            maxLines: 1,
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/* class _InvoiceTemplate$Simple$PageFooter extends pw.StatelessWidget {
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
} */
