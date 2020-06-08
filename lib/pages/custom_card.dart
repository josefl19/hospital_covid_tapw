import 'package:flutter/material.dart';
//import '../secondPage.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.paciente, 
              @required this.covid, 
              @required this.precond, 
              @required this.nacimiento,
              @required this.prescription});

  final paciente;
  final covid;
  final precond;
  final nacimiento;
  final prescription;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                Row(children: <Widget>[
                      Text("Nombre paciente: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(paciente, textAlign: TextAlign.justify)
                ]),
                Row(children: <Widget>[
                      Text("Fecha nacimiento: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(nacimiento, textAlign: TextAlign.justify)
                ]),
                Row(children: <Widget>[
                      Text("Covid: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(covid, textAlign: TextAlign.justify)
                ]),
                Column(children: <Widget>[
                      Text("Precondiciones: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(precond, textAlign: TextAlign.justify)
                ]),
                Column(children: <Widget>[
                      Text("Prescripción: ", style: TextStyle(fontWeight: FontWeight.bold, )),
                      Text(prescription, textAlign: TextAlign.justify)
                ]),
                SizedBox(height: 10.0),
              ],
            ))
    );
  }
}