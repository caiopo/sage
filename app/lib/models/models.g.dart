// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(uid: json['uid'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'uid': instance.uid};

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return Survey(
      id: json['id'] as int,
      title: json['title'] as String,
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      questions: (json['questions'] as List)
          ?.map((e) => e == null
              ? null
              : SurveyQuestion.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'owner': instance.owner,
      'questions': instance.questions
    };

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) {
  return SurveyQuestion(
      id: json['id'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      extras: json['extras'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'extras': instance.extras
    };
