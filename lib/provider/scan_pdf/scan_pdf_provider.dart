import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/cupertino.dart';

class ScanPdfProvider with ChangeNotifier {
  PDFDocument? _scannedDocument;
  PDFDocument? get scannedDocument => _scannedDocument;

  File? _scannedDocumentFile;
  File? get scannedDocumentFile => _scannedDocumentFile;

  File? _scannedImage;
  File? get scannedImage => _scannedImage;

  openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
            "Only {PAGES_COUNT} Page"
      },

      //source: ScannerFileSource.CAMERA
    );
    notifyListeners();
    if (doc != null) {
      _scannedDocument = null;

      await Future.delayed(Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
      _scannedDocument = await PDFDocument.fromFile(doc);
    }
    notifyListeners();
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK",
        });

    if (image != null) {
      _scannedImage = image;
    }
    notifyListeners();
  }
}
