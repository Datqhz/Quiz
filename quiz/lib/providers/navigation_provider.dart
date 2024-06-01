import 'dart:async';

class NavigationStream {
  StreamController<int> _controller = StreamController<int>.broadcast();

  Stream<int> get stream => _controller.stream;

  NavigationStream(int idx) {
    _controller.add(idx);
  }

  void notifyDataChanged(int idx) {
    _controller.add(idx);
  }
}
