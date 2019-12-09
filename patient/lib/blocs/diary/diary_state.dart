import 'package:equatable/equatable.dart';
import 'package:patient/models/models.dart';
import 'package:meta/meta.dart';

abstract class DiaryState extends Equatable {
  final List<Category> categories = [];
  final List<Drugs> drugs = [];
  final List<Activity> activities = [];
  final List<Diary> diaries = [];

  DiaryState([List props = const []]);

  @override
  List<Object> get props => [];
}

class InitialDiaryState extends DiaryState {}

class FetchDiaryInfoState extends DiaryState {}

class DiaryListsFetched extends DiaryState {
  final List<Category> categories;
  final List<Drugs> drugs;
  final List<Activity> activities;
  final List<Diary> diary;

  DiaryListsFetched(this.categories, this.drugs, this.activities, this.diary) : super([categories, drugs, activities, diary]);

  @override
  List<Object> get props => [categories, drugs, activities];

  List<Category> get categoriesList => categories;

  List<Drugs> get drugsList => drugs;

  List<Activity> get activitiesList => activities;

  List<Diary> get diaryList => diary;
}

class DiaryFailure extends DiaryState {
  final String error;

  DiaryFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
