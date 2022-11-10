import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/CropRegi_form.dart';

class CropReg extends StatefulWidget {
  const CropReg({Key? key}) : super(key: key);

  @override
  State<CropReg> createState() => _CropRegState();
}

class _CropRegState extends State<CropReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text('Crop Registration form'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          SizedBox(
              height: 30,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Register Crop',
                style: titleText,
              ),
            ),
             SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Crop(),
            ),
             SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(buttonText: 'Add Crop'),
            ),
        ],
        )
        ),
    );
  }
}