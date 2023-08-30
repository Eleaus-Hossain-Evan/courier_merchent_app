import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'pdf_export.dart';

class PDFWidget extends HookConsumerWidget {
  const PDFWidget({
    super.key,
    required this.parcel,
  });

  final ParcelModel parcel;

  @override
  Widget build(BuildContext context, ref) {
    return PdfPreview(
      build: (context) => makePdf(parcel),
      dynamicLayout: false,
      canDebug: false,
      canChangeOrientation: false,
      // scrollViewDecoration: const BoxDecoration(color: Colors.amber),
      shouldRepaint: true,
      dpi: 100,

      initialPageFormat: PdfPageFormat.a4,
      pdfFileName: parcel.serialId,
      maxPageWidth: 1.sw,
    );
  }
}
