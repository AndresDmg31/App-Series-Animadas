import 'dart:convert';

People peopleFromJson(String str) => People.fromJson(json.decode(str));

String peopleToJson(People data) => json.encode(data.toJson());

class People {
  List<Result> results;

  People({
    required this.results,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;

  Result({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    gender: json["gender"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "gender": gender,
    "image": image,
  };
}