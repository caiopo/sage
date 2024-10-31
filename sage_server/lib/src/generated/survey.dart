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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i2;
import 'protocol.dart' as _i3;

abstract class Survey implements _i1.TableRow, _i1.ProtocolSerialization {
  Survey._({
    this.id,
    required this.title,
    required this.description,
    required this.ownerId,
    this.owner,
    required this.questions,
  });

  factory Survey({
    int? id,
    required String title,
    required String description,
    required int ownerId,
    _i2.UserInfo? owner,
    required List<_i3.Question> questions,
  }) = _SurveyImpl;

  factory Survey.fromJson(Map<String, dynamic> jsonSerialization) {
    return Survey(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      ownerId: jsonSerialization['ownerId'] as int,
      owner: jsonSerialization['owner'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['owner'] as Map<String, dynamic>)),
      questions: (jsonSerialization['questions'] as List)
          .map((e) => _i3.Question.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SurveyTable();

  static const db = SurveyRepository._();

  @override
  int? id;

  String title;

  String description;

  int ownerId;

  _i2.UserInfo? owner;

  List<_i3.Question> questions;

  @override
  _i1.Table get table => t;

  Survey copyWith({
    int? id,
    String? title,
    String? description,
    int? ownerId,
    _i2.UserInfo? owner,
    List<_i3.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      if (owner != null) 'owner': owner?.toJson(),
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      if (owner != null) 'owner': owner?.toJsonForProtocol(),
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SurveyInclude include({_i2.UserInfoInclude? owner}) {
    return SurveyInclude._(owner: owner);
  }

  static SurveyIncludeList includeList({
    _i1.WhereExpressionBuilder<SurveyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SurveyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SurveyTable>? orderByList,
    SurveyInclude? include,
  }) {
    return SurveyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Survey.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Survey.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SurveyImpl extends Survey {
  _SurveyImpl({
    int? id,
    required String title,
    required String description,
    required int ownerId,
    _i2.UserInfo? owner,
    required List<_i3.Question> questions,
  }) : super._(
          id: id,
          title: title,
          description: description,
          ownerId: ownerId,
          owner: owner,
          questions: questions,
        );

  @override
  Survey copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    int? ownerId,
    Object? owner = _Undefined,
    List<_i3.Question>? questions,
  }) {
    return Survey(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      owner: owner is _i2.UserInfo? ? owner : this.owner?.copyWith(),
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SurveyTable extends _i1.Table {
  SurveyTable({super.tableRelation}) : super(tableName: 'survey') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    ownerId = _i1.ColumnInt(
      'ownerId',
      this,
    );
    questions = _i1.ColumnSerializable(
      'questions',
      this,
    );
  }

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt ownerId;

  _i2.UserInfoTable? _owner;

  late final _i1.ColumnSerializable questions;

  _i2.UserInfoTable get owner {
    if (_owner != null) return _owner!;
    _owner = _i1.createRelationTable(
      relationFieldName: 'owner',
      field: Survey.t.ownerId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _owner!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        description,
        ownerId,
        questions,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'owner') {
      return owner;
    }
    return null;
  }
}

class SurveyInclude extends _i1.IncludeObject {
  SurveyInclude._({_i2.UserInfoInclude? owner}) {
    _owner = owner;
  }

  _i2.UserInfoInclude? _owner;

  @override
  Map<String, _i1.Include?> get includes => {'owner': _owner};

  @override
  _i1.Table get table => Survey.t;
}

class SurveyIncludeList extends _i1.IncludeList {
  SurveyIncludeList._({
    _i1.WhereExpressionBuilder<SurveyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Survey.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Survey.t;
}

class SurveyRepository {
  const SurveyRepository._();

  final attachRow = const SurveyAttachRowRepository._();

  Future<List<Survey>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SurveyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SurveyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SurveyTable>? orderByList,
    _i1.Transaction? transaction,
    SurveyInclude? include,
  }) async {
    return session.db.find<Survey>(
      where: where?.call(Survey.t),
      orderBy: orderBy?.call(Survey.t),
      orderByList: orderByList?.call(Survey.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<Survey?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SurveyTable>? where,
    int? offset,
    _i1.OrderByBuilder<SurveyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SurveyTable>? orderByList,
    _i1.Transaction? transaction,
    SurveyInclude? include,
  }) async {
    return session.db.findFirstRow<Survey>(
      where: where?.call(Survey.t),
      orderBy: orderBy?.call(Survey.t),
      orderByList: orderByList?.call(Survey.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<Survey?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SurveyInclude? include,
  }) async {
    return session.db.findById<Survey>(
      id,
      transaction: transaction ?? session.transaction,
      include: include,
    );
  }

  Future<List<Survey>> insert(
    _i1.Session session,
    List<Survey> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Survey>(
      rows,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Survey> insertRow(
    _i1.Session session,
    Survey row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Survey>(
      row,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Survey>> update(
    _i1.Session session,
    List<Survey> rows, {
    _i1.ColumnSelections<SurveyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Survey>(
      rows,
      columns: columns?.call(Survey.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Survey> updateRow(
    _i1.Session session,
    Survey row, {
    _i1.ColumnSelections<SurveyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Survey>(
      row,
      columns: columns?.call(Survey.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Survey>> delete(
    _i1.Session session,
    List<Survey> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Survey>(
      rows,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<Survey> deleteRow(
    _i1.Session session,
    Survey row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Survey>(
      row,
      transaction: transaction ?? session.transaction,
    );
  }

  Future<List<Survey>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SurveyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Survey>(
      where: where(Survey.t),
      transaction: transaction ?? session.transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SurveyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Survey>(
      where: where?.call(Survey.t),
      limit: limit,
      transaction: transaction ?? session.transaction,
    );
  }
}

class SurveyAttachRowRepository {
  const SurveyAttachRowRepository._();

  Future<void> owner(
    _i1.Session session,
    Survey survey,
    _i2.UserInfo owner, {
    _i1.Transaction? transaction,
  }) async {
    if (survey.id == null) {
      throw ArgumentError.notNull('survey.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $survey = survey.copyWith(ownerId: owner.id);
    await session.db.updateRow<Survey>(
      $survey,
      columns: [Survey.t.ownerId],
      transaction: transaction ?? session.transaction,
    );
  }
}
