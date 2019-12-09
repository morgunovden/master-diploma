import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:patient/models/diary.dart';

abstract class HomeState extends Equatable {
  final String bolus = '0';
  final String date = '';
  final String lastDiaryTime = '00:00';
  final List<Diary> records = [];
  final Diary lastRecord = null;

  HomeState();

  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {}

class HomeLoaded extends HomeState {
  final String bolus;
  final String date;
  final String lastDiaryTime;
  final List<Diary> records;
  final Diary lastRecord;

  HomeLoaded({@required this.bolus, @required this.date, @required this.lastDiaryTime, this.records, this.lastRecord});
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
