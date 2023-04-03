import 'package:agro_chain/screens/RetailScanner.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';

class Retailer extends StatefulWidget {
  const Retailer({Key? key}) : super(key: key);

  @override
  State<Retailer> createState() => _RetailerState();
}

class _RetailerState extends State<Retailer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        centerTitle: true,
        title: Text('Retailer User Interface'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:20,
              ),
              Text(
                'Welcome Retailer',
                style: titleText,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: Row(
                children: [
                  Expanded(child: GridView 
        ( 
          shrinkWrap: true,
          children: [
            
          InkWell(
            onTap: (){
             ;
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Incoming Transactions",style: TextStyle(color: Colors.white,fontSize: 15),)
            ],),
            ),
          ),
         InkWell(
             onTap: (){
              
            },
           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.yellow,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Setting the Price",style: TextStyle(color: Colors.white,fontSize: 15),)
            ],),
            ),
         ),
          InkWell(
              onTap: (){
              
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Selling to Customer",style: TextStyle(color: Colors.white,fontSize: 15),)
            ],),
            ),
          ),
          InkWell(
              onTap: (){
              
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("",style: TextStyle(color: Colors.white,fontSize: (15)),)
            ],),
            ),
          ),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),)
                ],
              )),
           SizedBox(
            height: 10.0,
           ) ,GestureDetector(
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RScanner()));
                  
                },
                child: PrimaryButton(buttonText: 'Scan QR')),],) ));
    
  }
}