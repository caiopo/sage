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
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;
import 'protocol.dart' as _i3;

abstract class Survey implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  int ownerId;

  _i2.UserInfo? owner;

  List<_i3.Question> questions;

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
