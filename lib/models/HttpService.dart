import 'dart:convert';

import 'package:hospital_covid_tapw/models/covidModel.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsURL = "https://api.covid19api.com/total/country/mexico";

  Future<List<CovidModel>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<CovidModel> posts = body
          .map(
            (dynamic item) => CovidModel.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
