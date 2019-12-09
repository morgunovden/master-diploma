import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Units extends StatefulWidget {
  final Function callback;

  const Units({@required this.callback});

  @override
  _UnitsState createState() => _UnitsState(callback: callback);
}

enum TypeOfUnits {
  empirical,
  metric,
}

enum GlucoseUnits {
  type_1,
  type_2
}

class _UnitsState extends State<Units> {
  Function callback;

  _UnitsState({@required this.callback});

  final _formKey = GlobalKey<FormState>();
  TypeOfUnits _typeOfUnits = TypeOfUnits.empirical;
  GlucoseUnits _glucoseUnits = GlucoseUnits.type_1;

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
              'Единицы измерения',
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AutoSizeText(
                    'Укажите ед. измерения',
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
                      RadioListTile<TypeOfUnits>(
                        title: const Text(
                          'Эмпирические (lbs, oz, fl oz, inch)',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        value: TypeOfUnits.empirical,
                        groupValue: _typeOfUnits,
                        onChanged: (value) {
                          setState(() {
                            _typeOfUnits = value;
                          });
                          callback('typeOfUnits', '0');
                        },
                      ),
                      RadioListTile<TypeOfUnits>(
                        title: const Text(
                          'Метрические (кг, грамм, мл, см)',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        value: TypeOfUnits.metric,
                        groupValue: _typeOfUnits,
                        onChanged: (value) {
                          setState(() {
                            _typeOfUnits = value;
                          });
                          callback('typeOfUnits', '1');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AutoSizeText(
                    'Единицы глюкозы',
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
                      RadioListTile<GlucoseUnits>(
                        title: const Text(
                          'mmol/L',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        value: GlucoseUnits.type_1,
                        groupValue: _glucoseUnits,
                        onChanged: (value) {
                          setState(() {
                            _glucoseUnits = value;
                          });
                          callback('glucoseUnit', '0');
                        },
                      ),
                      RadioListTile<GlucoseUnits>(
                        title: const Text(
                          'mg/dL',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        value: GlucoseUnits.type_2,
                        groupValue: _glucoseUnits,
                        onChanged: (value) {
                          setState(() {
                            _glucoseUnits = value;
                          });
                          callback('glucoseUnit', '1');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

