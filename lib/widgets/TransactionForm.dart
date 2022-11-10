import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';

class TransForm extends StatefulWidget {
  const TransForm({Key? key}) : super(key: key);

  @override
  State<TransForm> createState() => _TransFormState();
}

class _TransFormState extends State<TransForm> {
  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        buildInputForm('Crop Name'),
        buildInputForm('Quantity'),
        buildInputForm('Distributor Name'),
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
