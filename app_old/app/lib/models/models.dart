import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum QuestionType {
  single,
  multiple,
  number,
  text,
}

@JsonSerializable()
class User {
  final String uid;

  const User({this.uid});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Survey {
  String uuid;
  String title;
  User owner;
  List<SurveyQuestion> questions;
  int answers;

  Survey({
    this.uuid,
    this.title,
    this.owner,
    this.questions,
    this.answers,
  });

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);
}

@JsonSerializable()
class SurveyQuestion {
  String uuid;
  QuestionType type;
  String title;
  String description;
  bool required;

  final Map<String, dynamic> extras;

  SurveyQuestion({
    this.uuid,
    this.type,
    this.title,
    this.description,
    this.required,
    this.extras,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionToJson(this);
}
