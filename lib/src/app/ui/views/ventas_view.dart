import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../inputs/date_pickers.dart' as datepickers;

class VentasView extends StatefulWidget {
  const VentasView({Key? key}) : super(key: key);

  @override
  State<VentasView> createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
    // Refresh the UI
  }

  @override
  void initState() {
    _foundUsers = _allUsers;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: CardDash(
                  icon: Icon(Icons.abc_rounded),
                  textos: ['Cuentas', 'Datos'],
                  color: Color.fromARGB(255, 219, 101, 33),
                ),
              ),
              Expanded(
                flex: 1,
                child: CardDash(
                  icon: Icon(Icons.abc_rounded),
                  textos: ['Cuentas', 'Datos'],
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  child: FilterTab(),
                ),
                const SizedBox(
                  height: 20,
                  child: Text('Pedidos'),
                ),
                SizedBox(
                  height: 30,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 250,
                  child: _foundUsers.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(179, 24, 226, 58),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            key: ValueKey(_foundUsers[index]["id"]),
                            color: Color.fromARGB(255, 254, 253, 252),
                            child: ListTile(
                              onTap: () => showMaterialModalBottomSheet(
                                expand: false,
                                context: context,
                                backgroundColor: Colors.amber,
                                builder: (context) => Container(
                                  child: SizedBox(
                                      height: 350,
                                      child: ListView.builder(
                                          itemCount: _foundUsers.length,
                                          itemBuilder: (context, index) => Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        179, 24, 226, 58),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              key: ValueKey(
                                                  _foundUsers[index]["id"]),
                                              color: Color.fromARGB(
                                                  255, 254, 253, 252),
                                              child: ListTile(
                                                title: Text(
                                                  _foundUsers[index]['name'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )))),
                                ),
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                radius: 15,
                                child: Text(
                                  _foundUsers[index]["id"].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              title: Text(
                                _foundUsers[index]['name'],
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                '${_foundUsers[index]["age"].toString()} years old',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        height: 45,
        elevation: 6,
        style: TabStyle.custom,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.book, title: 'Pedidos'),
          TabItem(icon: Icons.copy, title: 'Cotizacion'),
          TabItem(icon: Icons.paid, title: 'Cobranzas'),
          // TabItem(icon: Icons.message, title: 'Message'),
          // TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}

class CardDash extends StatelessWidget {
  CardDash({
    required this.icon,
    required this.textos,
    required this.color,
  });

  Icon icon;
  List<String> textos;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(179, 247, 56, 8), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8.0),
      // color: Color.fromARGB(255, 248, 248, 245),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [...textos.map((e) => Text(e))],
            )
          ],
        ),
      ),
    );
  }
}

class FilterTab extends StatelessWidget {
  const FilterTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Container(
      // color: Color.fromARGB(0, 255, 49, 49),
      //margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
      width: double.infinity,
      //height: double.infinity,
      child: Column(children: [
        DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(0, 29, 6, 238),
                ),
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(bottom: 100),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: TabBar(
                          indicatorWeight: 0,
                          labelPadding: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(5.0),
                          labelColor: Color.fromARGB(255, 255, 255, 255),
                          unselectedLabelColor: Color.fromARGB(255, 90, 90, 90),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).primaryColor,
                          ),
                          tabs: const [
                            Tab(
                              child: Text(
                                "Diario",
                                style: TextStyle(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Semanal",
                                style: TextStyle(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Mensual",
                                style: TextStyle(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Anual",
                                style: TextStyle(),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: double.infinity,
                      height: 35,
                      child: const TabBarView(children: [
                        datepickers.DayPicker(),
                        datepickers.WeekPicker(),
                        datepickers.MesPicker(),
                        datepickers.YearPicker()
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // datepickers.DayPicker()
      ]),
    );
  }
}
