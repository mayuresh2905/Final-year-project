import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Contract with ChangeNotifier {
  final rpcUrl = "http://127.0.0.1:7545";
  final String farmerAddress =
      "c613f5e9999da2694112158134af3147d16f03dd455986db7a3454d0fcdcc325";
  final String distributorAddress =
      "70b554cb383e8647fa5809185f0b219f853470dbbae2862b7cdd050163185575";
  final String retailerAddress =
      "d29be0d545c3d8723300ad9267f68337eb659d3f59d303cc740fcfdff1e1663c";

  bool isLoading = true;
  late Web3Client web3client;
  late String abiCode;
  late EthereumAddress ethereumAddress;
  late Credentials fcredentials;
  late Credentials dcredentials;
  late Credentials rcredentials;
  late DeployedContract deployedContract;

  Contract() {
    initContract();
  }

  Future initContract() async {
    web3client = Web3Client(rpcUrl, Client());
    await getAbi();
    log('loaded abi');
    await getCred();
    log('loaded credentials');
    await getDeployedContract();

    isLoading = false;
    log('contract loaded');
    notifyListeners();
  }

  Future getAbi() async {
    String abiStringFile = await rootBundle.loadString('src/abis/main.json');
    final jsonAbi = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonAbi['abi']);
    ethereumAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future getCred() async {
    fcredentials = EthPrivateKey.fromHex(farmerAddress);
    dcredentials = EthPrivateKey.fromHex(distributorAddress);
    rcredentials = EthPrivateKey.fromHex(retailerAddress);
  }

  Future getDeployedContract() async {
    deployedContract = DeployedContract(
        ContractAbi.fromJson(abiCode, 'main'), ethereumAddress);
  }

  Future callFunction(
      {required String functionName, required List args}) async {
    ContractFunction functionCall = deployedContract.function(functionName);
    final value = await web3client.call(
        contract: deployedContract, function: functionCall, params: args);
    return value;
  }

  Future sendTransactionFromFarmer(
      {required String functionName, required List args}) async {
    ContractFunction functionCall = deployedContract.function(functionName);
    await web3client.sendTransaction(
        fcredentials,
        Transaction.callContract(
            contract: deployedContract,
            function: functionCall,
            parameters: args));
  }

  Future sendTransactionFromDistributor(
      {required String functionName, required List args}) async {
    ContractFunction functionCall = deployedContract.function(functionName);
    await web3client.sendTransaction(
        dcredentials,
        Transaction.callContract(
            contract: deployedContract,
            function: functionCall,
            parameters: args));
  }

  Future sendTransactionFromRetailer(
      {required String functionName, required List args}) async {
    ContractFunction functionCall = deployedContract.function(functionName);
    await web3client.sendTransaction(
        rcredentials,
        Transaction.callContract(
            contract: deployedContract,
            function: functionCall,
            parameters: args));
  }

  Future cropReg(
      {required int productCode,
      required String productName,
      required String productType,
      required String productDescription,
      required String productDate,
      required String farmName,
      required int price}) async {
    isLoading = true;
    notifyListeners();
    await sendTransactionFromFarmer(
        functionName: 'cropRegisteredByFarmer',
        args: [
          BigInt.from(productCode),
          productName,
          productType,
          productDescription,
          productDate,
          BigInt.from(price)
        ]);
    isLoading = false;
    notifyListeners();
  }
}
