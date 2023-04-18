// import 'package:agro_chain/Contract.dart';
import 'package:agro_chain/screens/farmerpage.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/screens/customerpage.dart';
import 'package:agro_chain/services/Integration.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyB4Z8jmRw--aH7uKIs_ElJCsAl6W_ep9i0',
      appId: '1:505248775743:android:f86b476927716e6953c28a',
      messagingSenderId: '505248775743',
      projectId: 'authfeature-cc722',
    ),
  );
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
