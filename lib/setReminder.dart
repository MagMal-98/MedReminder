import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

import 'package:med_remind/platformFlatButton.dart';
import 'package:med_remind/notifications.dart';

class setReminder extends StatefulWidget {
  String pill_name;
  String pill_type;
  setReminder({this.pill_name, this.pill_type});

  @override
  _setReminderState createState() => _setReminderState(pill_name, pill_type);
}

class _setReminderState extends State<setReminder> {
  String pill_name;
  String pill_type;
  TextEditingController amount = TextEditingController();
  final type = TextEditingController();
  bool isSwitched = false;
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _setReminderState(this.pill_name, this.pill_type);

  CollectionReference ref = FirebaseFirestore.instance.collection('reminds');

  final List<String> weightValues = ["pills", "ml", "mg"];
  String selectWeight;
  DateTime setDate = DateTime.now();

  String _formatDate(DateTime date) {
    var formatter = new DateFormat('dd.MM.yyyy HH:mm');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  int getTime(DateTime setDate) {
    return setDate.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final focus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Set reminder"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              ref.add({
                'pillName': pill_name,
                'amount': amount.text,
                'type': selectType,
                'everyday': isSwitched.toString(),
                'time': _formatDate(setDate)
              }).whenComplete(() => Navigator.pop(context));
              Random random = new Random();
              int randomNumber = random.nextInt(100000);
              //setDate = setDate.add(Duration(milliseconds: 604800000));
              //time = setDate.millisecondsSinceEpoch;

              _notifications.showNotification(
                  "Medicine Reminder",
                  "Take your medicine: " +
                      pill_name +
                      ", " +
                      amount.text +
                      " " +
                      selectType,
                  setDate,
                  randomNumber,
                  flutterLocalNotificationsPlugin);
            },
            child: Text('Save'),
          )
        ],
      ),
      body: Column(children: [
        Container(
          height: size.height * 0.15,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.15 - 27,
                decoration: BoxDecoration(
                    color: Color(0xFF0C9869),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    )),
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 54,
                    child: Text(
                      pill_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "latin1",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ))
            ],
          ),

          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.all(10),
          // decoration: BoxDecoration(border: Border.all()),
          // child: Text(
          //   pill_name,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontSize: 25.0,
          //       fontFamily: "latin1",
          //       fontWeight: FontWeight.bold,
          //       color: Colors.blueGrey),
          // ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.03,
        // ),

        Container(
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 24,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Stack(
                        children: [
                          Text(
                            "Pills amount:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 6,
                              color: Color(0xFF0C9869).withOpacity(0.2),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xFF0C9869).withOpacity(0.23))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: amount,
                              decoration: InputDecoration(
                                  hintText: 'Pills Amount',
                                  hintStyle: TextStyle(
                                      color:
                                          Color(0xFF0C9869).withOpacity(0.5)),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                        ],
                      ),

                      // height: MediaQuery.of(context).size.height * 0.22,
                      // child: TextField(
                      //   controller: amount,
                      //   keyboardType: TextInputType.number,
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 16.0),
                      //   decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.symmetric(
                      //           horizontal: 15.0, vertical: 20.0),
                      //       labelText: "Pills Amount",
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10.0),
                      //           borderSide:
                      //               BorderSide(width: 0.5, color: Colors.grey))),
                      //   onSubmitted: (val) => focus.unfocus(),
                      // ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.0),
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xFF0C9869).withOpacity(0.23))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                              child: Center(
                            child: DropdownButton(
                              hint: Text("Type",
                                  style: TextStyle(
                                      color:
                                          Color(0xFF0C9869).withOpacity(0.5))),
                              isExpanded: true,
                              value: selectType,
                              underline: SizedBox(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectType = newValue;
                                });
                              },
                              items: weightValues.map((valeItem) {
                                return DropdownMenuItem(
                                    value: valeItem,
                                    child: Text(
                                      valeItem,
                                    ));
                              }).toList(),
                            ),
                          )),
                        ],
                      ),

                      // height: MediaQuery.of(context).size.height * 0.22,
                      // child: DropdownButtonFormField(
                      //   onTap: () => focus.unfocus(),
                      //   decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.symmetric(
                      //           horizontal: 15.0, vertical: 20.0),
                      //       labelText: "Type",
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10.0),
                      //           borderSide:
                      //               BorderSide(width: 0.5, color: Colors.grey))),
                      //   items: weightValues
                      //       .map((weight) => DropdownMenuItem(
                      //             child: Text(weight),
                      //             value: weight,
                      //           ))
                      //       .toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectType = value;
                      //     });
                      //   },
                      //   value: selectWeight,
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Container(
          height: 24,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Pick date and time of the reminder:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 6,
                  color: Color(0xFF0C9869).withOpacity(0.2),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.5),
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: PlatformFlatButton(
                    handler: () => showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            helpText: "Choose Time")
                        .then((value) {
                      DateTime timePick = DateTime(
                          setDate.year,
                          setDate.month,
                          setDate.day,
                          value != null ? value.hour : setDate.hour,
                          value != null ? value.minute : setDate.minute);
                      setState(() => setDate = timePick);
                      print(timePick.hour);
                      print(timePick.minute);
                    }),
                    buttonChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          DateFormat.Hm().format(this.setDate),
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.access_time,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    color: Color.fromRGBO(7, 190, 200, 0.1),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: PlatformFlatButton(
                    handler: () => showDatePicker(
                            context: context,
                            initialDate: setDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(Duration(days: 100000)))
                        .then((value) {
                      DateTime datePick = DateTime(
                          value != null ? value.year : setDate.year,
                          value != null ? value.month : setDate.month,
                          value != null ? value.day : setDate.day,
                          setDate.hour,
                          setDate.minute);
                      setState(() => setDate = datePick);
                      print(setDate.day);
                      print(setDate.month);
                      print(setDate.year);
                    }),
                    buttonChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          DateFormat("dd.MM").format(this.setDate),
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.event,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    color: Color.fromRGBO(7, 190, 200, 0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Container(
          height: 24,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Check if you need everyday reminder:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 6,
                  color: Color(0xFF0C9869).withOpacity(0.2),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
            child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0),
              height: MediaQuery.of(context).size.height * 0.03,
              child: FittedBox(
                  child: Text(
                "Remind Everyday",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.black),
              )),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Color(0xFF0C9869).withOpacity(0.5),
                activeColor: Color(0xFF3C4046),
              ),
            )
          ],
        ))
      ]),
    );
  }
}

String selectType;
