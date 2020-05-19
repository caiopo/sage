import 'package:moor/moor.dart';
import 'package:sage/data/utils/converters/enum_converter.dart';
import 'package:sage/data/utils/converters/question_extras_converter.dart';
import 'package:sage/data/utils/enum.dart';

export 'package:sage/data/models/question_extras.dart';
export 'package:sage/data/utils/converters/enum_converter.dart';
export 'package:sage/data/utils/converters/question_extras_converter.dart';

class Questions extends Table {
  TextColumn get uuid => text()();

  TextColumn get type => text().map(const EnumConverter(QuestionType.values))();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get extras => text().map(const QuestionExtrasConverter())();

  BoolColumn get optional => boolean()();

  @override
  Set<Column> get primaryKey => {uuid};
}

class QuestionType extends Enum {
  static const single = QuestionType._('single', 'Escolha única');
  static const multi = QuestionType._('multi', 'Escolha múltipla');
  static const numeric = QuestionType._('numeric', 'Numérica');
  static const text = QuestionType._('text', 'Textual');

  static const values = [single, multi, numeric, text];

  const QuestionType._(String id, String label) : super(id, label);

  factory QuestionType.fromJson(dynamic json) => Enum.fromJson(values, json);
}
