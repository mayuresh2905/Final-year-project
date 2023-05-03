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
  
  String crop_name;
  String retailer;
  String batches;
  String timeStamp;
  int price;
  
  
  Transaction2_Model(
      {required this.id,    
      required this.crop_name,
      required this.retailer,
      required this.batches,
      required this.timeStamp,
      required this.price,
      
      });
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
  String farmer_name;
  String Location;
  String email;
  String qualifications;
  
  Farmer(
      {required this.id,
      required this.farmer_name,
      required this.Location,
      required this.email,
      required this.qualifications,
      
      });
}

class Distributor {
  int id;
  String distributor_name;
  String Location;
  String email;
  String qualifications;
  Distributor(
      {required this.id,
      required this.distributor_name,
      required this.Location,
      required this.email,
      required this.qualifications,});
}

class Retailer {
   int id;
  String retailer_name;
  String Location;
  String email;
  String qualifications;
  Retailer(
      {required this.id,
      required this.retailer_name,
      required this.Location,
      required this.email,
      required this.qualifications,});
}

class UserModel {
  String? uid;
  String? UserName;
  String? email;
  String? Occupation;
  String? location;
  String? Qualification;


  UserModel({this.uid, this.UserName,this.email,this.Occupation,this.location,this.Qualification});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      UserName: map['UserName'],
      email: map['email'],
      Occupation: map['Occupation'],
      location: map['location'],
      Qualification: map['Qualification']

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'UserName': UserName,
      'email':email,
      'Occupation':Occupation,
      'location':location,
      'Qualification':Qualification
    };
  }
}