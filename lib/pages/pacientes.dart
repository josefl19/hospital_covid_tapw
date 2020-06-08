import 'package:flutter/material.dart';
import 'package:hospital_covid_tapw/pages/historial_pacientes.dart';

class Paciente extends StatefulWidget {
  Paciente({Key key}) : super(key: key);

  @override
  _PacienteState createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {

  TextEditingController textUser = TextEditingController();
  TextEditingController textIdDoctor = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: textUser,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User doctor',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: textIdDoctor,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID Usuario',
              ),
            ),
          ),

          RaisedButton(
            child: Text(
              'VER HISTORIAL',
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              _sendDataToViewHistorial(context);
            },
          )

        ],
      ),
    );
  }

  _sendDataToViewHistorial(BuildContext context) {
    String user = textUser.text;
    String idDoctor = textIdDoctor.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Historial(idDoctor: idDoctor, user: user),
        ));
    }
}
