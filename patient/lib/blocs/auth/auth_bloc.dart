import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/auth/blocs.dart';


import 'package:patient/models/user.dart';
import 'package:patient/repositories/repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  User user;

  AuthBloc({@required this.authRepository})
    : assert(authRepository != null);

  @override
  AuthState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();
      user = await authRepository.getUser();

      yield hasToken ? AuthenticationAuthenticated(user: user) : AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      user = event.user;
      await authRepository.persistInfo(event.user);
      yield AuthenticationAuthenticated(user: event.user);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.delete();
      yield AuthenticationUnauthenticated();
    }
  }
}
