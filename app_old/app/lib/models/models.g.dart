// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
    };

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return Survey(
    uuid: json['uuid'] as String,
    title: json['title'] as String,
    owner: json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    questions: (json['questions'] as List)
        ?.map((e) => e == null
            ? null
            : SurveyQuestion.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    answers: json['answers'] as int,
  );
}

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'owner': instance.owner,
      'questions': instance.questions,
      'answers': instance.answers,
    };

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) {
  return SurveyQuestion(
    uuid: json['uuid'] as String,
    type: _$enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
    title: json['title'] as String,
    description: json['description'] as String,
    required: json['required'] as bool,
    extras: json['extras'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'type': _$QuestionTypeEnumMap[instance.type],
      'title': instance.title,
      'description': instance.description,
      'required': instance.required,
      'extras': instance.extras,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$QuestionTypeEnumMap = {
  QuestionType.single: 'single',
  QuestionType.multiple: 'multiple',
  QuestionType.number: 'number',
  QuestionType.text: 'text',
};
