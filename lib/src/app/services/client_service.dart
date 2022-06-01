import 'package:ipfrontend/src/app/utils/api.dart';

class ClientService {
  static String url = '/core/client';

  static Future<List<Map<String, dynamic>>> getClients() async {
    /*
    [{"string": {}}]
    */
    final response = await API.list('$url/', params: {"not_paginator": true});
    return List<Map<String, dynamic>>.from(response.data);
  }

  static updateClient(String code, Map<String, dynamic> data) async {
    /*
    [{"string": {}}]
    */
    final response = await API.patch('$url/$code/', data);
    return Map<String, dynamic>.from(response.data);
  }
}
