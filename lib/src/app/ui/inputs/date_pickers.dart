import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

//dependencies:
//  intl: ^0.17.0
final DateFormat formatterFechaCompleta = DateFormat('d MMM yyyy', 'es_MX');
final DateFormat formatterMes = DateFormat('MMM', 'es_MX');
final DateFormat formatterSemana = DateFormat('d MMM', 'es_MX');

DateTime fechaDeHoy = DateTime.now();
DateTime fechaSelecionada = fechaDeHoy;

DateTime dateInicial = fechaDeHoy;
DateTime dateFinal = fechaDeHoy;
//var fechaDeHoy = DateTime.now();
//DateTime currentselectedDate = DateTime.now();

class DayPicker extends StatefulWidget {
  const DayPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  var realselecteddatestring = formatterFechaCompleta.format(DateTime.now());
  var diam = DateTime(fechaDeHoy.year, fechaDeHoy.month, fechaDeHoy.day - 1);
  var diaM = DateTime(fechaDeHoy.year, fechaDeHoy.month, fechaDeHoy.day + 1);

  Future ShowDayPickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: fechaDeHoy,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
  }

  void callDayPicker() async {
    DateTime selecteddate = await ShowDayPickerWidget();
    setState(() {
      fechaDeHoy = selecteddate;
      fechaSelecionada =
          DateTime(selecteddate.year, selecteddate.month, selecteddate.day);
      diam = DateTime(fechaSelecionada.year, fechaSelecionada.month,
          fechaSelecionada.day - 1);
      diaM = DateTime(fechaSelecionada.year, fechaSelecionada.month,
          fechaSelecionada.day + 1);
      initializeDateFormatting();
      realselecteddatestring = formatterFechaCompleta.format(fechaSelecionada);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 212, 212, 212),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: 25,
                height: 25,
                margin: const EdgeInsets.only(left: 20),
                //color: Colors.red,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.date_range_outlined),
                  color: Theme.of(context).primaryColorDark,
                  splashRadius: 1,
                  onPressed: () {
                    callDayPicker();
                  },
                )),
            Expanded(
              child: Text(
                //"",
                (realselecteddatestring),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 25,
                      height: 25,
                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        onPressed: () {
                          fechaSelecionada = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day - 1);
                          diam = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day - 1);
                          diaM = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day + 1);
                          initializeDateFormatting();
                          realselecteddatestring =
                              formatterFechaCompleta.format(fechaSelecionada);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_left_outlined),
                        color: Theme.of(context).primaryColorDark,
                      )),

                  SizedBox(
                    width: 20,
                    child: Text(
                      diam.day.toString(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // SizedBox(width: 5),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        fechaSelecionada.day.toString(),
                        //textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // SizedBox(width: 5),
                  SizedBox(
                    width: 20,
                    child: Text(
                      diaM.day.toString(),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  SizedBox(
                      width: 25,
                      height: 25,
                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        onPressed: () {
                          fechaSelecionada = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day + 1);
                          diam = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day - 1);
                          diaM = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month, fechaSelecionada.day + 1);
                          initializeDateFormatting();
                          realselecteddatestring =
                              formatterFechaCompleta.format(fechaSelecionada);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_right_outlined),
                        color: Theme.of(context).primaryColorDark,
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}

class WeekPicker extends StatefulWidget {
  const WeekPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  var realselecteddatestring = formatterSemana.format(DateTime.now());
  var diaslunes = fechaDeHoy.day - (fechaDeHoy.weekday - 1);

  late var diasemanainicial =
      DateTime(fechaDeHoy.year, fechaDeHoy.month, diaslunes);
  late var diasemanafinal = DateTime(
      diasemanainicial.year, diasemanainicial.month, diasemanainicial.day + 6);

  late var diasemanaantesinicial = DateTime(
      diasemanainicial.year, diasemanainicial.month, diasemanainicial.day - 6);
  late var diasemanaantesfinal = DateTime(diasemanaantesinicial.year,
      diasemanaantesinicial.month, diasemanaantesinicial.day + 6);

  late var diasemanadespuesinicial = DateTime(
      diasemanainicial.year, diasemanainicial.month, diasemanainicial.day + 6);
  late var diaSemanadespuesfinal = DateTime(diasemanadespuesinicial.year,
      diasemanadespuesinicial.month, diasemanadespuesinicial.day + 6);

  late var diasemanainicials = formatterSemana.format(diasemanainicial);
  late var diasemanafinals = formatterSemana.format(diasemanafinal);
  //late var PrimerDia = DiaSemanaInicial.day - DiaSemanaInicial.weekday;

  //var SelectWeek = CurrentselectedDate.day;
  //var diam = fechaDeHoy.subtract(const Duration(days: 1));
  //var diaM = fechaDeHoy.add(const Duration(days: 1));

  Future getDayPickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: diasemanainicial,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
  }

  void callDayPicker() async {
    DateTime selecteddate = await getDayPickerWidget();
    setState(() {
      diaslunes = selecteddate.day - (selecteddate.weekday - 1);
      diasemanainicial = DateTime(fechaDeHoy.year, fechaDeHoy.month, diaslunes);
      diasemanafinal = DateTime(diasemanainicial.year, diasemanainicial.month,
          diasemanainicial.day + 6);
      initializeDateFormatting();
      realselecteddatestring = formatterSemana.format(fechaDeHoy);
      diasemanainicials = formatterSemana.format(diasemanainicial);
      diasemanafinals = formatterSemana.format(diasemanafinal);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Container(
        //margin: const EdgeInsets.only(top: 10, right: 12.5, left: 12.5),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 209, 209, 209),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        child: SizedBox(
            width: 25,
            height: 25,
            child: Row(
              //color: Colors.red,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(left: 20),
                  //color: Colors.red,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    splashRadius: 1,
                    //color: Colors.amber,
                    icon: const Icon(Icons.date_range_outlined),
                    color: Theme.of(context).primaryColorDark,

                    //iconSize: 5,

                    alignment: Alignment.center,
                    onPressed: () {
                      callDayPicker();
                    },
                  ),
                ),

                Expanded(
                  child: Text(
                    //"",
                    (diasemanainicials + " | " + diasemanafinals),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                // Expanded(child: Container()),
                SizedBox(
                  width: 170,
                  //height: 40,
                  //alignment: Alignment.bottomCenter,
                  //padding: EdgeInsets.only(right: 10),
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 25,
                          height: 25,
                          //color: Colors.blue,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 1,
                            onPressed: () {
                              //++CurrentselectedDate.day;
                              // --dia;
                              //fechaDeHoy = DateTime(CurrentselectedDate.year,CurrentselectedDate.month, dia);
                              //Selectdia = fechaDeHoy.day;
                              //DiaSemanaInicial = DiaSemanaInicial.subtract(const Duration(days: 1));
                              diasemanainicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day - 7);
                              diasemanafinal = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day + 6);

                              diasemanaantesinicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day - 7);
                              diasemanaantesfinal = DateTime(
                                  diasemanaantesinicial.year,
                                  diasemanaantesinicial.month,
                                  diasemanaantesinicial.day + 6);

                              diasemanadespuesinicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day + 7);
                              diaSemanadespuesfinal = DateTime(
                                  diasemanadespuesinicial.year,
                                  diasemanadespuesinicial.month,
                                  diasemanadespuesinicial.day + 6);

                              diasemanainicials =
                                  formatterSemana.format(diasemanainicial);
                              diasemanafinals =
                                  formatterSemana.format(diasemanafinal);
                              initializeDateFormatting();
                              //  RealSelectedDateString =
                              //   formatterDia.format(fechaDeHoy);
                              setState(() {});
                            },
                            icon: const Icon(Icons.chevron_left_outlined),
                            color: Theme.of(context).primaryColorDark,
                          )),

                      SizedBox(
                        width: 35,
                        child: Text(
                          diasemanaantesinicial.day.toString() +
                              "|" +
                              diasemanaantesfinal.day.toString(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // SizedBox(width: 5),

                      Container(
                        margin: const EdgeInsets.all(2),
                        width: 45,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            diasemanainicial.day.toString() +
                                " | " +
                                diasemanafinal.day.toString(),
                            //textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      SizedBox(
                        width: 35,
                        child: Text(
                          diasemanadespuesinicial.day.toString() +
                              "|" +
                              diaSemanadespuesfinal.day.toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),

                      SizedBox(
                          width: 25,
                          height: 25,
                          //color: Colors.red,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 1,
                            onPressed: () {
                              // ++dia;
                              //  fechaDeHoy = DateTime(CurrentselectedDate.year,
                              //      CurrentselectedDate.month, dia);
                              //Selectdia = fechaDeHoy.day;
                              diaslunes = diasemanainicial.day -
                                  (fechaDeHoy.weekday - 1);
                              diasemanainicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day + 7);
                              diasemanafinal = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day + 6);

                              diasemanaantesinicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day - 7);
                              diasemanaantesfinal = DateTime(
                                  diasemanaantesinicial.year,
                                  diasemanaantesinicial.month,
                                  diasemanaantesinicial.day + 6);

                              diasemanadespuesinicial = DateTime(
                                  diasemanainicial.year,
                                  diasemanainicial.month,
                                  diasemanainicial.day + 7);
                              diaSemanadespuesfinal = DateTime(
                                  diasemanadespuesinicial.year,
                                  diasemanadespuesinicial.month,
                                  diasemanadespuesinicial.day + 6);

                              diasemanainicials =
                                  formatterSemana.format(diasemanainicial);
                              diasemanafinals =
                                  formatterSemana.format(diasemanafinal);
                              initializeDateFormatting();
                              //RealSelectedDateString =
                              //formatterDia.format(fechaDeHoy);
                              setState(() {});
                            },
                            icon: const Icon(Icons.chevron_right_outlined),
                            color: Theme.of(context).primaryColorDark,
                          ))
                    ],
                  ),
                ),
              ],
            )));
  }
}

class MesPicker extends StatefulWidget {
  const MesPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<MesPicker> createState() => _MesPickerState();
}

class _MesPickerState extends State<MesPicker> {
  late var mesm = DateTime(
      fechaSelecionada.year, fechaSelecionada.month - 1, fechaSelecionada.day);
  late var mesM = DateTime(
      fechaSelecionada.year, fechaSelecionada.month + 1, fechaSelecionada.day);
  var realselecteddatestring = formatterMes.format(fechaDeHoy);
  late String mesmS = formatterMes.format(mesm);
  late String mesMS = formatterMes.format(mesM);

  Future getDayPickerWidget() {
    return showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: fechaSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
  }

  void callDayPicker() async {
    DateTime selectmes = await getDayPickerWidget();
    setState(() {
      /*if (SelectedDate == null) {
        SelectedDate = fechaDeHoy;
      }*/
      fechaSelecionada = selectmes;
      //Selectyear = CurrentselectedDate.year;
      mesm = DateTime(fechaSelecionada.year, fechaSelecionada.month - 1,
          fechaSelecionada.day);
      mesM = DateTime(fechaSelecionada.year, fechaSelecionada.month + 1,
          fechaSelecionada.day);

      //year =
      //    DateTime(Selectyear.year, Selectyear.month, Selectyear.year);
      initializeDateFormatting();
      realselecteddatestring = formatterMes.format(fechaSelecionada);
      mesmS = formatterMes.format(mesm);
      mesMS = formatterMes.format(mesM);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Container(
        // margin: const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 218, 218, 218),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: 25,
                height: 25,
                margin: const EdgeInsets.only(left: 20),
                //color: Colors.red,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  splashRadius: 1,
                  icon: const Icon(Icons.date_range_outlined),
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    callDayPicker();
                  },
                )),
            Expanded(
              child: Text(
                //"",
                (realselecteddatestring +
                    " " +
                    fechaSelecionada.year.toString()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            // Expanded(child: Container()),
            SizedBox(
              width: 180,
              //height: 20,
              //alignment: Alignment.bottomRight,
              //padding: EdgeInsets.only(right: 10),
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 25,
                      height: 25,

                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        onPressed: () {
                          //++CurrentselectedDate.day;
                          //--year;
                          fechaSelecionada = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month - 1, fechaSelecionada.day);
                          mesm = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month - 1, fechaSelecionada.day);
                          mesM = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month + 1, fechaSelecionada.day);
                          mesmS = mesm.toString();
                          mesMS = mesM.toString();
                          initializeDateFormatting();
                          realselecteddatestring =
                              formatterMes.format(fechaSelecionada);
                          mesmS = formatterMes.format(mesm);
                          mesMS = formatterMes.format(mesM);
                          // initializeDateFormatting();
                          // RealSelectedDateString =
                          //    formatter.format(fechaDeHoy);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_left_outlined),
                        color: Theme.of(context).primaryColorDark,
                      )),

                  SizedBox(
                    width: 35,
                    child: Text(
                      mesmS,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // SizedBox(width: 5),
                  Container(
                    width: 35,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        realselecteddatestring,
                        //textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // SizedBox(width: 5),
                  SizedBox(
                    width: 35,
                    child: Text(
                      mesMS,
                      textAlign: TextAlign.right,
                    ),
                  ),

                  SizedBox(
                      width: 25,
                      height: 25,
                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        onPressed: () {
                          fechaSelecionada = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month + 1, fechaSelecionada.day);
                          mesm = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month - 1, fechaSelecionada.day);
                          mesM = DateTime(fechaSelecionada.year,
                              fechaSelecionada.month + 1, fechaSelecionada.day);
                          //Selectyear = fechaDeHoy.year;
                          //mesm = mes.subtract(const Duration(days: 30));
                          //mesM = mes.add(const Duration(days: 30));
                          mesmS = mesm.toString();
                          mesMS = mesM.toString();
                          initializeDateFormatting();
                          realselecteddatestring =
                              formatterMes.format(fechaSelecionada);
                          mesmS = formatterMes.format(mesm);
                          mesMS = formatterMes.format(mesM);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_right_outlined),
                        color: Theme.of(context).primaryColorDark,
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}

class YearPicker extends StatefulWidget {
  const YearPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  //var fechaSelecionada = fechaDeHoy;
  var yearm = DateTime(fechaDeHoy.year - 1, fechaDeHoy.month, fechaDeHoy.day);
  var yearM = DateTime(fechaDeHoy.year + 1, fechaDeHoy.month, fechaDeHoy.day);

  Future getDayPickerWidget() {
    return showDatePicker(
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: fechaSelecionada,
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
  }

  void callDayPicker() async {
    DateTime selectyear = await getDayPickerWidget();
    setState(() {
      /*if (SelectedDate == null) {
        SelectedDate = fechaDeHoy;
      }*/
      fechaSelecionada = selectyear;
      //Selectyear = CurrentselectedDate.year;
      yearm = DateTime(fechaDeHoy.year - 1, fechaDeHoy.month, fechaDeHoy.day);
      yearM = DateTime(fechaDeHoy.year + 1, fechaDeHoy.month, fechaDeHoy.day);
      //year =
      //    DateTime(Selectyear.year, Selectyear.month, Selectyear.year);
      //  initializeDateFormatting();
      // RealSelectedDateString = formatter.format(fechaDeHoy);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Container(
        //margin: const EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 230, 230, 230),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: 25,
                height: 25,
                margin: const EdgeInsets.only(left: 30),
                //color: Colors.red,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  splashRadius: 1,
                  icon: const Icon(Icons.date_range_outlined),
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    callDayPicker();
                  },
                )),
            Expanded(
              child: Text(
                //"",
                ("Año " + fechaSelecionada.year.toString()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            // Expanded(child: Container()),
            SizedBox(
              width: 180,
              //alignment: Alignment.bottomCenter,
              //padding: EdgeInsets.only(right: 10),
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 25,
                      height: 25,
                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        onPressed: () {
                          //++CurrentselectedDate.day;
                          //--year;
                          fechaSelecionada = DateTime(fechaSelecionada.year - 1,
                              fechaSelecionada.month, fechaSelecionada.day);
                          //Selectyear = fechaDeHoy.year;
                          // yearm = year.subtract(const Duration(days: 365));
                          // yearM = year.add(const Duration(days: 365));
                          yearm = DateTime(fechaSelecionada.year - 1,
                              fechaDeHoy.month, fechaDeHoy.day);
                          yearM = DateTime(fechaSelecionada.year + 1,
                              fechaDeHoy.month, fechaDeHoy.day);
                          // initializeDateFormatting();
                          // RealSelectedDateString =
                          //    formatter.format(fechaDeHoy);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_left_outlined),
                        color: Theme.of(context).primaryColorDark,
                      )),

                  SizedBox(
                    width: 35,
                    child: Text(
                      yearm.year.toString(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // SizedBox(width: 5),
                  Container(
                    width: 35,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        fechaSelecionada.year.toString(),
                        //textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // SizedBox(width: 5),
                  SizedBox(
                    width: 35,
                    child: Text(
                      yearM.year.toString(),
                      textAlign: TextAlign.right,
                    ),
                  ),

                  SizedBox(
                      width: 25,
                      height: 25,
                      //color: Colors.red,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        splashRadius: 1,
                        alignment: Alignment.center,
                        onPressed: () {
                          fechaSelecionada = DateTime(fechaSelecionada.year + 1,
                              fechaSelecionada.month, fechaSelecionada.day);
                          //Selectyear = fechaDeHoy.year;
                          yearm = DateTime(fechaSelecionada.year - 1,
                              fechaDeHoy.month, fechaDeHoy.day);
                          yearM = DateTime(fechaSelecionada.year + 1,
                              fechaDeHoy.month, fechaDeHoy.day);
                          setState(() {});
                        },
                        icon: const Icon(Icons.chevron_right_outlined),
                        color: Theme.of(context).primaryColorDark,
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
