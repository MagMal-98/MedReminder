import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield/dropdownfield.dart';

class addPills extends StatefulWidget {
  @override
  _addPillsState createState() => _addPillsState();
}

class _addPillsState extends State<addPills> {
  TextEditingController pillName = TextEditingController();
  final pillCategory = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('pills');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              ref.add({
                'name': pillName.text,
                'category': selectCategory,
                //pillCategory.text,
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
                      'Add new medicine to database',
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  controller: pillName,
                  decoration: InputDecoration(
                      hintText: "Medicine name",
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
          height: 24,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Text(
                "Pick medicine category:",
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
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        //Expanded(
        //child:
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
                  child: Center(
                child: DropdownButton(
                  hint: Text("Select category",
                      style:
                          TextStyle(color: Color(0xFF0C9869).withOpacity(0.5))),
                  isExpanded: true,
                  value: selectCategory,
                  underline: SizedBox(),
                  onChanged: (newValue) {
                    setState(() {
                      selectCategory = newValue;
                    });
                  },
                  items: category.map((valeItem) {
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
        ),
      ]),
    );
  }
}


String selectCategory;
List category = [
  "Painkillers",
  "Vitamins",
  "Birth Control",
  "Anti-allergy",
  "Cardiac",
  "Asthmatic",
];
