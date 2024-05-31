import 'dart:async';
class CurrentUserStream
{
  final StreamController<void> _controller = StreamController<void>.broadcast();

  // Expose the stream
  Stream<void> get stream => _controller.stream;

  void notifyDataChanged() {
    _controller.add(null); 
  }
  void dispose() {
    _controller.close();
  }
}