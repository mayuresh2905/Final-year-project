import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agro_chain/theme.dart';
import 'package:agro_chain/widgets/primary_button.dart';
import 'package:agro_chain/models/Data_models.dart';
import 'package:provider/provider.dart';
import 'package:agro_chain/services/Integration.dart';

class CropReg extends StatefulWidget {
  const CropReg({Key? key}) : super(key: key);

  @override
  State<CropReg> createState() => _CropRegState();
}

class _CropRegState extends State<CropReg> {
  TextEditingController productCodeController = TextEditingController();
  TextEditingController cropNameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController productDateController = TextEditingController();

  Contract? contractProvider;
  List<Crop_Model> crop = List.empty(growable: true);

  int selectedIndex = -1;

  void showBottomSheet(int? index, Contract contractProvider) async {
    if (index != null) {
      // productCodeController.text = crop[index].product_Code;
      cropNameController.text = crop[index].crop_name;
      typeController.text = crop[index].type;
      // priceController.text = crop[index].price;
      farmNameController.text = crop[index].farmName;
      productDateController.text = crop[index].productDate;
      descController.text = crop[index].desc;

      setState(() {
        selectedIndex = index;
      });
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          children: [
            Padding(
              padding: kDefaultPadding,
              child: Column(
                children: [
                  buildInputForm('Product Code', productCodeController),
                  buildInputForm('Crop Name', cropNameController),
                  buildInputForm('Type', typeController),
                  buildInputForm('Description', descController),
                  buildInputForm('Product Date', productDateController),
                  buildInputForm('Farm Name', farmNameController),
                  buildInputForm('price', priceController),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(
                buttonText: index == null ? "Add Data" : "Update",
                onTap: () {
                  int product_Code =
                      int.parse(productCodeController.text.trim());
                  String cropName = cropNameController.text.trim();
                  String type = typeController.text.trim();
                  String productDate = productDateController.text.trim();
                  String farmName = farmNameController.text.trim();
                  int price = int.parse(priceController.text.trim());
                  String desc = descController.text.trim();
                  String timeStamp = DateTime.now().toString();

                  if (cropName.isNotEmpty &&
                      type.isNotEmpty &&
                      productDate.isNotEmpty &&
                      farmName.isNotEmpty &&
                      desc.isNotEmpty) {
                    if (selectedIndex >= 0 && selectedIndex < crop.length) {
                      // Update existing crop
                      setState(() {
                        crop[selectedIndex] = Crop_Model(
                          product_Code: product_Code,
                          crop_name: cropName,
                          type: type,
                          // Pesticide: pesticide,
                          // Feritilizer: fertilizer,
                          // Quantity: quantity,
                          desc: desc,
                          productDate: productDate,
                          farmName: farmName,
                          price: price,
                          timeStamp: timeStamp,
                        );
                      });
                    } else {
                      // Add new crop
                      setState(() {
                        crop.add(
                          Crop_Model(
                            product_Code: product_Code,
                            crop_name: cropName,
                            type: type,
                            desc: desc,
                            productDate: productDate,
                            farmName: farmName,
                            price: price,
                            timeStamp: timeStamp,
                          ),
                        );
                      });
                      contractProvider.cropReg(
                          int.parse(productCodeController.text),
                          cropNameController.text,
                          typeController.text,
                          descController.text,
                          productDateController.text,
                          farmNameController.text,
                          int.parse(priceController.text));
                    }

                    // Clear the form
                    productCodeController.clear();
                    cropNameController.clear();
                    typeController.clear();
                    descController.clear();
                    productDateController.clear();
                    farmNameController.clear();
                    priceController.clear();

                    // Close the bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contractProvider = Provider.of<Contract>(context, listen: true);
    crop = contractProvider.crop;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crop Registration form'),
        backgroundColor: Colors.green,
      ),
      body: crop.isEmpty
          ? Center(
              child: Text(
                'No Crop Registered yet...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: crop.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(crop[index].crop_name,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quantity: ${crop[index].Quantity}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time: ${crop[index].timeStamp}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (() {
                            showBottomSheet(index, contractProvider);
                          }),
                          icon: Icon(Icons.edit, color: Colors.indigo)),
                      IconButton(
                          onPressed: (() {
                            setState(() {
                              if (index >= 0 && index < crop.length) {
                                crop.removeAt(index);
                              }
                            });
                          }),
                          icon: Icon(Icons.delete, color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showBottomSheet(null, contractProvider),
        child: Icon(Icons.add),
      ),
    );
  }

  Padding buildInputForm(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
