// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Contract extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.29.196:7545";
  final String _wsUrl = "ws://192.168.29.196:7545/";

  final String _privateKey =
      "c613f5e9999da2694112158134af3147d16f03dd455986db7a3454d0fcdcc325";
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late Credentials _credentials;
  late ContractFunction _farmerDetails;

  Contract() {
    initiateSetup();
  }

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/main.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);

    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "main"), _contractAddress);
    _farmerDetails = _contract.function("farmerDetails");

    //calling a function;
    print(await _client.call(
        contract: _contract,
        function: _farmerDetails,
        params: [
          "101",
          "Kiran",
          "kiran@gmail.com",
          "A/101",
          "789456123",
          "123"
        ]));
  }
}
