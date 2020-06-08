import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_covid_tapw/pages/custom_card.dart';

class Historial extends StatelessWidget {
  final String user;
  final String idDoctor;
  
  Historial({Key key, @required this.user, @required this.idDoctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Historiales de consulta'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('consultations')
                                      .where("answerby.id", isEqualTo: idDoctor)
                                      .where("answerby.user", isEqualTo: user)
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
            )
          )
        );
  }
}