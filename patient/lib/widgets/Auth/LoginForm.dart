import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/widgets/CommonButton.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  bool _passwordVisible;
  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  void initState() {
    super.initState();

    _emailFocus = new FocusNode();
    _passwordFocus = new FocusNode();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    __onLoginButtonPressed() {
      if (!_form.currentState.validate()) {
        return;
      }
      _form.currentState.save();
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
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
                    ? MediaQuery.of(context).size.height * 0.8
                    : MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.fromLTRB(
                    0, (MediaQuery.of(context).size.height * 0.6) * 0.14, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            focusNode: _emailFocus,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              labelText: 'Ваш email',
                              labelStyle: TextStyle(
                                  color: _emailFocus.hasFocus
                                      ? Color.fromRGBO(255, 255, 255, 0.6)
                                      : Colors.white,
                                  fontSize: 18),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
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
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            focusNode: _passwordFocus,
                            obscureText: !_passwordVisible,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              labelText: 'Ваш пароль',
                              labelStyle: TextStyle(
                                  color: _passwordFocus.hasFocus
                                      ? Color.fromRGBO(255, 255, 255, 0.6)
                                      : Colors.white,
                                  fontSize: 18),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _passwordFocus.unfocus();
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Invalid password!';
                              }
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Забыли пароль?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                ),
                              ),
                              FlatButton(
                                color: Colors.transparent,
                                child: Text(
                                  'Востановить',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(255, 255, 255, 0.9)),
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      onPressed: state is! LoginLoading ? __onLoginButtonPressed : null,
                      text: 'Войти',
                      isPrimary: true,
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
