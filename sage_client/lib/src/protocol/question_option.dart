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

abstract class QuestionOption implements _i1.SerializableModel {
  QuestionOption._({
    required this.optionId,
    required this.value,
  });

  factory QuestionOption({
    required _i1.UuidValue optionId,
    required String value,
  }) = _QuestionOptionImpl;

  factory QuestionOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionOption(
      optionId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['optionId']),
      value: jsonSerialization['value'] as String,
    );
  }

  _i1.UuidValue optionId;

  String value;

  QuestionOption copyWith({
    _i1.UuidValue? optionId,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'optionId': optionId.toJson(),
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuestionOptionImpl extends QuestionOption {
  _QuestionOptionImpl({
    required _i1.UuidValue optionId,
    required String value,
  }) : super._(
          optionId: optionId,
          value: value,
        );

  @override
  QuestionOption copyWith({
    _i1.UuidValue? optionId,
    String? value,
  }) {
    return QuestionOption(
      optionId: optionId ?? this.optionId,
      value: value ?? this.value,
    );
  }
}
