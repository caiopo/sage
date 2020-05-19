import 'package:moor/moor.dart';
import 'package:sage/data/db.dart';

abstract class Dao extends DatabaseAccessor<AppDatabase> {
  Dao(AppDatabase db) : super(db);
}
