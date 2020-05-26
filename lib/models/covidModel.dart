class CovidModel {
  final String country;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  final String date;

  CovidModel({
    this.country,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date
  });

  factory CovidModel.fromJson(Map<String, dynamic> json) {
    return CovidModel(
      country: json['Country'] as String,
      confirmed: json['Confirmed'] as int,
      deaths: json['Deaths'] as int,
      recovered: json['Recovered'] as int,
      active: json['Active'] as int,
      date: json['Date'] as String,
    );
  }
}