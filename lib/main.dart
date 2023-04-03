import 'package:agro_chain/screens/farmerpage.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/screens/customerpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Customer(),
    );
  }
}
