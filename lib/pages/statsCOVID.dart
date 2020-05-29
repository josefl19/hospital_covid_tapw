import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hospital_covid_tapw/models/covidModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<List<CovidModel>> fetchStats(http.Client client) async {
  final response = await client.get('https://api.covid19api.com/total/country/mexico');

  return compute(parseStats, response.body);
}

List<CovidModel> parseStats(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CovidModel>((json) => CovidModel.fromJson(json)).toList();
}

class StatsCovid extends StatelessWidget {
  final String title;
  StatsCovid({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CovidModel>>(
        future: fetchStats(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CovidList(stats: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CovidList extends StatelessWidget {
  final List<CovidModel> stats;
  CovidList({Key key, this.stats}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var fecha = stats[stats.length-1].date.substring(0, 10);
    /*return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return Text(stats[stats.length-1].confirmed.toString());
      },
    );*/
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Center(child: Text("ESTADÍSTICA EN MÉXICO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
            subtitle: Center(child: Text("ULTIMA ACTUALIZACIÓN: " + fecha, style: TextStyle(fontSize: 11),)),
          ),
          ListTile(
            leading: Icon(Icons.report, color: Colors.red),
            trailing: Text(stats[stats.length-1].confirmed.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
            title: Text("CASOS CONFIRMADOS"),
          ),
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            trailing: Text(stats[stats.length-1].active.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
            title: Text("CASOS ACTIVOS"),
          ),
          ListTile(
            leading: Icon(Icons.sentiment_very_dissatisfied, color: Colors.grey),
            //title: Text(stats[stats.length-1].deaths.toString()),
            title: Text("PERSONAS FALLECIDAS"),
            trailing: Text(stats[stats.length-1].deaths.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: Icon(Icons.check_box, color: Colors.green,),
            trailing: Text(stats[stats.length-1].recovered.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
            title: Text("CASOS RECUPERADOS"),
          ),
        ],
      ),
      
    );
    
      
  }
}



/*class StatsCovidPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<CovidModel>> snapshot) {
          if (snapshot.hasData) {
            List<CovidModel> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (CovidModel post) => ListTile(
                      title: Text(post.country),
                      subtitle: Text("${post.confirmed}"),
                      /*onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post: post,
                          ),
                        ),
                      ),*/
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/


