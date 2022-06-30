import 'package:get/get.dart';
import 'package:ipfrontend/src/app/models/client_model.dart';
import 'package:ipfrontend/src/app/providers/client_provider.dart';
import 'package:ipfrontend/src/app/providers/order_provider.dart';

class OrderController extends GetxController {
  OrderController() {
    searchClients({"not_paginator": true});
  }
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> orders = [];
  ClientProvider clientProvider = ClientProvider();
  OrderProvider orderProvider = OrderProvider();
  bool searchingClients = false;
  bool searchingOrders = false;

  Client? client;

  searchClients(Map<String, dynamic> params) async {
    searchingClients = true;
    update();
    clients = await clientProvider.getClients(params);
    searchingClients = false;
    update();
  }

  updateClient(String code, Map<String, dynamic> data) async {
    final resp = await clientProvider.updateClient(code, data);
    client = Client.fromMap(resp);
    return true;
  }

  searchOrders(Map<String, dynamic> params) async {
    searchingOrders = true;
    update();
    orders = await orderProvider.getOrders(params);
    print('object $orders');
    searchingOrders = false;
    update();
  }
}
