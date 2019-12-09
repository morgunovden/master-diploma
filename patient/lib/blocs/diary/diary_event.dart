import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:patient/models/diary.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class FetchDiaryLists extends DiaryEvent {}

class CreateDiaryRecordEvent extends DiaryEvent {
  final String record;

  CreateDiaryRecordEvent({@required this.record});
}
