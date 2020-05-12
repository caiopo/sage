import 'package:flutter/widgets.dart';

extension ViewModelExtension on State {
  void listenTo(ChangeNotifier changeNotifier) {
    // ignore: invalid_use_of_protected_member
    changeNotifier.addListener(() => this.setState(() {}));
  }
}
