
import 'dart:async';

import 'package:quiz/models/study_set.dart';

class StudySetStream{
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

class StudySetListStream{
  
   final StreamController<List<StudySet>> _controller = StreamController<List<StudySet>>.broadcast();

  List<StudySet> currentData = [];

  // Expose the stream
  Stream<List<StudySet>> get stream => _controller.stream;

  void notifyDataChanged(StudySet studySet) {
    List<StudySet> updatedList = currentData.where((item) => item.studySetId != studySet.studySetId).toList();
    _controller.add(updatedList); 
  }
  void initStream(List<StudySet> list) {
    currentData = list;
    _controller.add(list); 
  }
  void dispose() {
    _controller.close();
  }
}