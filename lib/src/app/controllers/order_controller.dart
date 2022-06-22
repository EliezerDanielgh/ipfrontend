import 'package:get/get.dart';
import 'package:ipfrontend/src/app/models/client_model.dart';
import 'package:ipfrontend/src/app/providers/client_provider.dart';

class OrderController extends GetxController {
  OrderController() {
    searchClients({"not_paginator": true});
  }
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> orders = [];
  ClientProvider clientProvider = ClientProvider();
  bool searchingClients = false;
  String? codeClientSelected;
  Client? client;

  searchClients(Map<String, dynamic> params) async {
    searchingClients = true;
    update();
    clients = await clientProvider.getClients();
    searchingClients = false;
    update();
  }

  updateClient(String code, Map<String, dynamic> data) async {
    final resp = await clientProvider.updateClient(code, data);
    client = Client.fromMap(resp);
    return true;
  }

  selectedClient(String code) {
    codeClientSelected = code;
    orders = [
      {'name': 'Eliezer'},
      {'name': 'Daniel'}
    ];
    update();
  }
}
