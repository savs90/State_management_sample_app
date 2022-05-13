import 'dart:async';

class BaseState<T> {
  late T _state;
  late StreamController<T> _streamController;

  BaseState(T initState, [bool autoDispose = false]) {
    _streamController = StreamController<T>.broadcast();
    addToSink(initState);
    init();
    _streamController.onCancel = () {
      if (autoDispose == true) {
        close();
      }
    };
  }

  T get state => _state;
  set state(T newState) {
    addToSink(newState);
  }

  void addToSink(T state) {
    _state = state;
    _streamController.sink.add(_state);
  }

  void error(Object err) {
    _streamController.addError(err);
    throw err;
  }

  Stream<T> get stream => _streamController.stream;

  void close() {
    _streamController.close();
    dispose();
  }

  void init() {}
  void dispose() {}
}
