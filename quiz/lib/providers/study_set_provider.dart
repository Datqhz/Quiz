
import 'dart:async';

import 'package:quiz/models/study_set.dart';

class StudySetListStream{
  
   final StreamController<List<StudySetBrief>> _controller = StreamController<List<StudySetBrief>>.broadcast();

  List<StudySetBrief> currentData = [];

  // Expose the stream
  Stream<List<StudySetBrief>> get stream => _controller.stream;

  void notifyDataChanged(StudySetBrief studySet) {
    List<StudySetBrief> updatedList = currentData.where((item) => item.studySetId != studySet.studySetId).toList();
    _controller.add(updatedList); 
  }
  void initStream(List<StudySetBrief> list) {
    currentData = list;
    _controller.add(list); 
  }
  void dispose() {
    _controller.close();
  }
}