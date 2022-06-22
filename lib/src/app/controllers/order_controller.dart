import 'package:get/get.dart';
import 'package:ipfrontend/src/app/models/client_model.dart';

class OrderController extends GetxController {
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> orders = [];

  bool searchingClients = false;
  String? codeClientSelected;
  Client? client;

  searchClients(Map<String, dynamic> params) async {
    searchingClients = true;
    update();
    clients = await ClientProvider.getClients();
    searchingClients = false;
    update();
  }

  updateClient(String code, Map<String, dynamic> data) async {
    final resp = await ClientProvider.updateClient(code, data);
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
