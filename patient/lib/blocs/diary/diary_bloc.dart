import 'dart:async';
import 'dart:math';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/models/models.dart';
import 'package:patient/repositories/category/repositories.dart';
import 'package:patient/repositories/diary/diary_api_client.dart';
import 'package:patient/repositories/diary/diary_repository.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  AuthBloc authBloc;
  final CategoryRepository _categoryRepository = CategoryRepository(categoryApiClient: CategoryApiClient(httpClient: http.Client()));
  final DiaryRepository _diaryRepository = DiaryRepository(diaryApiClient: DiaryApiClient(httpClient: http.Client()));

  DiaryBloc({this.authBloc});

  @override
  DiaryState get initialState => InitialDiaryState();

  @override
  Stream<DiaryState> mapEventToState(
    DiaryEvent event,
  ) async* {
    if (event is FetchDiaryLists) {
      yield* _mapCategoriesToState();
    }
    if (event is CreateDiaryRecordEvent) {
      yield FetchDiaryInfoState();
      try {
        await this._diaryRepository.create(token: authBloc.state.token, record: event.record);
        yield* _mapCategoriesToState();
      } catch(error) {
        print(error);
        yield DiaryFailure(error: error.toString());
      }
    }
  }

  Stream<DiaryState> _mapCategoriesToState() async* {
    try {
      List<Category> categories = await _categoryRepository.list(authBloc.state.token);
      List<Drugs> drugs = await _categoryRepository.drugs(authBloc.state.token);
      List<Activity> activities = await _categoryRepository.activities(authBloc.state.token);
      List<Diary> diary = await _diaryRepository.fetch(token: authBloc.state.token);
      yield DiaryListsFetched(categories, drugs, activities, diary);
    } catch(error) {
      yield DiaryFailure(error: error.toString());
    }
  }
}
