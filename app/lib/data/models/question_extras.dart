import 'package:json_annotation/json_annotation.dart';
import 'package:sage/data/models/question.dart';

part 'question_extras.g.dart';

abstract class QuestionExtras {
  QuestionExtras();

  QuestionType get type;

  factory QuestionExtras.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'single':
        return QuestionExtrasSingle.fromJson(json);

      case 'multi':
        return QuestionExtrasMulti.fromJson(json);

      case 'numeric':
        return QuestionExtrasNumeric.fromJson(json);

      case 'text':
        return QuestionExtrasText.fromJson(json);
    }

    return null;
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class QuestionExtrasSingle extends QuestionExtras {
  final QuestionType type = QuestionType.single;
  final List<String> options;

  QuestionExtrasSingle(QuestionType type, this.options);

  factory QuestionExtrasSingle.fromJson(Map<String, dynamic> json) =>
      _$QuestionExtrasSingleFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionExtrasSingleToJson(this);
}

@JsonSerializable()
class QuestionExtrasMulti extends QuestionExtras {
  final QuestionType type = QuestionType.multi;
  final List<String> options;

  QuestionExtrasMulti(QuestionType type, this.options);

  factory QuestionExtrasMulti.fromJson(Map<String, dynamic> json) =>
      _$QuestionExtrasMultiFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionExtrasMultiToJson(this);
}

@JsonSerializable()
class QuestionExtrasNumeric extends QuestionExtras {
  final QuestionType type = QuestionType.numeric;
  final int min;
  final int max;

  QuestionExtrasNumeric(QuestionType type, this.min, this.max);

  factory QuestionExtrasNumeric.fromJson(Map<String, dynamic> json) =>
      _$QuestionExtrasNumericFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionExtrasNumericToJson(this);
}

@JsonSerializable()
class QuestionExtrasText extends QuestionExtras {
  final QuestionType type = QuestionType.text;
  final int minLength;
  final int maxLength;

  QuestionExtrasText(QuestionType type, this.minLength, this.maxLength);

  factory QuestionExtrasText.fromJson(Map<String, dynamic> json) =>
      _$QuestionExtrasTextFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionExtrasTextToJson(this);
}
