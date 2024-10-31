/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class Answer implements _i1.SerializableModel {
  Answer._({
    this.id,
    required this.surveyId,
    this.survey,
    required this.answers,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Answer({
    int? id,
    required int surveyId,
    _i2.Survey? survey,
    required List<_i2.AnswerQuestion> answers,
    DateTime? createdAt,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      surveyId: jsonSerialization['surveyId'] as int,
      survey: jsonSerialization['survey'] == null
          ? null
          : _i2.Survey.fromJson(
              (jsonSerialization['survey'] as Map<String, dynamic>)),
      answers: (jsonSerialization['answers'] as List)
          .map((e) => _i2.AnswerQuestion.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int surveyId;

  _i2.Survey? survey;

  List<_i2.AnswerQuestion> answers;

  DateTime createdAt;

  Answer copyWith({
    int? id,
    int? surveyId,
    _i2.Survey? survey,
    List<_i2.AnswerQuestion>? answers,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'surveyId': surveyId,
      if (survey != null) 'survey': survey?.toJson(),
      'answers': answers.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerImpl extends Answer {
  _AnswerImpl({
    int? id,
    required int surveyId,
    _i2.Survey? survey,
    required List<_i2.AnswerQuestion> answers,
    DateTime? createdAt,
  }) : super._(
          id: id,
          surveyId: surveyId,
          survey: survey,
          answers: answers,
          createdAt: createdAt,
        );

  @override
  Answer copyWith({
    Object? id = _Undefined,
    int? surveyId,
    Object? survey = _Undefined,
    List<_i2.AnswerQuestion>? answers,
    DateTime? createdAt,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
      surveyId: surveyId ?? this.surveyId,
      survey: survey is _i2.Survey? ? survey : this.survey?.copyWith(),
      answers: answers ?? this.answers.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
