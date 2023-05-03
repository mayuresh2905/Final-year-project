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
import 'package:share/share.dart';

class Transaction3 extends StatefulWidget {
  const Transaction3({Key? key}) : super(key: key);

  @override
  State<Transaction3> createState() => _Transaction3State();
}

class _Transaction3State extends State<Transaction3> {
  TextEditingController cropNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController CustomerController = TextEditingController();

  List<Transaction3_Model> transaction3 = List.empty(growable: true);
  int selectedIndex = -1;

  void showBottomSheet(int? index) async {
    if (index != null) {
      cropNameController.text = transaction3[index].crop_name;
      quantityController.text = transaction3[index].Quantity;
      priceController.text = transaction3[index].price;
      CustomerController.text = transaction3[index].price;

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
                  buildInputForm('Quantity', quantityController),
                  buildInputForm('Price', priceController),
                  buildInputForm('Customer Name', CustomerController),
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
                  String quantity = quantityController.text.trim();
                  String Price = priceController.text.trim();
                  String Customer = CustomerController.text.trim();
                  String timeStamp = DateTime.now().toString();

                  if (cropName.isNotEmpty &&
                      quantity.isNotEmpty &&
                      Price.isNotEmpty &&
                      Customer.isNotEmpty) {
                    if (selectedIndex >= 0 &&
                        selectedIndex < transaction3.length) {
                      // Update existing crop
                      setState(() {
                        transaction3[selectedIndex] = Transaction3_Model(
                          id: transaction3[selectedIndex].id,
                          crop_name: cropName,
                          Quantity: quantity,
                          price: Price,
                          Customer: Customer,
                          timeStamp: timeStamp,
                        );
                      });
                    } else {
                      // Add new crop
                      setState(() {
                        int id = DateTime.now().millisecondsSinceEpoch;
                        transaction3.add(
                          Transaction3_Model(
                            id: id,
                            crop_name: cropName,
                            Quantity: quantity,
                            price: Price,
                            Customer: Customer,
                            timeStamp: timeStamp,
                          ),
                        );
                      });
                    }
                    // Clear the form
                    cropNameController.clear();
                    quantityController.clear();
                    priceController.clear();
                    CustomerController.clear();

                    // Close the bottom sheet
                    Navigator.of(context).pop();
                    showQRDialog('{"transaction": {"id": "123456","delivery_from": "Tanmay Doshi","status": "Sold"},"crop": {"name": "Tomatoes","type": "Vegetable","description": "Fresh and ripe tomatoes from a local farm", "timestamp_of_registration": "11 October 2023 12:00 pm","status": "Crop Registered"},"farmer": { "name": "Mayuresh Prabhu","email": "mayureshprabhu29@gmail.com","location": "Gurugram","qualification": "M.A.", "timestamp_of_farmer_to_distributor": "14 November 2023 11:00 am","status": "From Farmer to Distributor"}, "distributor": {"name": "Kiran Suryawanshi","email": "Kiransuryawanshi03@gmail.com","location": "Dombivili","qualification": "M.Com", "timestamp_of_delivery_to_retailer": "17 November 2023 11:00 pm","status": "From Distributor to Retailer"},"retailer": {"name": "Tanmay Doshi", "email": "doshitanmay@gmail.com","location": "Fresh Mart, GHI Street, New York","qualification": "M.Com","timestamp_of_retailer_to_customer": "20 November 2023 12:00 pm","status": "From Retailer to Customer"}}');
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transaction form'),
        backgroundColor: Colors.green,
      ),
      body: transaction3.isEmpty
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
              itemCount: transaction3.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  leading: QrImage(
                    data:
                        '${transaction3[index].id},${transaction3[index].crop_name},${transaction3[index].Quantity},${transaction3[index].price},${transaction3[index].Customer},${transaction3[index].timeStamp},',
                    version: QrVersions.auto,
                    gapless: false,
                    size:  MediaQuery.of(context).size.width*0.20,
                  ),
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Delivery to ${transaction3[index].Customer}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "id: ${transaction3[index].id}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time: ${transaction3[index].timeStamp}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (() {
                            showBottomSheet(index);
                          }),
                          icon: Icon(Icons.edit, color: Colors.indigo)),
                      IconButton(
                          onPressed: (() {
                            setState(() {
                              if (index >= 0 && index < transaction3.length) {
                                transaction3.removeAt(index);
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
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
