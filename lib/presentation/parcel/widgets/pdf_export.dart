import 'dart:typed_data';

import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' show AssetImage;

Future<Uint8List> makePdf(ParcelModel invoice) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [],
        );
      },
    ),
  );

  return pdf.save();
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

Future<dynamic> pdf(name, address, date, quantity) async {
  print("$name,$address,$date,$quantity");
  final Document pdf = Document(deflate: zlib.encode);
  // print('cliked');
  // PdfImage logoImage = await pdfImageFromImageProvider(
  //   pdf: pdf.document,
  //   image: const AssetImage('assets/newlogo.png'),
  // );
  pdf.addPage(
    Page(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        margin: const EdgeInsets.all(20),
        orientation: PageOrientation.portrait,
        build: (Context context) {
          return ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text("Tax Invoice",
                    style: const TextStyle(color: PdfColors.red, fontSize: 30)),
              ),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.red,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Container(
                    //     margin: const EdgeInsets.all(10),
                    //     child: Image(logoImage)),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text("SNA SISTECH Pvt. Ltd",
                                style: const TextStyle(color: PdfColors.red)),
                          ),
                          Container(
                            child: Text(
                                "SNA SISTECH\nShop No.5 , Vallabhnagar Avadhpuri,\nKhajurikalan, Bhopal, Madhya Pradesh\n462022\nIndia"),
                          ),
                        ]),
                    SizedBox(height: 30, width: 30),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Container(child: Text("GSTIN")),
                          Container(child: Text("State")),
                          Container(child: Text("Pan")),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Container(child: Text("  0727232387A8")),
                          Container(child: Text("07-Delhi")),
                          Container(child: Text("AAGCB9745G")),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Container(child: Text("Invoice Date")),
                          Container(child: Text("Invoice No.")),
                          Container(child: Text("Refrence No.")),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Container(child: Text("12/07/2019")),
                          Container(child: Text("BNMK/2020/18")),
                          Container(child: Text("")),
                        ]),
                  ]),
              // //Create a line
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.red,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),

              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(child: Text("Customer Name")),
                          Container(child: Text(name)),
                          SizedBox(width: 20, height: 20),
                          Container(child: Text("Customer GSTIN")),
                          Container(child: Text("2JNSDU3223NI")),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(child: Text("Billing Address")),
                          Container(
                              child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("$name \n$address \nIndia"))),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(child: Text("Shiping Address")),
                          Container(
                              child: Text(
                                  "SNA SISTECH\n Shop No.5 , Vallabhnagar Avadhpuri,\nKhajurikalan, Bhopal, Madhya Pradesh\n462022\nIndia")),
                        ]),
                  ]),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.red,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(5),
                  child: Text("Total items: $quantity ")),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.red,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5)),
              Container(
                color: PdfColors.yellow200,
                padding: const EdgeInsets.all(20),
                child: Table(
                    // border: TableBorder(
                    //     horizontalInside: true,
                    //     top: true,
                    //     bottom: true,
                    //     verticalInside: false,
                    //     left: false,
                    //     right: false),
                    tableWidth: TableWidth.max,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        Container(child: Text("Product")),
                        Container(child: Text('Title')),
                        Container(child: Text("Qty")),
                        Container(child: Text("Gross\n Amount")),
                        Container(child: Text("Taxable\n Value")),
                        Container(child: Text("IGST")),
                        Container(child: Text("Total")),
                      ]),
                      TableRow(children: <Widget>[
                        Container(child: Text("Sna Rakshak")),
                        Container(child: Text("Sna Rakshak")),
                        Container(child: Text("$quantity")),
                        Container(child: Text("4000.00")),
                        Container(child: Text("3280.00")),
                        Container(child: Text("720.00")),
                        Container(child: Text("4000.00")),
                      ]),
                      TableRow(children: <Widget>[
                        SizedBox(),
                        Container(child: Text("Total")),
                        Container(child: Text("1")),
                        Container(child: Text("4000.00")),
                        Container(child: Text("3280.00")),
                        Container(child: Text("720.00")),
                        Container(child: Text("4000.00")),
                      ]),
                    ]),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(child: Text("Grand Total")),
                          SizedBox(width: 15),
                          Container(child: Text("4000")),
                        ]),
                    SizedBox(height: 15),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(child: Text("SNA SISTEC Pvt Ltd")),
                          Container(child: PdfLogo()),
                          Container(child: Text("Authorized Signatory")),
                        ])
                  ]),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.black,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Text("Terms and Condition Applied*")
            ],
          );
        }),
  );
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/example.pdf");
  // print(output.path);
  await file.writeAsBytes(await pdf.save());

  return file;
}
