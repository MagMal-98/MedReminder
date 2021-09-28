import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:med_remind/pillsList.dart';

// ignore: camel_case_types
class mainScreen extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('reminds');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      Container(
        height: size.height * 0.05 - 20,
        decoration: BoxDecoration(
            color: Color(0xFF0C9869),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
      ),
      Expanded(
        child: Container(
          child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => setReminder(
                            //             pill_name: snapshot.data.docs[index]
                            //                 .data()['name'],
                            //             pill_type: snapshot.data.docs[index]
                            //                 .data()['category'],
                            //           )),
                            // );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => setReminder(
                            //               docToEdit: snapshot.data.docs[index],
                            //             )));
                          },
                          child: ListTile(
                              title: Text(snapshot.data.docs[index]
                                      .data()['pillName'] +
                                  ", " +
                                  snapshot.data.docs[index].data()['amount'] +
                                  " " +
                                  snapshot.data.docs[index].data()['type']),
                              subtitle: Text(getWhen(
                                  snapshot.data.docs[index].data()['everyday'],
                                  snapshot.data.docs[index].data()['time'])),
                              leading: Icon(Icons.alarm)));
                    });
              }),
        ),
      ),
    ]));
  }

  String getWhen(String when, String date) {
    if (when == "true") {
      return "everyday";
    } else
      return date;
  }
}
