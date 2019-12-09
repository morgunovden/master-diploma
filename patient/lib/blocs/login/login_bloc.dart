import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:patient/repositories/repositories.dart';

import 'package:patient/blocs/blocs.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.authRepository,
    @required this.authBloc,
  }) : assert(authRepository != null),
       assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await authRepository.signin(
          event.email,
          event.password
        );

        authBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is RegistrationButtonPressed) {
      yield LoginLoading();

      try {
        final user = await authRepository.signup(
          event.email,
          event.password
        );

        authBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
