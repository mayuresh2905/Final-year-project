class Crop_Model {
  String crop_name;
  String type;
  String Pesticide;
  String Feritilizer;
  String Quantity;
  String desc;
  String timeStamp;
  Crop_Model({required this.crop_name, required this.type,required this.Pesticide,required this.Feritilizer,required this.Quantity,required this.desc,required this.timeStamp});
}

class Transaction1_Model{
  int id;
  String crop_name;
  String Quantity;
  String price;
  String Distributor;
  String timeStamp;
  Transaction1_Model({ required this.id,required this.crop_name,required this.Quantity,required this.price,required this.Distributor,required this.timeStamp});
}

class Transaction2_Model{

  int id;
  String crop_name;
  String Quantity;
  String price;
  String Retailer;
  String timeStamp;
  Transaction2_Model({ required this.id,required this.crop_name,required this.Quantity,required this.price,required this.Retailer,required this.timeStamp});
}

class Transaction3_Model{
  
  int id;
  String crop_name;
  String Quantity;
  String price;
  String Customer;
  String timeStamp;
  Transaction3_Model({ required this.id,required this.crop_name,required this.Quantity,required this.price,required this.Customer,required this.timeStamp});
}

class Farmer{
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Farmer({required this.id, required this.first_name,required this.last_name,required this.email,required this.phone_no,required this.occupation,required this.Location});
}

class Distributor{
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Distributor({required this.id, required this.first_name,required this.last_name,required this.email,required this.phone_no,required this.occupation,required this.Location});
}

class Retailer{
  int id;
  String first_name;
  String last_name;
  String email;
  String phone_no;
  String occupation;
  String Location;
  Retailer({required this.id, required this.first_name,required this.last_name,required this.email,required this.phone_no,required this.occupation,required this.Location});
}