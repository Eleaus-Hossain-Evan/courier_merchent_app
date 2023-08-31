import 'dart:typed_data';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:courier_merchent_app/utils/constant/api_routes.dart';
import 'package:courier_merchent_app/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' show AssetImage, TableCell;
import 'package:printing/printing.dart';
import 'package:velocity_x/velocity_x.dart';

Future<Uint8List> makePdf(ParcelModel parcel) async {
  final pdf = Document();

  final netImage = await networkImage(APIRoute.BASE_URL + parcel.qrCode);

  pdf.addPage(
    Page(
      margin: const EdgeInsets.all(8),
      build: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(color: PdfColors.black),
              ),
              child: infoSection(
                title: 'Merchant',
                name: parcel.merchantInfo.name,
                address: parcel.merchantInfo.address,
                area: parcel.merchantInfo.area.name,
                district: parcel.merchantInfo.district.name,
                phone: parcel.merchantInfo.phone,
                price: 0,
                isCustomer: false,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: PdfColors.black,
                  ),
                  vertical: BorderSide(
                    color: PdfColors.black,
                  ),
                ),
              ),
              child: infoSection(
                title: 'Customer',
                name: parcel.customerInfo.name,
                address: parcel.customerInfo.address,
                area: parcel.customerInfo.area.name,
                district: parcel.customerInfo.district.name,
                phone: parcel.customerInfo.phone,
                price: parcel.regularPayment.cashCollection,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PdfColors.black),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'SERIAL ID# : ${parcel.serialId}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 40,
                    child: VerticalDivider(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AREA#: Uttara',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'HUB#:',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PdfColors.black),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image(
                      netImage,
                      height: 120,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: PdfColors.black),
                      ),
                      child: Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: BarcodeWidget(
                                barcode: Barcode.code128(escapes: true),
                                data: parcel.serialId,
                                width: 400,
                                height: 80,
                                textStyle: TextStyle.defaultStyle().copyWith(
                                  fontSize: 16.sp,
                                ),
                                textPadding: 6.w,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PdfColors.black),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'INVOICE : ',
                                      children: [
                                        TextSpan(
                                          text: parcel
                                              .regularParcelInfo.invoiceId,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: PdfColors.black),
                                    ),
                                    child: Flexible(
                                      child: PaddedText(
                                        'CREATED AT: ${parcel.createdAt.formatToWordWithTime()}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

Widget infoSection({
  required String title,
  required String name,
  required String address,
  required String area,
  required String district,
  required String phone,
  required double price,
  bool isCustomer = true,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title :'),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, height: 1),
              ),
              SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "address"),
                    const TextSpan(
                      text: ", ",
                    ),
                    TextSpan(text: area),
                    const TextSpan(
                      text: ", ",
                    ),
                    TextSpan(text: district),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text(phone),
            ],
          ),
        ),
        isCustomer ? Text("BDT $price") : SizedBox.shrink(),
      ],
    ),
  );
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
