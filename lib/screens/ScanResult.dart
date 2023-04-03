import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';


class StepData {
  final String status;
  final String date;
  final String content;

  StepData({
    required this.status,
    required this.date,
    required this.content,
  });

  
}



class ResultScreen extends StatelessWidget {

  final String code;
  
  


  const ResultScreen({super.key,  required this.code}) ;

  List<StepData> _parseJson(String jsonString) {
  try {
    final data = jsonDecode(jsonString)['data'];
    return List<StepData>.from(data.map((item) => StepData(
      status: item['Status'],
      date: item['Date'],
      content: item['content'],
    )));
  } on FormatException {
    // Handle JSON parsing error
    print('Error: Invalid JSON string');
    return [];
  } catch (e) {
    // Handle other errors
    print('Error: $e');
    return [];
  }
}

  @override
  Widget build(BuildContext context) {

    final List<StepData> stepData = _parseJson(code);

    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_rounded, color:  Colors.black87,)),
        centerTitle: true,
        title: const Text("QR Scanner",
                    style: TextStyle(

                      letterSpacing: 1,
                    ),),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child :Column(children: [

          Text("Scanned Result",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),),

                     SizedBox(
                      height: 10,
                    ),
           
           QrImage(
            data: code,size: 150, 
            version: QrVersions.auto,
            ),

          
                    SizedBox(
                      height: 10,
                    ),

                    Stepper(
                      
          steps: stepData
              .asMap()
              .map((index, step) => MapEntry(
                    index,
                    Step(
                      title: Text(step.status),
                      subtitle: Text(step.date),
                      content: Text(step.content),
                    ),
                  ))
              .values
              .toList(),
              ),
                    
                   SizedBox(
                      height: 10,
                    ),
                    
                    
        ],)),
    ); 
  }
}