import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:agro_chain/models/Data_models.dart';

class Contract with ChangeNotifier {
  final String _rpcUrl = "HTTP://192.168.29.196:7545";
  final String _wsUrl = "ws://192.168.29.196:7545/";
  final String _farmerAddress =
      "c613f5e9999da2694112158134af3147d16f03dd455986db7a3454d0fcdcc325";
  final String _distributorAddress =
      "70b554cb383e8647fa5809185f0b219f853470dbbae2862b7cdd050163185575";
  final String _retailerAddress =
      "d29be0d545c3d8723300ad9267f68337eb659d3f59d303cc740fcfdff1e1663c";

  bool isLoading = true;
  Web3Client? _web3client;
  String? _abiCode;
  EthereumAddress? _ethereumAddress;
  Credentials? _fcredentials;
  Credentials? _dcredentials;
  Credentials? _rcredentials;
  DeployedContract? _deployedContract;

  ContractFunction? _cropReg;
  ContractFunction? _transaction1Page;

  //public count =0
  ContractFunction? _noteCount;
  ContractFunction? _note1;
  ContractFunction? _note2;

  //mapping functions
  ContractFunction? _transbyfarmer;
  ContractFunction? _transaction2Page;
  ContractFunction? _transbydistributor;
  ContractFunction? _items;

  List<Transaction1_Model> transaction1 = [];
  List<Transaction2_Model> transaction2 = [];
  List<Crop_Model> crop = [];

  Contract() {
    initContract();
  }

  Future initContract() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    log('loaded abi');
    await getCred();
    log('loaded credentials');
    await getDeployedContract();

    isLoading = false;
    log('contract loaded');
    notifyListeners();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString('src/abis/main.json');
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _ethereumAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCred() async {
    _fcredentials = EthPrivateKey.fromHex(_farmerAddress);
    _dcredentials = EthPrivateKey.fromHex(_distributorAddress);
    _rcredentials = EthPrivateKey.fromHex(_retailerAddress);
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, 'main'), _ethereumAddress!);
    _cropReg = _deployedContract!.function("cropRegisteredByFarmer");
    _transaction1Page = _deployedContract!.function("transactionByFarmer");
    _transbyfarmer = _deployedContract!.function("transbyfarmer");
    _noteCount = _deployedContract!.function("noteCount");
    _note1 = _deployedContract!.function("note1");
    _note2 = _deployedContract!.function("note2");
    _items = _deployedContract!.function("items");


    _transaction2Page = _deployedContract!.function("transactionByDistributer");
    _transbydistributor = _deployedContract!.function("transbydistributor");



    await fetchClassModel();
    await fetchTransaction1();
    await fetchTransaction2();
  }

  Future<void> fetchTransaction1() async {
    List totalTaskList = await _web3client!.call(
      contract: _deployedContract!,
      function: _noteCount!,
      params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    transaction1.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3client!.call(
          contract: _deployedContract!,
          function: _transbyfarmer!,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        transaction1.add(
          Transaction1_Model(
            id: (temp[0] as BigInt).toInt(),
            productCode: (temp[1] as BigInt).toInt(),
            crop_name: temp[2],
            Quantity: temp[3],
            price: (temp[4] as BigInt).toInt(),
            Distributor: temp[5],
            timeStamp: temp[6],
          ),
        );
      }
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> fetchTransaction2() async {
    List totalTaskList = await _web3client!.call(
      contract: _deployedContract!,
      function: _note1!,
      params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    transaction2.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3client!.call(
          contract: _deployedContract!,
          function: _transbydistributor!,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        transaction2.add(
          Transaction2_Model(
            id: (temp[0] as BigInt).toInt(),
            // productCode: (temp[1] as BigInt).toInt(),
            crop_name: temp[1],
            Batches: (temp[2] as BigInt).toInt(),
            price: (temp[3] as BigInt).toInt(),
            Retailer: temp[4],
            timeStamp: temp[5],
          ),
        );
      }
    }
    isLoading = false;

    notifyListeners();
  }

  

  transact1Page(int id, int productCode, String crop_name, String Quantity,
      String Distributor, String timeStamp, int price) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
        _fcredentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: _transaction1Page!,
            parameters: [
              BigInt.from(id),
              BigInt.from(productCode),
              crop_name,
              Quantity,
              Distributor,
              timeStamp,
              BigInt.from(price)
            ]));
    await _web3client!.sendTransaction(
        _dcredentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: _transaction1Page!,
            parameters: [
              BigInt.from(id),
              BigInt.from(productCode),
              crop_name,
              Quantity,
              Distributor,
              timeStamp,
              BigInt.from(price)
            ]));

    await fetchTransaction1();
  }

  transact2Page(int id, String crop_name, int Batches, String Retailer,
      String timeStamp, int price) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
        _dcredentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: _transaction2Page!,
            parameters: [
              BigInt.from(id),
              // BigInt.from(productCode),
              crop_name,
              BigInt.from(Batches),
              Retailer,
              timeStamp,
              BigInt.from(price)
            ]));
    await _web3client!.sendTransaction(
        _rcredentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: _transaction2Page!,
            parameters: [
              BigInt.from(id),
              // BigInt.from(productCode),
              crop_name,
              BigInt.from(Batches),
              Retailer,
              timeStamp,
              BigInt.from(price)
            ]));
    await fetchTransaction2();
  }

  Future<void> fetchClassModel() async {
    List totalTaskList = await _web3client!.call(
      contract: _deployedContract!,
      function: _noteCount!,
      params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    crop.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3client!.call(
          contract: _deployedContract!,
          function: _items!,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        crop.add(
          Crop_Model(
              // id: (temp[0] as BigInt).toInt(),
              product_Code: (temp[0] as BigInt).toInt(),
              crop_name: temp[1],
              type: temp[2],
              farmName: temp[3],
              productDate: temp[4],
              desc: temp[5],
              price: (temp[6] as BigInt).toInt(),
              timeStamp: temp[7]),
        );
      }
    }
    isLoading = false;

    notifyListeners();
  }

  cropReg(
      int productCode,
      String productName,
      String productType,
      String productDescription,
      String productDate,
      String farmName,
      int price) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
        _fcredentials!,
        Transaction.callContract(
            contract: _deployedContract!,
            function: _cropReg!,
            parameters: [
              BigInt.from(productCode),
              productName,
              productType,
              productDescription,
              productDate,
              farmName,
              BigInt.from(price)
            ]));
    await fetchClassModel();
  }
}
