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

abstract class AnswerQuestion
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AnswerQuestion._({
    required this.questionId,
    this.value,
    this.optionId,
  });

  factory AnswerQuestion({
    required _i1.UuidValue questionId,
    String? value,
    _i1.UuidValue? optionId,
  }) = _AnswerQuestionImpl;

  factory AnswerQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnswerQuestion(
      questionId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['questionId']),
      value: jsonSerialization['value'] as String?,
      optionId: jsonSerialization['optionId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['optionId']),
    );
  }

  _i1.UuidValue questionId;

  String? value;

  _i1.UuidValue? optionId;

  AnswerQuestion copyWith({
    _i1.UuidValue? questionId,
    String? value,
    _i1.UuidValue? optionId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId.toJson(),
      if (value != null) 'value': value,
      if (optionId != null) 'optionId': optionId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'questionId': questionId.toJson(),
      if (value != null) 'value': value,
      if (optionId != null) 'optionId': optionId?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerQuestionImpl extends AnswerQuestion {
  _AnswerQuestionImpl({
    required _i1.UuidValue questionId,
    String? value,
    _i1.UuidValue? optionId,
  }) : super._(
          questionId: questionId,
          value: value,
          optionId: optionId,
        );

  @override
  AnswerQuestion copyWith({
    _i1.UuidValue? questionId,
    Object? value = _Undefined,
    Object? optionId = _Undefined,
  }) {
    return AnswerQuestion(
      questionId: questionId ?? this.questionId,
      value: value is String? ? value : this.value,
      optionId: optionId is _i1.UuidValue? ? optionId : this.optionId,
    );
  }
}
