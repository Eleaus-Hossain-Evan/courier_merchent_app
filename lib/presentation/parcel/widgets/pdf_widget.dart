import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
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
    );
  }
}
