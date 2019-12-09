import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Therapy extends StatefulWidget {
  Function callback;

  Therapy({@required this.callback});

  @override
  _TherapyState createState() => _TherapyState(callback: callback);
}

enum TherapyTypes {
  type_1,
  type_2,
  type_3,
}

class _TherapyState extends State<Therapy> {
  Function callback;

  _TherapyState({@required this.callback});

  final _formKey = GlobalKey<FormState>();

  TherapyTypes _therapyTypes = TherapyTypes.type_1;
  List<DropdownMenuItem<String>> _pharmList;
  List<DropdownMenuItem<String>> _pharmList1;
  String _pharmValue;
  String _pharmValue1;

  @override
  void initState() {
    _pharmList = [
      DropdownMenuItem<String>(
        child: Text(
            'Apidra 32/24'
        ),
        value: 'one',
      ),
      DropdownMenuItem<String>(
        child: Text(
            'Lantus'
        ),
        value: 'two',
      ),
    ];
    _pharmList1 = [
      DropdownMenuItem<String>(
        child: Text(
            'Lantus'
        ),
        value: 'one',
      ),
      DropdownMenuItem<String>(
        child: Text(
            'Apidra 32/24'
        ),
        value: 'two',
      ),
    ];
    _pharmValue = 'one';
    _pharmValue1 = 'one';

    super.initState();
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
              'Терапия',
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
            AutoSizeText(
              'Какая у вас терапия?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile<TherapyTypes>(
                  title: const Text(
                    'Многократные инъекции инсулина',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  value: TherapyTypes.type_1,
                  groupValue: _therapyTypes,
                  onChanged: (value) {
                    setState(() {
                      _therapyTypes= value;
                    });
                  },
                ),
                RadioListTile<TherapyTypes>(
                  title: const Text(
                    'Инсулиновая помпа',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  value: TherapyTypes.type_2,
                  groupValue: _therapyTypes,
                  onChanged: (value) {
                    setState(() {
                      _therapyTypes= value;
                    });
                  },
                ),
                RadioListTile<TherapyTypes>(
                  title: const Text(
                    'Без инсулиновая терапия',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  value: TherapyTypes.type_3,
                  groupValue: _therapyTypes,
                  onChanged: (value) {
                    setState(() {
                      _therapyTypes= value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AutoSizeText(
              'Препараты',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: _pharmValue,
              onChanged: (String value) {
                setState(() {
                  _pharmValue = value;
                });
              },
              items: _pharmList,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                labelText: 'Быстрый/короткий инсулин',
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
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
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: _pharmValue1,
              onChanged: (String value) {
                setState(() {
                  _pharmValue1 = value;
                });
              },
              items: _pharmList1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                labelText: 'Средний/длинный инсулин',
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
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
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
