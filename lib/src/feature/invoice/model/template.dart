// ignore_for_file: always_put_control_body_on_new_line

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/src/feature/invoice/model/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

part 'template_simple.dart';

/// ResumePdfResources Singleton class
class InvoicesPDFResourcesHelper {
  factory InvoicesPDFResourcesHelper() => _internalSingleton;
  InvoicesPDFResourcesHelper._internal();
  static final InvoicesPDFResourcesHelper _internalSingleton = InvoicesPDFResourcesHelper._internal();

  static final Map<InvoiceTemplateFont, pw.ThemeData> _themeDataCache = <InvoiceTemplateFont, pw.ThemeData>{};

  /// Get the color from the template color
  PdfColor decodeColor(Object color) {
    if (color is PdfColor) return color;
    switch (color) {
      case final int value:
        return PdfColor.fromInt(value);
      case 'red':
        return PdfColors.red;
      case 'pink':
        return PdfColors.pink;
      case 'purple':
        return PdfColors.purple;
      case 'deepPurple':
        return PdfColors.deepPurple;
      case 'indigo':
        return PdfColors.indigo;
      case 'blue':
        return PdfColors.blue;
      case 'lightBlue':
        return PdfColors.lightBlue;
      case 'cyan':
        return PdfColors.cyan;
      case 'teal':
        return PdfColors.teal;
      case 'green':
        return PdfColors.green;
      case 'lightGreen':
        return PdfColors.lightGreen;
      case 'lime':
        return PdfColors.lime;
      case 'yellow':
        return PdfColors.yellow;
      case 'amber':
        return PdfColors.amber;
      case 'orange':
        return PdfColors.orange;
      case 'deepOrange':
        return PdfColors.deepOrange;
      case 'brown':
        return PdfColors.brown;
      case 'grey':
        return PdfColors.grey;
      case 'blueGrey':
        return PdfColors.blueGrey;
      case 'redAccent':
        return PdfColors.redAccent;
      case 'pinkAccent':
        return PdfColors.pinkAccent;
      case 'purpleAccent':
        return PdfColors.purpleAccent;
      case 'deepPurpleAccent':
        return PdfColors.deepPurpleAccent;
      case 'indigoAccent':
        return PdfColors.indigoAccent;
      case 'blueAccent':
        return PdfColors.blueAccent;
      case 'lightBlueAccent':
        return PdfColors.lightBlueAccent;
      case 'cyanAccent':
        return PdfColors.cyanAccent;
      case 'tealAccent':
        return PdfColors.tealAccent;
      case 'greenAccent':
        return PdfColors.greenAccent;
      case 'lightGreenAccent':
        return PdfColors.lightGreenAccent;
      case 'limeAccent':
        return PdfColors.limeAccent;
      case 'yellowAccent':
        return PdfColors.yellowAccent;
      case 'amberAccent':
        return PdfColors.amberAccent;
      case 'orangeAccent':
        return PdfColors.orangeAccent;
      case 'deepOrangeAccent':
        return PdfColors.deepOrangeAccent;
      case final String hex:
        return PdfColor.fromHex(hex);
      default:
        return PdfColors.grey;
    }
  }

  /// Get the page format from the template format
  PdfPageFormat getPageFormat(InvoiceTemplateFormat format) {
    switch (format) {
      case InvoiceTemplateFormat.a4:
        return PdfPageFormat.a4;
      case InvoiceTemplateFormat.letter:
        return PdfPageFormat.letter;
    }
  }

  /// Get the theme data from the font
  FutureOr<pw.ThemeData> getThemeDataFromFont(InvoiceTemplateFont font) async {
    var theme = _themeDataCache[font];
    if (theme != null) return theme;
    switch (font) {
      case InvoiceTemplateFont.roboto:
        theme = pw.ThemeData.withFont(
          base: await PdfGoogleFonts.robotoRegular(),
          bold: await PdfGoogleFonts.robotoBold(),
          italic: await PdfGoogleFonts.robotoItalic(),
          boldItalic: await PdfGoogleFonts.robotoBoldItalic(),
          icons: await PdfGoogleFonts.materialIcons(),
          fontFallback: <pw.Font>[
            pw.Font.courier(),
          ],
        );
      case InvoiceTemplateFont.helvetica:
        theme = pw.ThemeData.withFont(
          base: pw.Font.helvetica(),
          bold: pw.Font.helveticaBold(),
          italic: pw.Font.helveticaOblique(),
          boldItalic: pw.Font.helveticaBoldOblique(),
          icons: await PdfGoogleFonts.materialIcons(),
          fontFallback: <pw.Font>[
            pw.Font.helvetica(),
            await PdfGoogleFonts.robotoRegular(),
          ],
        );
    }
    return _themeDataCache[font] = theme;
  }
}

enum InvoiceTemplateFont implements Comparable<InvoiceTemplateFont> {
  roboto('Roboto'),
  helvetica('Helvetica');

  const InvoiceTemplateFont(this.name);

  /// Return the enum value from the index
  factory InvoiceTemplateFont.fromIndex(int index) {
    try {
      return values[index];
    } on Object {
      if (kDebugMode) rethrow;
      return roboto;
    }
  }

  /// Return the enum value from the name
  factory InvoiceTemplateFont.getByName(String name) => _byName[name.toUpperCase()] ?? InvoiceTemplateFont.roboto;

  /// Convert the enum value from json
  factory InvoiceTemplateFont.fromJson(String json) = InvoiceTemplateFont.getByName;

  /// Map of all available fonts
  static final Map<String, InvoiceTemplateFont> _byName = <String, InvoiceTemplateFont>{
    for (final font in values) font.name.toUpperCase(): font,
  };

  final String name;

  @override
  int compareTo(covariant InvoiceTemplateFont other) => index.compareTo(other.index);

  /// Convert the language proficiency level to json
  String toJson() => name.toUpperCase();

  @override
  String toString() => name;
}

enum InvoiceTemplateFormat implements Comparable<InvoiceTemplateFormat> {
  /// USA Letter format
  letter('Letter'),

  /// A4 format
  a4('A4');

  const InvoiceTemplateFormat(this.name);

  /// Return the enum value from the index
  factory InvoiceTemplateFormat.fromIndex(int index) {
    try {
      return values[index];
    } on Object {
      if (kDebugMode) rethrow;
      return letter;
    }
  }

  /// Return the enum value from the name
  factory InvoiceTemplateFormat.getByName(String name) => _byName[name.toUpperCase()] ?? InvoiceTemplateFormat.letter;

  /// Convert the enum value from json
  factory InvoiceTemplateFormat.fromJson(String json) = InvoiceTemplateFormat.getByName;

  /// Map of all available formats
  static final Map<String, InvoiceTemplateFormat> _byName = <String, InvoiceTemplateFormat>{
    for (final format in values) format.name.toUpperCase(): format,
  };

  final String name;

  @override
  int compareTo(covariant InvoiceTemplateFormat other) => index.compareTo(other.index);

  /// Convert the language proficiency level to json
  String toJson() => name.toUpperCase();

  @override
  String toString() => name;
}

@immutable
sealed class InvoiceTemplate {
  /// {@macro resume_template}
  const InvoiceTemplate();

  /// Create a new Faktura template with the given parameters
  const factory InvoiceTemplate.simple({
    InvoiceTemplateFont font,
    InvoiceTemplateFormat format,
    int color,
  }) = InvoiceTemplate$Simple;

  /// Get a template by its name
  factory InvoiceTemplate.getByName(String name) =>
      _byName[name.trim().toUpperCase()] ?? const InvoiceTemplate.simple();

  factory InvoiceTemplate.fromJson(String value) = InvoiceTemplate.getByName;

  /// List of all available templates
  static List<InvoiceTemplate> values = <InvoiceTemplate>[
    const InvoiceTemplate.simple(),
  ];

  static final Map<String, InvoiceTemplate> _byName = <String, InvoiceTemplate>{
    for (final template in values) template.name.trim().toUpperCase(): template,
  };

  /// Name of the template
  abstract final String name;

  /// Font of the template
  abstract final InvoiceTemplateFont font;

  /// Format of the template
  abstract final InvoiceTemplateFormat format;

  /// Color of the template
  abstract final int color;

  /// Preview image of the template
  Widget get preview;

  /// Copy the template with the given parameters
  InvoiceTemplate copyWith({
    InvoiceTemplateFont? font,
    InvoiceTemplateFormat? format,
    int? color,
  });

  /// Build a PDF from the given data.
  /// Can throw errors.
  Future<Uint8List> buildPDF(Invoice invoice, Map<String, Object?> context);

  /// Convert class to Map<String, Object?>
  Map<String, Object?> toJson() => <String, Object?>{
        'type': name.toUpperCase(),
        'font': font.toJson(),
        'format': format.toJson(),
        'color': color,
      };

  @override
  String toString() => '$name{font: $font, format: $format, color: $color}';
}
