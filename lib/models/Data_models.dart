class Crop_Model {
  int product_Code;
  String crop_name;
  String type;
  String farmName;
  String productDate;
  String desc;
  int price;
  String timeStamp;
  Crop_Model(
      {required this.crop_name,
      required this.type,
      required this.farmName,
      required this.productDate,
      required this.price,
      required this.product_Code,
      required this.desc,
      required this.timeStamp});

  get Quantity => null;
}

class Transaction1_Model {
  int id;
  int productCode;
  String crop_name;
  String Quantity;

  String Distributor;
  String timeStamp;
  int price;
  Transaction1_Model(
      {required this.id,
      required this.productCode,
      required this.crop_name,
      required this.Quantity,
      required this.Distributor,
      required this.timeStamp,
      required this.price});
}

class Transaction2_Model {
  int id;
  // int productCode;
  String crop_name;
  int Batches;
  int price;
  String Retailer;
  String timeStamp;
  Transaction2_Model(
      {required this.id,
      // required this.productCode,
      required this.crop_name,
      required this.Batches,
      required this.price,
      required this.Retailer,
      required this.timeStamp});
}

class Transaction3_Model {
  int id;
  String crop_name;
  String Quantity;
  String price;
  String Customer;
  String timeStamp;
  Transaction3_Model(
      {required this.id,
      required this.crop_name,
      required this.Quantity,
      required this.price,
      required this.Customer,
      required this.timeStamp});
}

class Farmer {
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Farmer(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.phone_no,
      required this.occupation,
      required this.Location});
}

class Distributor {
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Distributor(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.phone_no,
      required this.occupation,
      required this.Location});
}

class Retailer {
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Retailer(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.phone_no,
      required this.occupation,
      required this.Location});
}
