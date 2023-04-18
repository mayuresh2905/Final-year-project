import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/models/Data_models.dart';



class Income_trans2 extends StatefulWidget {
  const Income_trans2({Key? key}) : super(key: key);

  @override
  State<Income_trans2> createState() => _Income_trans2State();
}

class _Income_trans2State extends State<Income_trans2> {
  List<Transaction2_Model> transaction2 = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        title: Text('Income Transaction'),
        backgroundColor: Colors.green,
      ),
      body: transaction2.isEmpty
      ? Center( child: Text(
        'No Transactions yet...',
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
      ),): 
      ListView.builder(
        itemCount: transaction2.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            leading: QrImage(
             data: '${transaction2[index].id},${transaction2[index].crop_name},${transaction2[index].Quantity},${transaction2[index].price},${transaction2[index].Retailer},${transaction2[index].timeStamp},',
             version: QrVersions.auto,
              gapless: false,
              size: MediaQuery.of(context).size.width*0.1
             ),
            title: Padding(padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Delivery to ${transaction2[index].Retailer}",
            style: TextStyle(
              fontSize:20,
              )),),
              subtitle: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "id: ${transaction2[index].id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Time: ${transaction2[index].timeStamp}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            
          ],

        ),
             
              ),
          ),
        ),

      );

    
  }
}