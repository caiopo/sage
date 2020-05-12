class Enum {
  final String id;
  final String label;

  const Enum(this.id, this.label);

  String toJson() => id;

 static T fromJson<T extends Enum>(List<T> values, dynamic json) {
    return values.firstWhere((e) => e.id == json, orElse: () => null);
  }
}
