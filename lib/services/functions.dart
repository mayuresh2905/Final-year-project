// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:web3dart/contracts.dart';
// import 'package:web3dart/credentials.dart';
// import 'package:agro_chain/utils/constants.dart';
// import 'package:web3dart/web3dart.dart';

// Future<DeployedContract> loadContract() async {
//   String abi = await rootBundle.loadString("src/abis/main.json");
//   String contractAddress = "0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99";

//   final contract = DeployedContract(ContractAbi.fromJson(abi, 'main'),
//       EthereumAddress.fromHex(contractAddress));
//   return contract;
// }

// Future<String> callFunction(String funcname, List<dynamic> args,
//     Web3Client ethClient, String privateKey) async {
//   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
//   DeployedContract contract = await loadContract();
//   final ethFunction = contract.function(funcname);
//   // final argValues = args.entries.map((e) => e.value).toList();
//   final result = await ethClient.sendTransaction(
//       credentials,
//       Transaction.callContract(
//           contract: contract, function: ethFunction, parameters: args),
//       chainId: null,
//       fetchChainIdFromNetworkId: true);
//   return result;
// }

// //   // add more key-value pairs as needed
// // };
// Future<String> cropRegisteredByFarmer(
//   int _productCode,
//   String _productName,
//   String _productType,
//   String _productDescription,
//   String _productDate,
//   String _farmName,
//   int _price, Web3Client ethClient
//   ) async {
//     var response = await callFunction(funcname, args, ethClient, privateKey)
//   }

// Future<String> cropRegistration(String _productname, String _producttype,
//     String _descript, String _doh, Web3Client ethClient) async {
//   var response = await callFunction('cropRegistration',
//       [_productname, _producttype, _descript, _doh], ethClient, private_keys);
//   print("Crop Register success");
//   return response;
// }

// Future<String> farmerDetails(int _fid, String _fname, String _femail,
//     String _flocation, int _fphone, String _fpass, Web3Client ethClient) async {
//   var response = await callFunction(
//       'farmerDetails',
//       [
//         BigInt.from(_fid),
//         _fname,
//         _femail,
//         _flocation,
//         BigInt.from(_fphone),
//         _fpass
//       ],
//       ethClient,
//       private_keys);
//   print("Farmer details added successfully");
//   return response;
// }
