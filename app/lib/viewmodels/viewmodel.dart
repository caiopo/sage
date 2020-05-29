import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/result.dart';

abstract class ViewModel extends ChangeNotifier {}

abstract class LoadingViewModel extends ViewModel {
  ViewModel() {
    reload();
  }

  Future<void> reload() async {
    try {
      await load();
    } finally {
      notifyListeners();
    }
  }

  @protected
  Future<void> load() async {}
}

abstract class StreamViewModel<T> extends ViewModel {
  Stream<Result<T>> _stream;
  StreamSubscription<Result<T>> _streamSubscription;

  Result<T> _value = Result.loading();

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void setStream(Stream<Result<T>> stream) {
    _streamSubscription?.cancel();

    _stream = stream;

    _streamSubscription = _stream.listen(
      (value) {
        _value = value;
        notifyListeners();
      },
      onError: (error) {
        _value = Result.error(DerivedException(error));
        notifyListeners();
      },
    );
  }

  Result<T> get currentValue => _value;
}
