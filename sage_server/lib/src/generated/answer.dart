/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: invalid_use_of_visible_for_testing_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class Answer implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = AnswerTable();

  static const db = AnswerRepository._();

  @override
  int? id;

  int surveyId;

  _i2.Survey? survey;

  List<_i2.AnswerQuestion> answers;

  DateTime createdAt;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'surveyId': surveyId,
      if (survey != null) 'survey': survey?.toJsonForProtocol(),
      'answers': answers.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  static AnswerInclude include({_i2.SurveyInclude? survey}) {
    return AnswerInclude._(survey: survey);
  }

  static AnswerIncludeList includeList({
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    AnswerInclude? include,
  }) {
    return AnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Answer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Answer.t),
      include: include,
    );
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

class AnswerTable extends _i1.Table {
  AnswerTable({super.tableRelation}) : super(tableName: 'answer') {
    surveyId = _i1.ColumnInt(
      'surveyId',
      this,
    );
    answers = _i1.ColumnSerializable(
      'answers',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt surveyId;

  _i2.SurveyTable? _survey;

  late final _i1.ColumnSerializable answers;

  late final _i1.ColumnDateTime createdAt;

  _i2.SurveyTable get survey {
    if (_survey != null) return _survey!;
    _survey = _i1.createRelationTable(
      relationFieldName: 'survey',
      field: Answer.t.surveyId,
      foreignField: _i2.Survey.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SurveyTable(tableRelation: foreignTableRelation),
    );
    return _survey!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        surveyId,
        answers,
        createdAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'survey') {
      return survey;
    }
    return null;
  }
}

class AnswerInclude extends _i1.IncludeObject {
  AnswerInclude._({_i2.SurveyInclude? survey}) {
    _survey = survey;
  }

  _i2.SurveyInclude? _survey;

  @override
  Map<String, _i1.Include?> get includes => {'survey': _survey};

  @override
  _i1.Table get table => Answer.t;
}

class AnswerIncludeList extends _i1.IncludeList {
  AnswerIncludeList._({
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Answer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Answer.t;
}

class AnswerRepository {
  const AnswerRepository._();

  final attachRow = const AnswerAttachRowRepository._();

  Future<List<Answer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    _i1.Transaction? transaction,
    AnswerInclude? include,
  }) async {
    return session.db.find<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<Answer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnswerTable>? orderByList,
    _i1.Transaction? transaction,
    AnswerInclude? include,
  }) async {
    return session.db.findFirstRow<Answer>(
      where: where?.call(Answer.t),
      orderBy: orderBy?.call(Answer.t),
      orderByList: orderByList?.call(Answer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<Answer?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AnswerInclude? include,
  }) async {
    return session.db.findById<Answer>(
      id,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<List<Answer>> insert(
    _i1.Session session,
    List<Answer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Answer>(
      rows,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Answer> insertRow(
    _i1.Session session,
    Answer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Answer>(
      row,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Answer>> update(
    _i1.Session session,
    List<Answer> rows, {
    _i1.ColumnSelections<AnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Answer>(
      rows,
      columns: columns?.call(Answer.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Answer> updateRow(
    _i1.Session session,
    Answer row, {
    _i1.ColumnSelections<AnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Answer>(
      row,
      columns: columns?.call(Answer.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Answer>> delete(
    _i1.Session session,
    List<Answer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Answer>(
      rows,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Answer> deleteRow(
    _i1.Session session,
    Answer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Answer>(
      row,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Answer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnswerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Answer>(
      where: where(Answer.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnswerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Answer>(
      where: where?.call(Answer.t),
      limit: limit,
      transaction: transaction ?? session.transaction,
    );
  }
}

class AnswerAttachRowRepository {
  const AnswerAttachRowRepository._();

  Future<void> survey(
    _i1.Session session,
    Answer answer,
    _i2.Survey survey, {
    _i1.Transaction? transaction,
  }) async {
    if (answer.id == null) {
      throw ArgumentError.notNull('answer.id');
    }
    if (survey.id == null) {
      throw ArgumentError.notNull('survey.id');
    }

    var $answer = answer.copyWith(surveyId: survey.id);
    await session.db.updateRow<Answer>(
      $answer,
      columns: [Answer.t.surveyId],
      transaction: transaction ?? session.transaction,
    );
  }
}
