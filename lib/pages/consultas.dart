import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_covid_tapw/pages/store.dart';

class Consultas extends StatefulWidget {
  Consultas({Key key}) : super(key: key);

  //final String title;

  @override
  _ConsultasState createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final databaseReference = Firestore.instance;
  
  Future _getData() async {
    databaseReference
        .collection("consultations")
        .where("patient.email", isEqualTo: "patient@hook.com")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
      return snapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('consultations')
                                      .where("patient.email", isEqualTo: "patient@hook.com")
              .snapshots(),
            builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          return ListTile(
                            title: Text(document['symptom']),
                            leading: CircleAvatar(
                              child: Icon(Icons.content_paste),
                            ),
                            subtitle: Text(document['status']),
                            onTap: () {
                              Store();
                            },
                          );
                      }).toList(),
                    );
                }
              },
            )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
      );
    }
}
