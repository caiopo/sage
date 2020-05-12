// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_extras.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerExtrasSingle _$AnswerExtrasSingleFromJson(Map<String, dynamic> json) {
  return AnswerExtrasSingle(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    json['answer'] as String,
  );
}

Map<String, dynamic> _$AnswerExtrasSingleToJson(AnswerExtrasSingle instance) =>
    <String, dynamic>{
      'type': instance.type,
      'answer': instance.answer,
    };

AnswerExtrasMulti _$AnswerExtrasMultiFromJson(Map<String, dynamic> json) {
  return AnswerExtrasMulti(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    (json['answer'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AnswerExtrasMultiToJson(AnswerExtrasMulti instance) =>
    <String, dynamic>{
      'type': instance.type,
      'answer': instance.answer,
    };

AnswerExtrasNumeric _$AnswerExtrasNumericFromJson(Map<String, dynamic> json) {
  return AnswerExtrasNumeric(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    json['answer'] as int,
  );
}

Map<String, dynamic> _$AnswerExtrasNumericToJson(
        AnswerExtrasNumeric instance) =>
    <String, dynamic>{
      'type': instance.type,
      'answer': instance.answer,
    };

AnswerExtrasText _$AnswerExtrasTextFromJson(Map<String, dynamic> json) {
  return AnswerExtrasText(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    json['answer'] as String,
  );
}

Map<String, dynamic> _$AnswerExtrasTextToJson(AnswerExtrasText instance) =>
    <String, dynamic>{
      'type': instance.type,
      'answer': instance.answer,
    };
