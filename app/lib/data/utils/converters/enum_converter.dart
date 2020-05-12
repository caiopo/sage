import 'package:moor/moor.dart';
import 'package:sage/data/utils/enum.dart';

class EnumConverter<T extends Enum> extends TypeConverter<T, String> {
  final List<T> values;

  const EnumConverter(this.values);

  @override
  T mapToDart(String fromDb) {
    return values.firstWhere((e) => e.id == fromDb, orElse: () => null);
  }

  @override
  String mapToSql(T value) {
    return value.id;
  }
}
