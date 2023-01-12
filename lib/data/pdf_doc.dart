import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/models/billable_model.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfDoc {
  static Future<File> generatePdf({
    required String total,
    required ByteData imageSignature,
    required List<BillableModel> bill,
    required String taskName,
    required String recipientName,
  }) async {
    final document = PdfDocument();
    final page = document.pages.add();
    drawHeader(document, page, taskName, total);
    drawUsername(page, recipientName);
    drawName(page);
    drawGrid(page, bill);
    drawDocument(total, page, imageSignature);
    return saveFile(document, taskName);
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static void drawHeader(
      PdfDocument document, PdfPage page, String taskName, String total) async {
    PdfPageTemplateElement header = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 70));

    // header.graphics.drawRectangle(
    //     brush: PdfSolidBrush(PdfColor(80, 130, 210)),
    //     bounds: Rect.fromLTWH(0, 0, document.pageSettings.size.width, 60));
    final imageSignature = await rootBundle.load('assets/images/plogo.png');
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    header.graphics.drawImage(image, Rect.fromLTWH(10, 10, 40, 40));
    header.graphics.drawString('${taskName.toUpperCase()} INVOICE',
        PdfStandardFont(PdfFontFamily.helvetica, 25, style: PdfFontStyle.bold),
        brush: PdfBrushes.black,
        bounds:
            Rect.fromLTWH(100, 10, document.pageSettings.size.width - 300, 40));
    header.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(68, 114, 196)),
        bounds: Rect.fromLTWH(450, 0, 200, 60));
    header.graphics.drawString('AMOUNT\n\$$total',
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        brush: PdfBrushes.white,
        bounds:
            Rect.fromLTWH(470, 15, document.pageSettings.size.width - 300, 60));
//Add the header at top of the document
    document.template.top = header;
  }

  static void drawUsername(PdfPage page, String username) async {
    page.graphics.drawString(
        'Bill to: $username',
        PdfStandardFont(PdfFontFamily.helvetica, 15,
            style: PdfFontStyle.regular),
        // format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, 80, 0, 0));
  }

  static void drawName(PdfPage page) async {
    page.graphics.drawString(
        'Powered by Plan It',
        PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.italic),
        // format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(200, 120, 0, 0));
    final imageSignature = await rootBundle.load('assets/images/plogo.png');
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    page.graphics.drawImage(image, Rect.fromLTWH(310, 115, 20, 20));
  }

  static void drawGrid(PdfPage page, List<BillableModel> bill) {
    final grid = PdfGrid();
    grid.columns.add(count: 3);
    final headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Amount';
    headerRow.cells[1].value = 'From';
    headerRow.cells[2].value = 'To';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    bill.where((element) => element.amount! > 0).forEach((element) {
      final row = grid.rows.add();
      final singleAmount = element.end!.difference(element.start!).inSeconds /
          3600 *
          element.amount!;
      row.cells[0].value = '\$${singleAmount.toStringAsFixed(2)}';
      row.cells[1].value =
          '${Utils.toDate(element.start!)}\n${Utils.toTime(element.start!)}';
      row.cells[2].value =
          '${Utils.toDate(element.end!)}\n${Utils.toTime(element.end!)}';
    });
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final cell = row.cells[j];
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    grid.draw(page: page, bounds: Rect.fromLTWH(0, 150, 0, 0));
  }

  static void drawDocument(
      String total, PdfPage page, ByteData imageSignature) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    final price = '\$' + total;
    final now = DateFormat.yMMMEd().format(DateTime.now());
    final signatureText = '''Total: $price

$now''';
    page.graphics.drawString(
        signatureText, PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds:
            Rect.fromLTWH(pageSize.width - 240, pageSize.height - 200, 0, 0));
    page.graphics.drawImage(image,
        Rect.fromLTWH(pageSize.width - 120, pageSize.height - 200, 100, 40));
  }

  static Future<File> saveFile(PdfDocument document, String taskName) async {
    final path = await getApplicationDocumentsDirectory();
    final fileName = path.path + '/$taskName Invoice.pdf';
    final file = File(fileName);
    file.writeAsBytes(document.save());
    document.dispose();
    return file;
  }
}
