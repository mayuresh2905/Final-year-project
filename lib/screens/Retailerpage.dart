
import 'package:agro_chain/screens/Income_trans2.dart';
import 'package:agro_chain/screens/Transaction1Page.dart';
import 'package:agro_chain/screens/ScanResult.dart';
import 'package:agro_chain/screens/Transaction3Page.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
class Retailer extends StatefulWidget {
  const Retailer({Key? key}) : super(key: key);

  @override
  State<Retailer> createState() => _RetailerState();
}

class _RetailerState extends State<Retailer> {

   var getResult = 'QR Code Result';
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        centerTitle: true,
        title: Text('Retailer User Interface'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome Retailer',
              style: titleText,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              height: 180,
                              width: 315,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Income_trans2(),
                                  ),
                                ),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage("assets/Incoming_Transation.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Incoming Transactions",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              height: 180,
                              width: 315,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Transaction3(),
                                  ),
                                ),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage("assets/Transactions.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Selling to Custormer",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
           GestureDetector(
                onTap: () {

                  scanQRCode();
                  
                },
                child: PrimaryButton(buttonText: 'Scan QR'))])));
    
  }
  void scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      Navigator.push(context, MaterialPageRoute(builder: ((context) => ResultScreen( code: getResult))));
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }

}
 
  
}  
  