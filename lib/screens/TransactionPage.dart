import 'package:agro_chain/widgets/TransactionForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/widgets/CropRegi_form.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionState();
}

class _TransactionState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transaction form'),
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
              'Add Transaction',
              style: titleText,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: kDefaultPadding,
            child: TransForm(),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: kDefaultPadding,
            child: PrimaryButton(buttonText: 'Add Transaction'),
          ),
        ],
      )),
    );
  }
}
