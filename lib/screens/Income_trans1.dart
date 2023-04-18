import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:agro_chain/models/Data_models.dart';
import 'package:provider/provider.dart';
import 'package:agro_chain/services/Integration.dart';



class Income_trans1 extends StatefulWidget {
  const Income_trans1({Key? key}) : super(key: key);

  @override
  State<Income_trans1> createState() => _Income_trans1State();
}

class _Income_trans1State extends State<Income_trans1> {
  List<Transaction1_Model> transaction1 = List.empty(growable: true);
  Contract? contractProvider;
  @override
  Widget build(BuildContext context) {
    var contractProvider = Provider.of<Contract>(context, listen: true);
    transaction1=contractProvider.transaction1;
    
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        title: Text('Income Transaction'),
        backgroundColor: Colors.green,
      ),
      body: transaction1.isEmpty
      ? Center( child: Text(
        'No Transactions yet...',
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
      ),): 
      ListView.builder(
        itemCount: transaction1.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            leading: QrImage(
             data: '${transaction1[index].id},${transaction1[index].crop_name},${transaction1[index].Quantity},${transaction1[index].price},${transaction1[index].Distributor},${transaction1[index].timeStamp},',
             version: QrVersions.auto,
              gapless: false,
              size: MediaQuery.of(context).size.width*0.1,
             ),
            title: Padding(padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Delivery to ${transaction1[index].Distributor}",
            style: TextStyle(
              fontSize:20,
              )),),
              subtitle: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "id: ${transaction1[index].id}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Time: ${transaction1[index].timeStamp}",
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