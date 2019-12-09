import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:patient/repositories/repositories.dart';
import 'package:patient/screens//UserInfo/InfoScreen.dart';
import 'package:patient/screens/InitialPage.dart';
import 'package:patient/screens/SplashScreen.dart';
import 'package:patient/screens/Auth/MainScreen.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(),
  );
}

Future main() async {
  await DotEnv().load('.env');
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authRepository = AuthRepository(
    authApiClient: AuthApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(
    BlocProvider<AuthBloc>(
      builder: (context) {
        return AuthBloc(authRepository: authRepository,)
            ..add(AppStarted());
      },
      child: App(authRepository: authRepository),
    )
  );
}

class App extends StatelessWidget {
  final AuthRepository authRepository;

  App({Key key, @required this.authRepository}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Circe',
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(47, 163, 156, 1),
        primaryColorDark: Color.fromRGBO(31, 31, 31, 1),
        primaryColorLight: Color.fromRGBO(31, 31, 31, 0.3),
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final storage = new FlutterSecureStorage();
//          storage.delete(key: 'token');
//          storage.delete(key: 'id');
//          storage.delete(key: 'filled');
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return state.user.filled ? InitialPage() : InfoScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return AuthMainScreen(authRepository: authRepository,);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return Center(
            child: Text('Hello 1'),
          );
        },
      ),
    );
  }
}
