import 'package:flutter/material.dart';
import 'package:patient/repositories/repositories.dart';
import 'package:patient/screens/Auth/LoginScreen.dart';
import 'package:patient/screens/Auth/RegistrationScreen.dart';
import 'package:patient/widgets/CommonButton.dart';

class AuthMainScreen extends StatelessWidget {
  static const routeName = '/auth';
  final AuthRepository authRepository;

  AuthMainScreen({Key key, @required this.authRepository})
    : assert(authRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'DiaBET',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: CommonButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen(authRepository: authRepository,))
                      ),
                      text: 'Войти',
                      isPrimary: true,
                    ),
                  ),
                  CommonButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen(authRepository: authRepository,))
                    ),
                    text: 'Зарегистрироваться',
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

