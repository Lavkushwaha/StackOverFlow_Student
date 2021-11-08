// To parse this JSON data, do
//
//     final earthquake = earthquakeFromJson(jsonString);

import 'dart:convert';

List<Earthquake> earthquakeFromJson(String str) =>
    List<Earthquake>.from(json.decode(str).map((x) => Earthquake.fromJson(x)));

String earthquakeToJson(List<Earthquake> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Earthquake {
  Earthquake({
    this.date,
    this.depth,
    this.evaluationMode,
    this.lat,
    this.lon,
    this.mag,
    this.place,
    this.time,
    this.type,
  });

  final DateTime? date;
  final String? depth;
  final String? evaluationMode;
  final String? lat;
  final String? lon;
  final String? mag;
  final String? place;
  final String? time;
  final String? type;

  factory Earthquake.fromJson(Map<String, dynamic> json) => Earthquake(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        depth: json["depth"] == null ? null : json["depth"],
        evaluationMode:
            json["evaluationMode"] == null ? null : json["evaluationMode"],
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        mag: json["mag"] == null ? null : json["mag"],
        place: json["place"] == null ? null : json["place"],
        time: json["time"] == null ? null : json["time"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "depth": depth == null ? null : depth,
        "evaluationMode": evaluationMode == null ? null : evaluationMode,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "mag": mag == null ? null : mag,
        "place": place == null ? null : place,
        "time": time == null ? null : time,
        "type": type == null ? null : type,
      };
}
