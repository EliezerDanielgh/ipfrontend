import 'package:get/get.dart';

class ConvexController extends GetxController {
  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    update();
  }
}
