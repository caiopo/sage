import 'package:json_annotation/json_annotation.dart';
import 'package:sage/data/models/question.dart';

part 'answer_extras.g.dart';

abstract class AnswerExtras {
  AnswerExtras();

  factory AnswerExtras.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'single':
        return AnswerExtrasSingle.fromJson(json);

      case 'multi':
        return AnswerExtrasMulti.fromJson(json);

      case 'numeric':
        return AnswerExtrasNumeric.fromJson(json);

      case 'text':
        return AnswerExtrasText.fromJson(json);
    }

    return null;
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class AnswerExtrasSingle extends AnswerExtras {
  final QuestionType type = QuestionType.single;
  final String answer;

  AnswerExtrasSingle(QuestionType type, this.answer);

  factory AnswerExtrasSingle.fromJson(Map<String, dynamic> json) =>
      _$AnswerExtrasSingleFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerExtrasSingleToJson(this);
}

@JsonSerializable()
class AnswerExtrasMulti extends AnswerExtras {
  final QuestionType type = QuestionType.multi;
  final List<String> answer;

  AnswerExtrasMulti(QuestionType type, this.answer);

  factory AnswerExtrasMulti.fromJson(Map<String, dynamic> json) =>
      _$AnswerExtrasMultiFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerExtrasMultiToJson(this);
}

@JsonSerializable()
class AnswerExtrasNumeric extends AnswerExtras {
  final QuestionType type = QuestionType.numeric;
  final int answer;

  AnswerExtrasNumeric(QuestionType type, this.answer);

  factory AnswerExtrasNumeric.fromJson(Map<String, dynamic> json) =>
      _$AnswerExtrasNumericFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerExtrasNumericToJson(this);
}

@JsonSerializable()
class AnswerExtrasText extends AnswerExtras {
  final QuestionType type = QuestionType.text;
  final String answer;

  AnswerExtrasText(QuestionType type, this.answer);

  factory AnswerExtrasText.fromJson(Map<String, dynamic> json) =>
      _$AnswerExtrasTextFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerExtrasTextToJson(this);
}
