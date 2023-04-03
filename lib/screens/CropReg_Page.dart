import 'package:agro_chain/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/CropRegi_form.dart';
import 'package:agro_chain/main.dart';
import 'package:agro_chain/screens/customerpage.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:agro_chain/services/Integration.dart';
import 'package:provider/provider.dart';


class CropReg extends StatefulWidget {
  const CropReg({Key? key}) : super(key: key);

  @override
  State<CropReg> createState() => _CropRegState();
}

class _CropRegState extends State<CropReg> {
  Contract contractObj;

  TextEditingController _addCrop = TextEditingController();
  TextEditingController _cropType = TextEditingController();
  TextEditingController _cropDescription = TextEditingController();
  TextEditingController _doh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contractObj = Provider.of<Contract>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text('Crop Registration form'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Column(
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
            child: TextField(
              controller: _addCrop,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Crop Name',
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
          Padding(
            padding: kDefaultPadding,
            child: TextField(
              controller: _cropType,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Crop Name',
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
          Padding(
            padding: kDefaultPadding,
            child: TextField(
              controller: _cropDescription,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Crop Name',
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
          Padding(
            padding: kDefaultPadding,
            child: TextField(
              controller: _doh,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Crop Name',
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: kDefaultPadding,
            // child: PrimaryButton(buttonText: 'Add Crop'),
          ),
        ],
      )),
    );
  }
}
