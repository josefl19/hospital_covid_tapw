import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_covid_tapw/pages/custom_card.dart';

class Paciente extends StatefulWidget {
  Paciente({Key key}) : super(key: key);

  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  final databaseReference = Firestore.instance;
  
  Future _getData() async {
    databaseReference
        .collection("users")
        .where("type", isEqualTo: "patient")
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
                                      .where("answerby.email", isEqualTo: "doctor@chapatin.com")
                                      .where("status", isEqualTo: "close")
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
                          return new CustomCard(
                            covid: document['patient']['covid'],
                            nacimiento: document['patient']['birthday'],
                            paciente: document['patient']['name'],
                            precond: document['patient']['preconditions'],
                            prescription: document['prescription'],
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
