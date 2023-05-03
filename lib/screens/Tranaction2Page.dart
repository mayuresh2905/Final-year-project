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
import 'package:share/share.dart';

class Transaction2 extends StatefulWidget {
  const Transaction2({Key? key}) : super(key: key);

  @override
  State<Transaction2> createState() => _Transaction2State();
}

class _Transaction2State extends State<Transaction2> {
  
  TextEditingController cropNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController retailerController = TextEditingController();

  List<Transaction2_Model> transaction2 = List.empty(growable: true);
  Contract? contractProvider;
  int selectedIndex = -1;

  void showBottomSheet(int? index, Contract contractProvider) async {
    if (index != null) {
      cropNameController.text = transaction2[index].crop_name;
      quantityController.text = transaction2[index].batches; 
      //priceController.text = transaction2[index].price;
      retailerController.text = transaction2[index].retailer;

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
                  buildInputForm('Retailer Name', retailerController),
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
                    String batches = quantityController.text.trim();
                    int price = int.parse(priceController.text.trim());
                    String retailer = retailerController.text.trim();
                    String timeStamp = DateTime.now().toString();

                    if (cropName.isNotEmpty && retailer.isNotEmpty) {
                      if (selectedIndex >= 0 &&
                          selectedIndex < transaction2.length) {
                        // Update existing crop
                        setState(() {
                          transaction2[selectedIndex] = Transaction2_Model(
                              id: transaction2[selectedIndex].id,
                              crop_name: cropName,
                              batches: batches,
                              price: price,
                              retailer: retailer,
                              timeStamp: timeStamp);
                        });
                      } else {
                        // Add new crop
                        setState(() {
                          int id = DateTime.now().millisecondsSinceEpoch;
                          transaction2.add(
                            Transaction2_Model(
                                id: id,
                               
                                crop_name: cropName,
                                batches: batches,
                                price: price,
                                retailer: retailer,
                                timeStamp: timeStamp),
                          );
                        });
                        contractProvider.transact2Page(
                            DateTime.now().millisecondsSinceEpoch,                    
                            cropNameController.text,
                            retailerController.text,
                            quantityController.text,
                            DateTime.now().toString(),
                            int.parse(priceController.text));
                      }
                      // Clear the form
                      cropNameController.clear();
                      quantityController.clear();
                      priceController.clear();
                      retailerController.clear();

                      // Close the bottom sheet
                      Navigator.of(context).pop();

                      showQRDialog(
                          '{"transaction": {"id": "123456","delivery_from": "Kiran Suryavanshi","status": "Pending"},"crop": {"name": "Tomatoes","type": "Vegetable","description": "Fresh and ripe tomatoes from a local farm","timestamp_of_registration": "11 October 2023 12:00 pm","status": "Crop Registered"},"farmer": {"name": "Mayuresh Prabhu","email": "mayureshprabhu29@gmail.com","location": "Gurugram","qualification": "M.A.","timestamp_of_farmer_to_distributor": "14 November 2023 11:00 am","status": "From Farmer to Distributor"},"distributor": {"name": "Kiran ","email": "kiransuryawanshi03gmail.com","location": "Dombivili", "qualification": "M.Com","timestamp_of_delivery_to_retailer": "17 November 2023 11:00 pm","status": "From Distributor to Retailer"}}');
                    }
                  },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showQRDialog(String data) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: Text(
              'Share QR Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Center(
            child: QrImage(
              data: data,
              version: QrVersions.auto,
              gapless: false,
              size: 200.0,
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('Share QR'),
                    onPressed: () {
                      // Download the QR code image
                      shareQrCode(data);
                    },
                  ),
                  VerticalDivider(
                    thickness: 1.0,
                    color: Colors.grey[400],
                  ),
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void shareQrCode(data) async {
    // Generate the QR code data
    final qrData = data;
    print(data);
    // Create a QrPainter
    final painter = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    );

    print(painter);

    // Generate an image of the QR code
    final image = await painter.toImage(2000);
    print(image);
    // Convert the image to bytes
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final bytes = byteData?.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    print(tempDir.path);
    print(tempDir.path);
    print(tempDir.path);
    print(bytes!.length);
    final file = await File('${tempDir.path}/qr_code1.png').create();
    file.writeAsBytesSync(bytes);

    // Share the QR code image file
    await Share.shareFiles([file.path], text: 'Share QR Code');
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
                        '${transaction2[index].id},${transaction2[index].crop_name},${transaction2[index].batches},${transaction2[index].price},${transaction2[index].retailer},${transaction2[index].timeStamp},',
                    version: QrVersions.auto,
                    gapless: false,
                    size: MediaQuery.of(context).size.width * 0.20,
                  ),
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Delivery to ${transaction2[index].retailer}",
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
