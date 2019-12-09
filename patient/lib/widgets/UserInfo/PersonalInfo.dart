import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/patient_info/blocs.dart';

class PersonalInfo extends StatefulWidget {
  final Function callback;

  const PersonalInfo({@required this.callback});

  @override
  _PersonalInfoState createState() => _PersonalInfoState(callback: callback);
}

enum SingingCharacter {
  first_type,
  second_type,
  prediabetes,
  gestational,
}

class _PersonalInfoState extends State<PersonalInfo> {
  Function callback;

  _PersonalInfoState({@required this.callback});

  final _key = GlobalKey<FormState>();
// controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
// focus nodes
  FocusNode _firstNameFocusNode;
  FocusNode _lastNameFocusNode;

  List<bool> _isSelected;
  SingingCharacter _character = SingingCharacter.first_type;

  @override
  void initState() {
    super.initState();

    _firstNameFocusNode = new FocusNode();
    _lastNameFocusNode = new FocusNode();

    _isSelected = [true, false];
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return BlocListener<PatientInfoBloc,PatientInfoState>(
      listener: (context, state) {
      },
      child: BlocBuilder<PatientInfoBloc, PatientInfoState>(
        builder: (context, state) {
          return Form(
            key: _key,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AutoSizeText(
                    'Персональные данные',
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        height: 1.1
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          focusNode: _firstNameFocusNode,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            labelText: 'Имя',
                            labelStyle: TextStyle(
                                color: _firstNameFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
                          controller: _firstNameController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_lastNameFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid first name!';
                            }
                            return '';
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          focusNode: _lastNameFocusNode,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            labelText: 'Фамилия',
                            labelStyle: TextStyle(
                                color: _lastNameFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
                          controller: _lastNameController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            callback('last_name', _lastNameController.text);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid last name!';
                            }
                            return '';
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AutoSizeText(
                          'Гендера только 2',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ToggleButtons(
                          isSelected: _isSelected,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderColor: Colors.transparent,
                          selectedColor: Colors.white,
                          fillColor: Theme.of(context).primaryColor,
                          color: Theme.of(context).primaryColor,
                          children: <Widget>[
                            Container(
                              width: (deviceWidth - 33) / 2,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Color.fromRGBO(47, 163, 156, 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Мужской',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (deviceWidth - 33) / 2,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Color.fromRGBO(47, 163, 156, 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Женский',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < _isSelected.length; i++) {
                                if (i == index) {
                                  _isSelected[i] = true;
                                } else {
                                  _isSelected[i] = false;
                                }
                              }
                            });
                            callback('sex', _isSelected[0] ? 'male' : 'female');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AutoSizeText(
                          'Какой у вас тип диабета?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RadioListTile<SingingCharacter>(
                              title: const Text(
                                'Диабет 1 типа',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: SingingCharacter.first_type,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  callback('diabetesType', '1');
                                });
                              },
                            ),
                            RadioListTile<SingingCharacter>(
                              title: const Text(
                                'Диабет 2 типа',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: SingingCharacter.second_type,
                              groupValue: _character,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _character = value;
                                  callback('diabetesType', '2');
                                });
                              },
                            ),
                            RadioListTile<SingingCharacter>(
                              title: const Text(
                                'Преддиабет',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: SingingCharacter.prediabetes,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  callback('diabetesType', '3');
                                });
                              },
                            ),
                            RadioListTile<SingingCharacter>(
                              title: const Text(
                                'Гестационный',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: SingingCharacter.gestational,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  callback('diabetesType', '4');
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
