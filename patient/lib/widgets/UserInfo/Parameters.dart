import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Parameters extends StatefulWidget {
  Function callback;

  Parameters({@required this.callback});

  @override
  _ParametersState createState() => _ParametersState(callback: callback);
}

class _ParametersState extends State<Parameters> {
  Function callback;

  _ParametersState({@required this.callback});

  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _growthController = TextEditingController();
  final _birthdayController = TextEditingController();

  FocusNode _weightFocusNode;
  FocusNode _growthFocusNode;
  FocusNode _birthdayFocusNode;
  List<DropdownMenuItem<String>> _items;
  String _value;

  @override
  void initState() {
    _weightFocusNode = FocusNode();
    _growthFocusNode = FocusNode();
    _birthdayFocusNode = FocusNode();
    _items = [
      DropdownMenuItem<String>(
        child: Text(
          'тренеровки 2-3 раза в неделю'
        ),
        value: 'one',
      ),
      DropdownMenuItem<String>(
        child: Text(
          'тренеровки 2-3 раза в неделю'
        ),
        value: 'two',
      ),
    ];
    _value = 'one';

    super.initState();
  }

  @override
  void dispose() {
    _weightFocusNode.dispose();
    _growthFocusNode.dispose();
    _birthdayFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AutoSizeText(
              'Ваши параметры',
              style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  height: 1.1
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText(
              'Это нужно для составления персонализированых подсказок, касательно компенсации диабета.',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  height: 1
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: TextFormField(
                        focusNode: _weightFocusNode,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          labelText: 'Вес',
                          labelStyle: TextStyle(
                              color: _weightFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
                        controller: _weightController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          callback('weight', _weightController.text);
                          FocusScope.of(context).requestFocus(_growthFocusNode);
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Invalid weight!';
                          }
                          return '';
                        },
                      ),
                    )
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: TextFormField(
                        focusNode: _growthFocusNode,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          labelText: 'Рост',
                          labelStyle: TextStyle(
                              color: _growthFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
                        controller: _growthController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          callback('growth', _growthController.text);
                          FocusScope.of(context).requestFocus(_birthdayFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Invalid growth!';
                          }
                          return '';
                        },
                      ),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: _birthdayFocusNode,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                labelText: 'День рождения',
                labelStyle: TextStyle(
                    color: _birthdayFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              controller: _birthdayController,
              textInputAction: TextInputAction.next,
              readOnly: true,
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  locale: LocaleType.ru,
                  onConfirm: (date) {
                    _birthdayController.value = TextEditingValue(text: DateFormat('yyyy-MM-dd').format(date));
                    callback('birthday', _birthdayController.text);
                  }
                );
              },
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Invalid growth!';
                }
                return '';
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: _value,
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
                callback('typeOfUnits', '0');
              },
              items: _items,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                labelText: 'Фактор физической активности',
                labelStyle: TextStyle(
                    color: _birthdayFocusNode.hasFocus ? Color.fromRGBO(47, 163, 156, 0.6) : Theme.of(context).primaryColor,
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
            )
          ],
        ),
      ),
    );
  }
}
