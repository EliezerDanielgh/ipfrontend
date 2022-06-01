import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/models/client_model.dart';
import 'package:ipfrontend/src/app/services/client_service.dart';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> clients = [];
  bool searchingClients = false;
  String? codeClientSelected;
  Client? client;

  searchClients(Map<String, dynamic> params) async {
    searchingClients = true;
    notifyListeners();
    clients = await ClientService.getClients();
    searchingClients = false;
    notifyListeners();
  }

  updateClient(String code, Map<String, dynamic> data) async {
    final resp = await ClientService.updateClient(code, data);
    client = Client.fromMap(resp);
    return true;
  }

  selectedClient(String code) {
    codeClientSelected = code;
    notifyListeners();
  }
}
