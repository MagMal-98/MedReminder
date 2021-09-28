import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addNote extends StatelessWidget {
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController bloodSugar = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  String _getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd.MM.yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add daily note"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              ref.add({
                'title': 'Note from ' + _getDate(),
                'bloodPressure': bloodPressure.text,
                'bloodSugar': bloodSugar.text,
                'content': content.text,
              }).whenComplete(() => Navigator.pop(context));
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
                      'Note from ' + _getDate(),
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
        ),
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Your blood pressure:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
          margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                  controller: bloodPressure,
                  decoration: InputDecoration(
                      hintText: 'Blood Pressure',
                      hintStyle:
                          TextStyle(color: Color(0xFF0C9869).withOpacity(0.5)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Your blood sugar level:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
          margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                  controller: bloodSugar,
                  decoration: InputDecoration(
                      hintText: 'Blood Sugar Level',
                      hintStyle:
                          TextStyle(color: Color(0xFF0C9869).withOpacity(0.5)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ],
          ),
          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.all(10),
          // child: TextField(
          //   controller: bloodSugar,
          //   decoration: InputDecoration(
          //       labelText: 'Blood Sugar Level',
          //       border: OutlineInputBorder(),
          //       isDense: true),
          //   keyboardType: TextInputType.number,
          //   textInputAction: TextInputAction.done,
          // )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Your mood today:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    controller: content,
                    decoration: InputDecoration(
                        hintText: 'Your mood today',
                        hintStyle: TextStyle(
                            color: Color(0xFF0C9869).withOpacity(0.5)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ]),
    );
  }
}
