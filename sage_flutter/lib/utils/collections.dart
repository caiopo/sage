import 'package:sage_client/sage_client.dart';

UuidValue randomUuid() {
  return const Uuid().v4obj();
}

extension ListSageEx<T> on List<T> {
  List<T> reordered(int previousIndex, int newIndex) {
    final list = [...this];
    if (previousIndex < newIndex) {
      newIndex -= 1;
    }
    final v = list.removeAt(previousIndex);
    list.insert(newIndex, v);
    return list;
  }
}
