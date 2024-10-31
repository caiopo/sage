/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'answer.dart' as _i4;
import 'answer_question.dart' as _i5;
import 'question.dart' as _i6;
import 'question_option.dart' as _i7;
import 'question_type.dart' as _i8;
import 'survey.dart' as _i9;
import 'survey_create_error.dart' as _i10;
import 'protocol.dart' as _i11;
import 'package:sage_server/src/generated/survey.dart' as _i12;
export 'answer.dart';
export 'answer_question.dart';
export 'question.dart';
export 'question_option.dart';
export 'question_type.dart';
export 'survey.dart';
export 'survey_create_error.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'answer',
      dartName: 'Answer',
      schema: 'public',
      module: 'sage',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'answer_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'surveyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'answers',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:AnswerQuestion>',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'answer_fk_0',
          columns: ['surveyId'],
          referenceTable: 'survey',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'answer_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'survey',
      dartName: 'Survey',
      schema: 'public',
      module: 'sage',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'survey_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ownerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'questions',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:Question>',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'survey_fk_0',
          columns: ['ownerId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'survey_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.Answer) {
      return _i4.Answer.fromJson(data) as T;
    }
    if (t == _i5.AnswerQuestion) {
      return _i5.AnswerQuestion.fromJson(data) as T;
    }
    if (t == _i6.Question) {
      return _i6.Question.fromJson(data) as T;
    }
    if (t == _i7.QuestionOption) {
      return _i7.QuestionOption.fromJson(data) as T;
    }
    if (t == _i8.QuestionType) {
      return _i8.QuestionType.fromJson(data) as T;
    }
    if (t == _i9.Survey) {
      return _i9.Survey.fromJson(data) as T;
    }
    if (t == _i10.SurveyCreateError) {
      return _i10.SurveyCreateError.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.Answer?>()) {
      return (data != null ? _i4.Answer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AnswerQuestion?>()) {
      return (data != null ? _i5.AnswerQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Question?>()) {
      return (data != null ? _i6.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.QuestionOption?>()) {
      return (data != null ? _i7.QuestionOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.QuestionType?>()) {
      return (data != null ? _i8.QuestionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Survey?>()) {
      return (data != null ? _i9.Survey.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SurveyCreateError?>()) {
      return (data != null ? _i10.SurveyCreateError.fromJson(data) : null) as T;
    }
    if (t == List<_i11.AnswerQuestion>) {
      return (data as List)
          .map((e) => deserialize<_i11.AnswerQuestion>(e))
          .toList() as dynamic;
    }
    if (t == _i1.getType<List<_i11.QuestionOption>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.QuestionOption>(e))
              .toList()
          : null) as dynamic;
    }
    if (t == List<_i11.Question>) {
      return (data as List).map((e) => deserialize<_i11.Question>(e)).toList()
          as dynamic;
    }
    if (t == List<_i12.Survey>) {
      return (data as List).map((e) => deserialize<_i12.Survey>(e)).toList()
          as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.Answer) {
      return 'Answer';
    }
    if (data is _i5.AnswerQuestion) {
      return 'AnswerQuestion';
    }
    if (data is _i6.Question) {
      return 'Question';
    }
    if (data is _i7.QuestionOption) {
      return 'QuestionOption';
    }
    if (data is _i8.QuestionType) {
      return 'QuestionType';
    }
    if (data is _i9.Survey) {
      return 'Survey';
    }
    if (data is _i10.SurveyCreateError) {
      return 'SurveyCreateError';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Answer') {
      return deserialize<_i4.Answer>(data['data']);
    }
    if (data['className'] == 'AnswerQuestion') {
      return deserialize<_i5.AnswerQuestion>(data['data']);
    }
    if (data['className'] == 'Question') {
      return deserialize<_i6.Question>(data['data']);
    }
    if (data['className'] == 'QuestionOption') {
      return deserialize<_i7.QuestionOption>(data['data']);
    }
    if (data['className'] == 'QuestionType') {
      return deserialize<_i8.QuestionType>(data['data']);
    }
    if (data['className'] == 'Survey') {
      return deserialize<_i9.Survey>(data['data']);
    }
    if (data['className'] == 'SurveyCreateError') {
      return deserialize<_i10.SurveyCreateError>(data['data']);
    }
    if (data['className'].startsWith('serverpod.')) {
      data['className'] = data['className'].substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.Answer:
        return _i4.Answer.t;
      case _i9.Survey:
        return _i9.Survey.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'sage';
}
