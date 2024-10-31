/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:uuid/uuid.dart' as _i2;
import 'protocol.dart' as _i3;

abstract class Question
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Question._({
    _i1.UuidValue? id,
    required this.title,
    String? description,
    required this.type,
    required this.required,
    this.options,
    this.minValue,
    this.maxValue,
    this.minLength,
    this.maxLength,
  })  : id = id ?? _i2.Uuid().v4obj(),
        description = description ?? '';

  factory Question({
    _i1.UuidValue? id,
    required String title,
    String? description,
    required _i3.QuestionType type,
    required bool required,
    List<_i3.QuestionOption>? options,
    int? minValue,
    int? maxValue,
    int? minLength,
    int? maxLength,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      type: _i3.QuestionType.fromJson((jsonSerialization['type'] as String)),
      required: jsonSerialization['required'] as bool,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i3.QuestionOption.fromJson((e as Map<String, dynamic>)))
          .toList(),
      minValue: jsonSerialization['minValue'] as int?,
      maxValue: jsonSerialization['maxValue'] as int?,
      minLength: jsonSerialization['minLength'] as int?,
      maxLength: jsonSerialization['maxLength'] as int?,
    );
  }

  _i1.UuidValue id;

  String title;

  String description;

  _i3.QuestionType type;

  bool required;

  List<_i3.QuestionOption>? options;

  int? minValue;

  int? maxValue;

  int? minLength;

  int? maxLength;

  Question copyWith({
    _i1.UuidValue? id,
    String? title,
    String? description,
    _i3.QuestionType? type,
    bool? required,
    List<_i3.QuestionOption>? options,
    int? minValue,
    int? maxValue,
    int? minLength,
    int? maxLength,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'title': title,
      'description': description,
      'type': type.toJson(),
      'required': required,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
      if (minValue != null) 'minValue': minValue,
      if (maxValue != null) 'maxValue': maxValue,
      if (minLength != null) 'minLength': minLength,
      if (maxLength != null) 'maxLength': maxLength,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'id': id.toJson(),
      'title': title,
      'description': description,
      'type': type.toJson(),
      'required': required,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (minValue != null) 'minValue': minValue,
      if (maxValue != null) 'maxValue': maxValue,
      if (minLength != null) 'minLength': minLength,
      if (maxLength != null) 'maxLength': maxLength,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    _i1.UuidValue? id,
    required String title,
    String? description,
    required _i3.QuestionType type,
    required bool required,
    List<_i3.QuestionOption>? options,
    int? minValue,
    int? maxValue,
    int? minLength,
    int? maxLength,
  }) : super._(
          id: id,
          title: title,
          description: description,
          type: type,
          required: required,
          options: options,
          minValue: minValue,
          maxValue: maxValue,
          minLength: minLength,
          maxLength: maxLength,
        );

  @override
  Question copyWith({
    _i1.UuidValue? id,
    String? title,
    String? description,
    _i3.QuestionType? type,
    bool? required,
    Object? options = _Undefined,
    Object? minValue = _Undefined,
    Object? maxValue = _Undefined,
    Object? minLength = _Undefined,
    Object? maxLength = _Undefined,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      required: required ?? this.required,
      options: options is List<_i3.QuestionOption>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
      minValue: minValue is int? ? minValue : this.minValue,
      maxValue: maxValue is int? ? maxValue : this.maxValue,
      minLength: minLength is int? ? minLength : this.minLength,
      maxLength: maxLength is int? ? maxLength : this.maxLength,
    );
  }
}
