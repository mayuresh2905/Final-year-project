import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:agro_chain/theme.dart';

class RScanner extends StatefulWidget {
  const RScanner({Key? key}) : super(key: key);

  @override
  State<RScanner> createState() => _RScannerState();
}

class _RScannerState extends State<RScanner> {
   String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;


  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text('Retailer Scannerr'),
        backgroundColor: Colors.green,
      ),
       body:Padding(
          padding: kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             SizedBox(
                height: 20,
              ),
              Align(
              alignment: Alignment.topCenter,
              child: Text(
              "Scan as Retailer",
                style: titleText,
              ),),
              SizedBox(
                height: 20,
              ),
              
    
            Align(
             alignment: AlignmentDirectional(0, -0.55),
            child: Container(
                  height: 300,
                  width: 280,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code);
                    },
                  ),
                 
                  

                ),
                 
                 
                
          ),
    
             Align(
  alignment: Alignment.center,
  child: Container(
    margin: EdgeInsets.all(30),
    width: 300,
    child: TextFormField(
      autofocus: true,
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'Product Serial No.',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF110A0A),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF110A0A),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
      style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    ),
  ),
),

    ]))));

   

    
  }
}