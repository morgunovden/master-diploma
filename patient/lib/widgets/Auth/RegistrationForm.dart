import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/widgets/CommonButton.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}


class _RegistrationFormState extends State<RegistrationForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _repeatPasswordFocus;
  bool _passwordVisible;
  bool _repeatPasswordVisible;
  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  void initState() {
    super.initState();

    _emailFocus = new FocusNode();
    _passwordFocus = new FocusNode();
    _repeatPasswordFocus = new FocusNode();
    _passwordVisible = false;
    _repeatPasswordVisible = false;
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _repeatPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    __onRegistrationButtonPressed() {
      if (!_form.currentState.validate()) {
        return;
      }
      _form.currentState.save();
      BlocProvider.of<LoginBloc>(context).add(
          RegistrationButtonPressed(
            email: _authData['email'],
            password: _authData['password'],
          )
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is LoginInitial) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Container(
                height: orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height * 0.9
                    : MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.fromLTRB(0, (MediaQuery.of(context).size.height * 0.6) * 0.14, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: TextFormField(
                              focusNode: _emailFocus,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                labelText: 'Ваш email',
                                labelStyle: TextStyle(
                                    color: _emailFocus.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
                                    fontSize: 18
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                              focusNode: _passwordFocus,
                              obscureText: !_passwordVisible,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                labelText: 'Ваш пароль',
                                labelStyle: TextStyle(
                                    color: _passwordFocus.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
                                    fontSize: 18
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    _passwordFocus.unfocus();
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              controller: passwordController,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(_repeatPasswordFocus);
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Invalid password!';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                              focusNode: _repeatPasswordFocus,
                              obscureText: !_repeatPasswordVisible,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                labelText: 'Повторите пароль',
                                labelStyle: TextStyle(
                                    color: _repeatPasswordFocus.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
                                    fontSize: 18
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _repeatPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    _repeatPasswordFocus.unfocus();
                                    setState(() {
                                      _repeatPasswordVisible = !_repeatPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              controller: repeatPasswordController,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords don\'t match';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      onPressed: state is! LoginLoading ? __onRegistrationButtonPressed : null,
                      text: 'Зарегистрироваться',
                      isPrimaryFilled: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

