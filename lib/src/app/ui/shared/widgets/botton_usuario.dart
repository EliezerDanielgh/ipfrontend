import 'package:flutter/material.dart';

class BottonUsuario extends StatelessWidget {
  const BottonUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.centerLeft,
      width: 200.0,
      height: 40.0,
      // color: Color.fromARGB(255, 80, 51, 87),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: () {
          print("Ve a perfil");
        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Icon(Icons.account_circle_outlined,
                  size: 30.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Empresa"), Text("Vendedor")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
