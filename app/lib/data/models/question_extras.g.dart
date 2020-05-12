// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_extras.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionExtrasSingle _$QuestionExtrasSingleFromJson(Map<String, dynamic> json) {
  return QuestionExtrasSingle(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    (json['options'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$QuestionExtrasSingleToJson(
        QuestionExtrasSingle instance) =>
    <String, dynamic>{
      'type': instance.type,
      'options': instance.options,
    };

QuestionExtrasMulti _$QuestionExtrasMultiFromJson(Map<String, dynamic> json) {
  return QuestionExtrasMulti(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    (json['options'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$QuestionExtrasMultiToJson(
        QuestionExtrasMulti instance) =>
    <String, dynamic>{
      'type': instance.type,
      'options': instance.options,
    };

QuestionExtrasNumeric _$QuestionExtrasNumericFromJson(
    Map<String, dynamic> json) {
  return QuestionExtrasNumeric(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    json['min'] as int,
    json['max'] as int,
  );
}

Map<String, dynamic> _$QuestionExtrasNumericToJson(
        QuestionExtrasNumeric instance) =>
    <String, dynamic>{
      'type': instance.type,
      'min': instance.min,
      'max': instance.max,
    };

QuestionExtrasText _$QuestionExtrasTextFromJson(Map<String, dynamic> json) {
  return QuestionExtrasText(
    json['type'] == null ? null : QuestionType.fromJson(json['type']),
    json['minLength'] as int,
    json['maxLength'] as int,
  );
}

Map<String, dynamic> _$QuestionExtrasTextToJson(QuestionExtrasText instance) =>
    <String, dynamic>{
      'type': instance.type,
      'minLength': instance.minLength,
      'maxLength': instance.maxLength,
    };
