import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum QuestionType { multiple, single, number, text, scale }

@JsonSerializable()
class User {
  final String uid;

  const User({this.uid});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Survey {
  final int id;
  final String title;
  final User owner;
  final List<SurveyQuestion> questions;
  final int answers;

  const Survey({
    this.id,
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
  final int id;
  final QuestionType type;
  final String title;
  final String description;

  final Map<String, dynamic> extras;

  const SurveyQuestion({
    this.id,
    this.type,
    this.title,
    this.description,
    this.extras,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionToJson(this);
}
