import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/auth/auth_bloc.dart';
import 'package:patient/models/models.dart';
import 'package:patient/repositories/diary/repositories.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthBloc authBloc;
  final DiaryRepository _diaryRepository = DiaryRepository(diaryApiClient: DiaryApiClient(httpClient: http.Client()));

  HomeBloc({@required this.authBloc});

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchDiaryHomeEvent) {
      yield* _mapDiaryToState();
    }
  }

  Stream<HomeState> _mapDiaryToState() async* {
    try {
      var params = [
        {
          'name': 'day',
          'value': true,
        }
      ];
      List<Diary> diary = await _diaryRepository.fetch(token: authBloc.state.token, params: params);
      Diary last = diary.length > 0 ? diary[0] : null;
      Diary lastWithBolus = diary.firstWhere((record) => record.bolus_count != '0', orElse: () => null);
      yield HomeLoaded(bolus: lastWithBolus != null ? lastWithBolus.bolus_count : '', date: lastWithBolus != null ? lastWithBolus.date : '', lastDiaryTime: last != null ? last.time : '', records: diary.length > 0 ? diary : [], lastRecord: last);
    } catch(error) {
      print(error);
      yield HomeFailure(error: error.toString());
    }
  }
}
