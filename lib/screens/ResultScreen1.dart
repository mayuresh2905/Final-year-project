import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';



class ResultScreen1 extends StatefulWidget {
  final String code;
  const ResultScreen1({Key? key, required this.code}) : super(key: key);

  @override
  _ResultScreen1State createState() => _ResultScreen1State();
}

class _ResultScreen1State extends State<ResultScreen1> {
  int currentStep = 0;
  Widget _buildTickIcon() {
  return Icon(
    Icons.check,
    color: Colors.green,
  );
}
late final Map<String, dynamic> data;
@override
  void initState() {
    super.initState();
    data = json.decode(widget.code);
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
       child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Scanned Result",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction ID: ${data['transaction']['id']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                          height: 5,
                        ),
                      Text(
                        'Delivery From: ${data['transaction']['delivery_from']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                       SizedBox(
                          height: 5,
                        ),
                      Text(
                        'Status: ${data['transaction']['status']}',
                        style: TextStyle(
                         fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                QrImage(
                  data: widget.code,
                  size: 150,
                  version: QrVersions.auto,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stepper(
              currentStep: currentStep,
              physics: ScrollPhysics(),
                onStepTapped: (index) {
                  setState(() {
                    currentStep = index;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (currentStep < data.length - 1) {
                      currentStep++;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep--;
                    }
                  });
                },
              steps: [
                 Step(
                  title: Text(data['crop']['status']),
                  subtitle: Text(data['crop']['timestamp_of_registration']),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Crop Name: ${data['crop']['name']}'),
                      Text('Crop Type: ${data['crop']['type']}'),
                      Text('Description: ${data['crop']['description']}'),
                    ],
                  ),
                 
                ),
               
                Step(
                   title: Text(data['farmer']['status']),
                   subtitle: Text(data['farmer']['timestamp_of_farmer_to_distributor']),
                   content: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text('Farmer Name: ${data['farmer']['name']}'),
                      Text('Email: ${data['farmer']['email']}'),
                      Text('Location: ${data['farmer']['location']}'),
                      Text('Qualification: ${data['farmer']['qualification']}'),
                     ],
                   ),
                  ),
              
  
              ]
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      )
      
    );
  }
}