import 'package:black_dragon_app/src/data/models/Instructor_model.dart';
import 'package:black_dragon_app/src/data/providers/instructor_provider.dart';

import 'package:rxdart/rxdart.dart';
import 'dart:async';

class InstructorBloc {

  final _instructorController  = new BehaviorSubject<InstructorModel>();
  final _instructorProvider     = new InstructorProvider();

  Stream<InstructorModel> get instructorStream => _instructorController.stream;

  void buscarInstructor() async {
    final des = await _instructorProvider.buscarInstructor();
    _instructorController.add(des);    
  }

   dispose() {
    _instructorController?.close();
  }
}