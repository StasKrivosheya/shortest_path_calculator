import 'dart:convert';

class VerificationResultModel {
  final List<Data> data;

  VerificationResultModel({
    required this.data,
  });

  factory VerificationResultModel.fromRawJson(String str) => VerificationResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerificationResultModel.fromJson(Map<String, dynamic> json) => VerificationResultModel(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  final String id;
  final bool correct;

  Data({
    required this.id,
    required this.correct,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    correct: json["correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "correct": correct,
  };
}
