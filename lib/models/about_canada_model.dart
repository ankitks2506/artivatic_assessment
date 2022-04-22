// To parse this JSON data, do
//
//     final aboutCanada = aboutCanadaFromJson(jsonString);

import 'dart:convert';

AboutCanadaModel aboutCanadaModelFromJson(String str) =>
    AboutCanadaModel.fromJson(json.decode(str));

String aboutCanadaModelToJson(AboutCanadaModel data) =>
    json.encode(data.toJson());

//Model class to parse the response from API
class AboutCanadaModel {
  AboutCanadaModel({
    this.title,
    this.rows,
  });

  String? title;
  List<Row>? rows;

  factory AboutCanadaModel.fromJson(Map<String, dynamic> json) =>
      AboutCanadaModel(
        title: json["title"] ?? "",
        rows: json["rows"] == null
            ? null
            : List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? "",
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  Row({
    this.title,
    this.description,
    this.imageHref,
  });

  String? title;
  String? description;
  String? imageHref;

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        title: json["title"] ?? "No Title Given",
        description: json["description"] ?? "No Description Given",
        imageHref: json["imageHref"] ?? "No Image Provided",
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? "No Title Given",
        "description": description ?? "No Description Given",
        "imageHref": imageHref ?? "No Image Provided",
      };
}
