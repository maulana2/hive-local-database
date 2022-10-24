import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hive_local_database/provider/scan_pdf/scan_pdf_provider.dart';
import 'package:provider/provider.dart';

class ScanPdfPage extends StatefulWidget {
  const ScanPdfPage({super.key});

  @override
  State<ScanPdfPage> createState() => _ScanPdfPageState();
}

class _ScanPdfPageState extends State<ScanPdfPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner Demo'),
        ),
        body: /* Consumer<ScanPdfProvider>(
          builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (provider.scannedDocument != null ||
                  provider.scannedImage != null) ...[
                if (provider.scannedImage != null)
                  Image.file(
                    provider.scannedImage!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                if (provider.scannedDocument != null)
                  Expanded(
                    child: PDFViewer(document: provider.scannedDocument!),
                  ),
              ],
              Center(
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        provider.openPdfScanner(context);
                      },
                      child: Text('Pdf Scan'),
                    );
                  },
                ),
              ),
            ],
          ),
        ), */

            Consumer<ScanPdfProvider>(
          builder: (context, provider, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (provider.scannedDocument != null ||
                  provider.scannedImage != null) ...[
                if (provider.scannedImage != null)
                  Image.file(provider.scannedImage!,
                      width: 300, height: 300, fit: BoxFit.contain),
                if (provider.scannedDocument != null)
                  Expanded(
                      child: PDFViewer(
                    document: provider.scannedDocument!,
                  )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(provider.scannedDocumentFile?.path ??
                      provider.scannedImage?.path ??
                      ''),
                ),
              ],
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => provider.openPdfScanner(context),
                      child: Text("PDF Scan"));
                }),
              ),
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => provider.openImageScanner(context),
                      child: Text("Image Scan"));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
