import 'package:flutter/material.dart';

class TabsNavigation extends StatelessWidget {
  const TabsNavigation({Key key}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(child: Icon(Icons.content_paste, size: 64.0, color: Colors.yellow)),
      Center(child: Icon(Icons.supervised_user_circle, size: 64.0, color: Colors.teal)),
      Center(child: Icon(Icons.insert_chart, size: 64.0, color: Colors.teal)),
      Center(child: Icon(Icons.shopping_cart, size: 64.0, color: Colors.teal))
    ];
    final _kTabs= <Tab>[
      Tab(icon: Icon(Icons.content_paste), text:'Consultas'),
      Tab(icon: Icon(Icons.supervised_user_circle), text:'Pacientes'),
      Tab(icon: Icon(Icons.insert_chart), text:'Estadisticas'),
      Tab(icon: Icon(Icons.shopping_cart), text:'Tienda')
    ];
    return MaterialApp (
      home: DefaultTabController(
      length: _kTabs.length, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hospital COVID-19"),
          backgroundColor: Colors.cyan,
          bottom: TabBar(
            tabs: _kTabs,
          ),
          ),
          body: TabBarView(children: _kTabPages,),
      ),
      ), 
    );  
  }
}