import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:med_remind/addPills.dart';
import 'package:med_remind/setReminder.dart';

// ignore: camel_case_types
class pillsList extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('pills');

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF3C4046),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => addPills()));
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
          Expanded(
              child: Container(
                  child: StreamBuilder(
                      stream: ref.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.hasData
                                ? snapshot.data.docs.length
                                : 0,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => setReminder(
                                                pill_name: snapshot
                                                    .data.docs[index]
                                                    .data()['name'],
                                                pill_type: snapshot
                                                    .data.docs[index]
                                                    .data()['category'],
                                              )),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => setReminder(
                                    //               docToEdit: snapshot.data.docs[index],
                                    //             )));
                                  },
                                  child: ListTile(
                                      title: Text(snapshot.data.docs[index]
                                          .data()['name']),
                                      leading: getIcon(snapshot.data.docs[index]
                                          .data()['category'])));
                            });
                      }))),
        ],
      ),
    );
  }

  Icon getIcon(String category) {
    if (category == "Painkillers")
      return Icon(Icons.block_outlined);
    else if (category == "Vitamins")
      return Icon(Icons.local_hospital_outlined);
    else if (category == "Antibiotics")
      return Icon(Icons.coronavirus_outlined);
    else if (category == "Birth Control")
      return Icon(Icons.child_care);
    else if (category == "Anti-allergy")
      return Icon(Icons.eco_outlined);
    else if (category == "Cardiac")
      return Icon(Icons.favorite_border);
    else if (category == "Asthmatic")
      return Icon(Icons.scatter_plot_outlined);
    else
      return Icon(Icons.ac_unit);
  }
}
