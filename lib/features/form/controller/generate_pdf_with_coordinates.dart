import 'dart:io';


import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';


  Future generatePDFwithCoordinates(
    String favoritePlace,
    List<double> latitude,
    List<double> longitude,
  ) async {
    Directory tempDirectory = await getTemporaryDirectory();
    final String tempDocPath = tempDirectory.path;
    final pdf = pw.Document();
    final String fileLocation = "$tempDocPath/$favoritePlace.pdf";
    final file = File(fileLocation);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Header(
              child: pw.Text(
                "My favorite place is $favoritePlace",
                style: pw.TextStyle(
                  fontSize: 32,
                  font: pw.Font.helveticaBold(),
                ),
              ),
            ),
            pw.Divider(),
            pw.Row(
              children: [
                pw.Column(
                  children: [
                    pw.ListView.builder(
                      itemCount: latitude.length,
                      itemBuilder: (context, index) {
                        return pw.Text(
                          latitude[index].toString(),
                        );
                      },
                    ),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.ListView.builder(
                      itemCount: longitude.length,
                      itemBuilder: (context, index) {
                        return pw.Text(
                          longitude[index].toString(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );
    await file.writeAsBytes(
      await pdf.save(),
    );
    return await OpenFilex.open(fileLocation);
  }

