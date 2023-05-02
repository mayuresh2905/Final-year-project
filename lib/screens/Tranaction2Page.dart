import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/models/Data_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:agro_chain/services/Integration.dart';
import 'package:provider/provider.dart';

class Transaction2 extends StatefulWidget {
  const Transaction2({Key? key}) : super(key: key);

  @override
  State<Transaction2> createState() => _Transaction2State();
}

class _Transaction2State extends State<Transaction2> {
  TextEditingController cropNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController RetailerController = TextEditingController();

  List<Transaction2_Model> transaction2 = List.empty(growable: true);
  Contract? contractProvider;
  int selectedIndex = -1;

  void showBottomSheet(int? index, Contract contractProvider) async {
    if (index != null) {
      cropNameController.text = transaction2[index].crop_name;
      // quantityController.text = transaction2[index].Batches;
      // priceController.text = transaction2[index].price;
      RetailerController.text = transaction2[index].Retailer;

      setState(() {
        selectedIndex = index;
      });
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          children: [
            Padding(
              padding: kDefaultPadding,
              child: Column(
                children: [
                  buildInputForm('Crop Name', cropNameController),
                  buildInputForm('Batches', quantityController),
                  buildInputForm('Price per kg', priceController),
                  buildInputForm('Retailer Name', RetailerController),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(
                  buttonText: index == null ? "Add Data" : "Update",
                  onTap: () {
                    String cropName = cropNameController.text.trim();
                    int Batches = int.parse(quantityController.text.trim());
                    int Price = int.parse(priceController.text.trim());
                    String Retailer = RetailerController.text.trim();
                    String timeStamp = DateTime.now().toString();

                    if (cropName.isNotEmpty &&
                        Retailer.isNotEmpty) {
                      if (selectedIndex >= 0 &&
                          selectedIndex < transaction2.length) {
                        // Update existing crop
                        setState(() {
                          transaction2[selectedIndex] = Transaction2_Model(
                            id: transaction2[selectedIndex].id,
                            // productCode: transaction2[selectedIndex].id,
                            crop_name: cropName,
                            Batches: Batches,
                            price: Price,
                            Retailer: Retailer,
                            timeStamp: timeStamp,
                          );
                        });
                      } else {
                        // Add new crop
                        setState(() {
                          int id = DateTime.now().millisecondsSinceEpoch;
                          transaction2.add(
                            Transaction2_Model(
                              id: id,
                              // productCode: transaction2[selectedIndex].id,
                              crop_name: cropName,
                              Batches: Batches,
                              price: Price,
                              Retailer: Retailer,
                              timeStamp: timeStamp,
                            ),
                          );
                        });
                        contractProvider.transact2Page(
                            DateTime.now().millisecondsSinceEpoch,
                            cropNameController.text,
                            int.parse(quantityController.text),
                            RetailerController.text,
                            DateTime.now().toString(),
                            int.parse(priceController.text));
                      }
                    }
                    // Clear the form
                    cropNameController.clear();
                    quantityController.clear();
                    priceController.clear();
                    RetailerController.clear();

                    // Close the bottom sheet
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showQRDialog(String data) async {
    try {
      // Create the QR code as a widget
      final qrCode = QrImage(
        data: data,
        version: QrVersions.auto,
        gapless: false,
        size: 200.0,
      );

      // Create a key for the widget
      final qrKey = GlobalKey();

      // Create a boundary for the widget
      final boundary = await _captureQrCode(qrKey);

      // Render the QR code to an image
      final image = await boundary.toImage(pixelRatio: 3.0);

      // Convert the image to PNG bytes
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save the PNG bytes to a file
      // ...

      // Show a dialog box with the QR code image
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download QR Code'),
            content: Center(
              child: RepaintBoundary(
                key: qrKey,
                child: qrCode,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Download'),
                onPressed: () {
                  // Download the QR code image
                  saveQrCodeToGallery(pngBytes);
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error generating QR code: $e");
    }
  }

  Future<RenderRepaintBoundary> _captureQrCode(GlobalKey key) async {
    // Create a repaint boundary to capture the QR code widget
    final boundary = RenderRepaintBoundary();

    // Render the QR code widget to the boundary
    await SchedulerBinding.instance.endOfFrame;
    key.currentContext!.findRenderObject()!.visitChildren((RenderObject child) {
      child.parentData!.detach();
      boundary.child = child as RenderBox;
    });
    await boundary.toImage(pixelRatio: 3.0);

    return boundary;
  }

  Future<void> saveQrCodeToGallery(Uint8List pngBytes) async {
    final result = await ImageGallerySaver.saveImage(pngBytes);
    if (result['isSuccess']) {
      print("QR code saved to gallery");
    } else {
      print("Error saving QR code to gallery: ${result['errorMessage']}");
    }
  }

  Padding buildInputForm(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contractProvider = Provider.of<Contract>(context, listen: true);
    transaction2 = contractProvider.transaction2;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transaction form'),
        backgroundColor: Colors.green,
      ),
      body: transaction2.isEmpty
          ? Center(
              child: Text(
                'No Transactions yet...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: transaction2.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  leading: QrImage(
                    data:
                        '${transaction2[index].id},${transaction2[index].crop_name},${transaction2[index].Batches},${transaction2[index].price},${transaction2[index].Retailer},${transaction2[index].timeStamp},',
                    version: QrVersions.auto,
                    gapless: false,
                    size: MediaQuery.of(context).size.width*0.20,
                  ),
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Delivery to ${transaction2[index].Retailer}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "id: ${transaction2[index].id}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time: ${transaction2[index].timeStamp}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (() {
                            showBottomSheet(index, contractProvider);
                          }),
                          icon: Icon(Icons.edit, color: Colors.indigo)),
                      IconButton(
                          onPressed: (() {
                            setState(() {
                              if (index >= 0 && index < transaction2.length) {
                                transaction2.removeAt(index);
                              }
                            });
                          }),
                          icon: Icon(Icons.delete, color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showBottomSheet(null, contractProvider),
        child: Icon(Icons.add),
      ),
    );
  }
}
