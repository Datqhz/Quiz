import 'dart:async';

class NotifyChangeStream {
  StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  void notifyDataChanged(){
    _controller.add(null);
  }
  void dispose(){
    _controller.close();
  }
}