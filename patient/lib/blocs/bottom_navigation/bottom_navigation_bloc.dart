import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/auth/blocs.dart';
import './bloc.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final AuthBloc authBloc;
  int index = 0;

  BottomNavigationBloc({@required this.authBloc});

  @override
  BottomNavigationState get initialState => HomePageLoaded();

  @override
  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is PageTapped) {
      index = event.index;
      switch(event.index) {
        case 1:
          yield DiaryPageLoaded();
          break;
        case 2:
          yield AnalyticsPageLoaded();
          break;
        case 3:
          yield DoctorPageLoaded();
          break;
        case 4:
          yield HomePageLoaded();
          break;
        default:
          yield HomePageLoaded();
      }
    }
  }
}
