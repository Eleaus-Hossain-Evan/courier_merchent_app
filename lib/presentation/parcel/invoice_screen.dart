import 'package:courier_merchent_app/application/parcel/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../widgets/widgets.dart';
import 'widgets/pdf_export.dart';

class InvoiceScreen extends HookConsumerWidget {
  static const route = '/invoice';

  const InvoiceScreen({
    super.key,
    required this.parcelId,
  });

  final String parcelId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(singleParcelProvider(parcelId));
    // log(parcel.toJson());
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'Invoice',
      ),
      body: state.when(
        data: (parcel) => PdfPreview(
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
        ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
