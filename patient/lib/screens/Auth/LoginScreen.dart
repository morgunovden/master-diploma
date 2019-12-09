import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/repositories/repositories.dart';
import 'package:patient/widgets/Auth/LoginForm.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  final AuthRepository authRepository;

  LoginScreen({Key key, @required this.authRepository})
    : assert(authRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: FlatButton.icon(
          label: Text(
            'Назад',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: authRepository,
          );
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, MediaQuery.of(context).size.height * 0.05, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Диабет привет',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

