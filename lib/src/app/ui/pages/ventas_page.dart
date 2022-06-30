import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfrontend/src/app/controllers/order_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ipfrontend/src/app/ui/widgets/progress_indicators/custom_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../inputs/date_pickers.dart' as datepickers;
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key? key}) : super(key: key);

  @override
  State<VentasPage> createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  List<Map<String, dynamic>> _allUsers = [];
  final OrderController orderController = Get.put(OrderController());
  @override
  initState() {
    // _allUsers = await Get.find<ClientProvider>().getClients();

    super.initState();
  }

  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> _dataOrders = [];

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
                    onChanged: (value) => {}, //_runFilter(value),
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
                GetBuilder<OrderController>(
                    init: orderController,
                    initState: (controller) {
                      controller.controller
                          ?.searchClients({"not_paginator": true});
                    },
                    builder: (controller) {
                      if (controller.searchingClients == false) {
                        _foundUsers = controller.clients;
                        return Container(
                          height: 100,
                          child: _foundUsers.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(5),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _foundUsers.length,
                                  itemBuilder: (context, index) {
                                    //print(_foundUsers[index]["code"]);
                                    return Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color:
                                              Color.fromARGB(179, 24, 226, 58),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      key: ValueKey(_foundUsers[index]["code"]),
                                      color: const Color.fromARGB(
                                          255, 254, 253, 252),
                                      child: ListTile(
                                        onTap: () {
                                          controller.searchOrders(
                                              {"not_paginator": true});
                                          showMaterialModalBottomSheet(
                                            expand: false,
                                            context: context,
                                            backgroundColor: Color.fromARGB(
                                                61, 122, 239, 147),
                                            builder: (context) => ListOrder(
                                                controller: controller),
                                          );
                                        },
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 0,
                                        ),
                                        style: ListTileStyle.drawer,
                                        leading: CircleAvatar(
                                          radius: 15,
                                          child: Text(
                                            _foundUsers[index]["number_orders"]
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 12),
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
                        return const CustomProgressIndicator();
                      }
                    })
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: (() {}), child: Icon(Icons.add)),
    );
  }
}

class ListOrder extends StatelessWidget {
  ListOrder({Key? key, required this.controller}) : super(key: key);
  OrderController controller;
  late String name = controller.clients[0]['business_name'];
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: SizedBox(
            height: 20,
            child: Text(
              '$name',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          /*       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 350,
          width: double.maxFinite ,*/
          child: ListView.builder(
              itemCount: controller.orders.length,
              itemBuilder: (context, index) => Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                // flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "N. Pedido",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      // ignore: unnecessary_string_interpolations
                                      controller.orders[index]['number']
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Monto",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.orders[index]['balance'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Estatus",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.orders[index]
                                          ['status_display'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                // flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Vendedor",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.orders[index]['seller'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Fecha",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.orders[index]['date_of_issue'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Completed Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "--",
                                      style: TextStyle(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*  SizedBox(
              height: 5,
            ), */
                          /*       Text(
              "Line Items",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), */
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 280,
                            child: Accordion(
                              maxOpenSections: 2,
                              headerPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              sectionOpeningHapticFeedback:
                                  SectionHapticFeedback.heavy,
                              sectionClosingHapticFeedback:
                                  SectionHapticFeedback.light,
                              children: [
                                AccordionSection(
                                  isOpen: false,
                                  leftIcon: const Icon(
                                      Icons.production_quantity_limits,
                                      color: Colors.white),
                                  headerBackgroundColor: Colors.black,
                                  headerBackgroundColorOpened: Colors.red,
                                  header:
                                      Text('Productos', style: _headerStyle),
                                  content: listviewitems(
                                    controller: controller,
                                  ) /* Text(_loremIpsum, style: _contentStyle) */,
                                  contentHorizontalPadding: 20,
                                  contentBorderWidth: 1,
                                  // onOpenSection: () => print('onOpenSection ...'),
                                  // onCloseSection: () => print('onCloseSection ...'),
                                ),
                              ],
                            ) /* listviewitems() */,
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CardDash extends StatelessWidget {
  CardDash({
    Key? key,
    required this.icon,
    required this.textos,
    required this.color,
  }) : super(key: key);

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

class ParentCard extends StatelessWidget {
  ParentCard({Key? key, required this.controller}) : super(key: key);
  OrderController controller;
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  // flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "N. Pedido",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Cicra Service",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Line of Business",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Plumbing",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Schedule Time",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "8am-9am",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Technician",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "John Smith",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Sceduled Date",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2019-06-07",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Completed Date",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "--",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /*  SizedBox(
              height: 5,
            ), */
            /*       Text(
              "Line Items",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), */
            SizedBox(
              height: 5,
            ),
            Container(
              height: 100,
              child: Accordion(
                maxOpenSections: 2,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: [
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.production_quantity_limits,
                        color: Colors.white),
                    headerBackgroundColor: Colors.black,
                    headerBackgroundColorOpened: Colors.red,
                    header: Text('Productos', style: _headerStyle),
                    content: listviewitems(
                      controller: controller,
                    ) /* Text(_loremIpsum, style: _contentStyle) */,
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                    // onOpenSection: () => print('onOpenSection ...'),
                    // onCloseSection: () => print('onCloseSection ...'),
                  ),
                ],
              ) /* listviewitems() */,
            ),
          ],
        ),
      ),
    );
  }
}

class listviewitems extends StatelessWidget {
  listviewitems({Key? key, required this.controller}) : super(key: key);
  OrderController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text((index + 1).toString() + ". Item Title",
                style: TextStyle(
                  fontSize: 16,
                )),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Status",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Assigned",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Example of service description, Lorem Ipsum.Example of service description, Lorem Ipsum.Example of service description, Lorem Ipsum.",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Parts Required",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "No",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }
}
