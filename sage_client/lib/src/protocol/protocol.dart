/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'answer.dart' as _i2;
import 'answer_question.dart' as _i3;
import 'question.dart' as _i4;
import 'question_option.dart' as _i5;
import 'question_type.dart' as _i6;
import 'survey.dart' as _i7;
import 'survey_create_error.dart' as _i8;
import 'protocol.dart' as _i9;
import 'package:sage_client/src/protocol/survey.dart' as _i10;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i11;
export 'answer.dart';
export 'answer_question.dart';
export 'question.dart';
export 'question_option.dart';
export 'question_type.dart';
export 'survey.dart';
export 'survey_create_error.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Answer) {
      return _i2.Answer.fromJson(data) as T;
    }
    if (t == _i3.AnswerQuestion) {
      return _i3.AnswerQuestion.fromJson(data) as T;
    }
    if (t == _i4.Question) {
      return _i4.Question.fromJson(data) as T;
    }
    if (t == _i5.QuestionOption) {
      return _i5.QuestionOption.fromJson(data) as T;
    }
    if (t == _i6.QuestionType) {
      return _i6.QuestionType.fromJson(data) as T;
    }
    if (t == _i7.Survey) {
      return _i7.Survey.fromJson(data) as T;
    }
    if (t == _i8.SurveyCreateError) {
      return _i8.SurveyCreateError.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Answer?>()) {
      return (data != null ? _i2.Answer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AnswerQuestion?>()) {
      return (data != null ? _i3.AnswerQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Question?>()) {
      return (data != null ? _i4.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.QuestionOption?>()) {
      return (data != null ? _i5.QuestionOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.QuestionType?>()) {
      return (data != null ? _i6.QuestionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Survey?>()) {
      return (data != null ? _i7.Survey.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.SurveyCreateError?>()) {
      return (data != null ? _i8.SurveyCreateError.fromJson(data) : null) as T;
    }
    if (t == List<_i9.AnswerQuestion>) {
      return (data as List)
          .map((e) => deserialize<_i9.AnswerQuestion>(e))
          .toList() as dynamic;
    }
    if (t == _i1.getType<List<_i9.QuestionOption>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.QuestionOption>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i9.Question>) {
      return (data as List).map((e) => deserialize<_i9.Question>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.Survey>) {
      return (data as List).map((e) => deserialize<_i10.Survey>(e)).toList()
          as dynamic;
    }
    try {
      return _i11.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Answer) {
      return 'Answer';
    }
    if (data is _i3.AnswerQuestion) {
      return 'AnswerQuestion';
    }
    if (data is _i4.Question) {
      return 'Question';
    }
    if (data is _i5.QuestionOption) {
      return 'QuestionOption';
    }
    if (data is _i6.QuestionType) {
      return 'QuestionType';
    }
    if (data is _i7.Survey) {
      return 'Survey';
    }
    if (data is _i8.SurveyCreateError) {
      return 'SurveyCreateError';
    }
    className = _i11.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Answer') {
      return deserialize<_i2.Answer>(data['data']);
    }
    if (data['className'] == 'AnswerQuestion') {
      return deserialize<_i3.AnswerQuestion>(data['data']);
    }
    if (data['className'] == 'Question') {
      return deserialize<_i4.Question>(data['data']);
    }
    if (data['className'] == 'QuestionOption') {
      return deserialize<_i5.QuestionOption>(data['data']);
    }
    if (data['className'] == 'QuestionType') {
      return deserialize<_i6.QuestionType>(data['data']);
    }
    if (data['className'] == 'Survey') {
      return deserialize<_i7.Survey>(data['data']);
    }
    if (data['className'] == 'SurveyCreateError') {
      return deserialize<_i8.SurveyCreateError>(data['data']);
    }
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i11.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
