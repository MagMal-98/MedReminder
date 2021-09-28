import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:med_remind/addNote.dart';
import 'package:med_remind/editNote.dart';

class notepad extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF3C4046),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => addNote()));
          },
        ),
        body: Column(
          children: [
            Container(
              height: size.height * 0.05 - 20,
              decoration: BoxDecoration(
                  color: Color(0xFF0C9869),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return ListView.builder(
                          itemCount:
                              snapshot.hasData ? snapshot.data.docs.length : 0,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => editNote(
                                              docToEdit:
                                                  snapshot.data.docs[index],
                                            )));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    height: 54,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 10),
                                              blurRadius: 50,
                                              color: Color(0xFF0C9869)
                                                  .withOpacity(0.23))
                                        ]),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data.docs[index]
                                              .data()['title'],
                                          style: TextStyle(
                                              color: Color(0xFF3C4046)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
          ],
        ));
  }
}
