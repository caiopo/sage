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

abstract class SurveyCreateError
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  SurveyCreateError._({required this.message});

  factory SurveyCreateError({required String message}) = _SurveyCreateErrorImpl;

  factory SurveyCreateError.fromJson(Map<String, dynamic> jsonSerialization) {
    return SurveyCreateError(message: jsonSerialization['message'] as String);
  }

  String message;

  SurveyCreateError copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'message': message};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SurveyCreateErrorImpl extends SurveyCreateError {
  _SurveyCreateErrorImpl({required String message}) : super._(message: message);

  @override
  SurveyCreateError copyWith({String? message}) {
    return SurveyCreateError(message: message ?? this.message);
  }
}
