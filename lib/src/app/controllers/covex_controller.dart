import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConvexController extends GetxController {
  final Rx<int> _index = 0.obs;

  TabController? tabController;

  int get index => _index.value;

  set index(int index) {
    tabController?.index = index;
    _index.value = index;
  }
}
