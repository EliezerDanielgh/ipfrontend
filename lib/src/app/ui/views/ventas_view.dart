import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ipfrontend/src/app/components/my_progress_indicator.dart';
import 'package:ipfrontend/src/app/providers/order_provider.dart';
import 'package:ipfrontend/src/app/services/client_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../inputs/date_pickers.dart' as datepickers;

class VentasView extends StatefulWidget {
  const VentasView({Key? key}) : super(key: key);

  @override
  State<VentasView> createState() => _VentasViewState();
}

class _VentasViewState extends State<VentasView> {
  List<Map<String, dynamic>> _allUsers = [];

  @override
  initState() {
    super.initState();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.searchClients({});
    // _foundUsers = _allUsers;
  }

  // final List<Map<String, dynamic>> _allUsers = [
  //   {"id": 1, "name": "Andy", "age": 29},
  //   {"id": 2, "name": "Aragon", "age": 40},
  //   {"id": 3, "name": "Bob", "age": 5},
  //   {"id": 4, "name": "Barbara", "age": 35},
  //   {"id": 5, "name": "Candy", "age": 21},
  //   {"id": 6, "name": "Colin", "age": 55},
  //   {"id": 7, "name": "Audra", "age": 30},
  //   {"id": 8, "name": "Banana", "age": 14},
  //   {"id": 9, "name": "Caversky", "age": 100},
  //   {"id": 10, "name": "Becky", "age": 32},
  // ];

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
                        labelText: 'Buscar Cliente',
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) {
                  if (orderProvider.searchingClients == false) {
                    _foundUsers = orderProvider.clients;
                    return Container(
                      height: 250,
                      child: _foundUsers.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                              itemCount: _foundUsers.length,
                              itemBuilder: (context, index) {
                                print(_foundUsers[index]["code"]);
                                return Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color.fromARGB(179, 24, 226, 58),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  key: ValueKey(_foundUsers[index]["code"]),
                                  color:
                                      const Color.fromARGB(255, 254, 253, 252),
                                  child: ListTile(
                                    onTap: () {
                                      orderProvider.selectedClient(
                                          _foundUsers[index]["code"]);
                                      showMaterialModalBottomSheet(
                                        expand: false,
                                        context: context,
                                        backgroundColor:
                                            Color.fromARGB(61, 122, 239, 147),
                                        builder: (context) =>
                                            Consumer<OrderProvider>(builder:
                                                (context, provider, child) {
                                          return Container(
                                            height: 450,
                                            child: ListView.builder(
                                              itemCount: provider.orders.length,
                                              itemBuilder: (context, index) =>
                                                  Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: ListTile(
                                                  dense: false,
                                                  leading: FlutterLogo(),
                                                  title: Text(
                                                    "Flutter Easy Learning\nTutorial #31",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    "Instructor: Mustafa Tahir",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 0,
                                    ),
                                    style: ListTileStyle.drawer,
                                    leading: CircleAvatar(
                                      radius: 15,
                                      child: Text(
                                        _foundUsers[index]["number_orders"]
                                            .toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    title: Text(
                                      _foundUsers[index]['business_name'],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      _foundUsers[index]['description'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            ),
                    );
                  } else {
                    return const MyProgressIndicator();
                  }
                })
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        marginBottom: 10, //margin bottom
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.deepOrangeAccent, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor:
            Colors.deepPurpleAccent, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: 56.0, //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          /*          SpeedDialChild(
            //speed dial child
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'First Menu Child',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ), */
          SpeedDialChild(
            child: Icon(Icons.content_copy),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Nueva Cotizacìon',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.bookmark_add_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Nuevo Pedido',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),

          //add more menu item children here
        ],
      ),
      //bottomNavigationBar: flutterBar(),
    );
  }
}

class flutterBar extends StatefulWidget {
  const flutterBar({
    Key? key,
  }) : super(key: key);

  @override
  State<flutterBar> createState() => _flutterBarState();
}

class _flutterBarState extends State<flutterBar> {
  @override
  Widget build(BuildContext context) {
    int selectedpage = 0;
    final _pageNo = [Home()];
    return ConvexAppBar(
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
      initialActiveIndex: selectedpage,
      onTap: (int index) {
        setState(() {
          selectedpage = index;
        });
      },
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

class FilterTab extends StatefulWidget {
  const FilterTab({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterTab> createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab>
    with SingleTickerProviderStateMixin {
  late TabController controllerTab;
  @override
  initState() {
    super.initState();
    controllerTab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controllerTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controllerTab.addListener(() {
      if (!controllerTab.indexIsChanging) {
        print('controller ${controllerTab.index}');
        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        orderProvider.searchClients({});
        // Your code goes here.
        // To get index of current tab use tabController.index
      }
    });
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
                          controller: controllerTab,
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
                      child: TabBarView(
                        children: [
                          datepickers.DayPicker(),
                          datepickers.WeekPicker(),
                          datepickers.MesPicker(),
                          datepickers.YearPicker()
                        ],
                        controller: controllerTab,
                      ),
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
