import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:agro_chain/theme.dart';

class Crop extends StatefulWidget {
  const Crop({Key? key}) : super(key: key);

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Crop Name'),
        buildInputForm('Type'),
        buildInputForm('Pesticide Used'),
        buildInputForm('Feritilizer Used'),
        buildInputForm('Quantity'),
      ],
    );
  }

  Padding buildInputForm(String hint) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
           
          ),
        ));
    
  }
}