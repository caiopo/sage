abstract class Serializer<T> {
  T from(dynamic data);

  dynamic to(T obj);
}
