// import 'package:agro_chain/Contract.dart';
import 'package:agro_chain/screens/farmerpage.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/screens/customerpage.dart';
import 'package:agro_chain/services/Integration.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Contract>(
        create: (_) => Contract(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Customer(),
        ));
  }
}
