import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class BottonUsuario extends StatelessWidget {
  const BottonUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Container(
      //alignment: Alignment.centerLeft,
      width: 200.0,
      height: 40.0,
      // color: Color.fromARGB(255, 80, 51, 87),
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: () {
          authController.user.value?.name = 'Yonathan';
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: const Icon(Icons.account_circle_outlined,
                  size: 30.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() =>
                      Text(authController.user.value?.name.toString() ?? "")),
                  const Text("Vendedor")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
