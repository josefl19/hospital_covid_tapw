import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Consultas extends StatefulWidget {
  Consultas({Key key}) : super(key: key);

  //final String title;

  @override
  _ConsultasState createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final databaseReference = Firestore.instance;
  var idUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(32.0),
            child: TextField(
              //obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID Usuario',
              ),
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Consultas'),
                      content: _listConsulta(value),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  TextEditingController dialogSintomas;
  TextEditingController dialogEspecialidad;
  TextEditingController dialogEmail;

  @override
  initState() {
    dialogSintomas = new TextEditingController();
    dialogEspecialidad = new TextEditingController();
    dialogEmail = new TextEditingController();
    super.initState();
  }

  _listConsulta(String id) {
    idUser = id;
    return Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('consultations')
              .where("patient.id", isEqualTo: id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text(document['symptom']),
                      leading: CircleAvatar(
                        child: Icon(Icons.content_paste),
                      ),
                      subtitle: Text(document['status']),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please fill all fields to create a new task"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Síntoma'),
                controller: dialogSintomas,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Especialidad'),
                controller: dialogEspecialidad,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: dialogEmail,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                dialogEmail.clear();
                dialogEspecialidad.clear();
                dialogSintomas.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () {
                if (dialogEmail.text.isNotEmpty &&
                    dialogEspecialidad.text.isNotEmpty &&
                    dialogSintomas.text.isNotEmpty) {
                  Firestore.instance
                      .collection('consultations')
                      .add({
                        "symptom": dialogSintomas.text,
                        "speciality": dialogEspecialidad.text,
                        "status": "pending",
                        "prescription": "",
                        "patient": {
                          "email": "patient@hook.com",
                          "id": idUser,
                        },
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            dialogEmail.clear(),
                            dialogEspecialidad.clear(),
                            dialogSintomas.clear(),
                          })
                      .catchError((err) => print(err));
                }
              })
        ],
      ),
    );
  }
}
