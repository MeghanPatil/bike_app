// To parse this JSON data, do
//
//     final bikeData = bikeDataFromJson(jsonString);

import 'dart:convert';

List<BikeData> bikeDataFromJson(String str) => List<BikeData>.from(json.decode(str).map((x) => BikeData.fromJson(x)));

String bikeDataToJson(List<BikeData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BikeData {
  BikeData({
    this.id,
    this.bikeName,
    this.bikeImageUrl,
  });

  int id;
  String bikeName;
  String bikeImageUrl;

  factory BikeData.fromJson(Map<String, dynamic> json) => BikeData(
    id: json["id"],
    bikeName: json["bike_name"],
    bikeImageUrl: json["bike_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bike_name": bikeName,
    "bike_image_url": bikeImageUrl,
  };
}
