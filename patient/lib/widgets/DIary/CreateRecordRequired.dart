import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/models/models.dart';

class CreateRecordRequired extends StatefulWidget {
  final Function callback;

  CreateRecordRequired({@required this.callback});

  @override
  _CreateRecordRequiredState createState() => _CreateRecordRequiredState(callback: callback);
}

class _CreateRecordRequiredState extends State<CreateRecordRequired> {
  final Function callback;

  _CreateRecordRequiredState({@required this.callback});

  final _dateDayController = TextEditingController();
  final _dateMonthController = TextEditingController();
  final _dateYearController = TextEditingController();
  FocusNode _dateDayFocusNode;
  FocusNode _dateMonthFocusNode;
  FocusNode _dateYearFocusNode;

  final _timeMinutesController = TextEditingController();
  final _timeSecondsController = TextEditingController();
  final _timeMilisecondsController = TextEditingController();
  FocusNode _timeMinutesFocusNode;
  FocusNode _timeSecondsFocusNode;
  FocusNode _timeMilisecondsFocusNode;

//  final _glucoseController = new MaskedTextController(mask: '00.00');
  final _glucoseController = TextEditingController();
  FocusNode _glucoseFocusNode;

//  final _carbohydratesController = new MaskedTextController(mask: '00');
  final _carbohydratesController = TextEditingController();
  FocusNode _carbohydratesFocusNode;

//  final _bolusController = new MaskedTextController(mask: '00.00');
  final _bolusController = TextEditingController();
  FocusNode _bolusFocusNode;
  String _bolus;

//  final _basalController = new MaskedTextController(mask: '00.00');
  final _basalController = TextEditingController();
  FocusNode _basalFocusNode;
  String _basal;

  String _category;

  final _notesController = TextEditingController();
  FocusNode _notesFocusNode;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru_RU', null);
    _dateDayFocusNode = FocusNode();
    _dateMonthFocusNode = FocusNode();
    _dateYearFocusNode = FocusNode();
    _dateYearController.addListener(_dateListener);

    _timeMinutesFocusNode = FocusNode();
    _timeSecondsFocusNode = FocusNode();
    _timeMilisecondsFocusNode = FocusNode();
    _timeSecondsController.addListener(_timeListener);

    _glucoseFocusNode = FocusNode();
    _glucoseController.addListener(_glucoseListener);

    _carbohydratesFocusNode = FocusNode();
    _carbohydratesController.addListener(_carbohydratesListener);

    _basalFocusNode = FocusNode();
    _basalController.addListener(_basalListener);

    _bolusFocusNode = FocusNode();
    _bolusController.addListener(_bolusListener);

    _notesFocusNode = FocusNode();
    _notesController.addListener(_notesListener);

    List<String> dateArray = DateFormat('dd-MM-yyyy').format(DateTime.now()).split('-');
    List<String> timeArray = DateFormat.Hm('ru_RU').format(DateTime.now()).split(':');

    _dateDayController.value = TextEditingValue(text: dateArray[0]);
    _dateMonthController.value = TextEditingValue(text: dateArray[1]);
    _dateYearController.value = TextEditingValue(text: dateArray[2]);

    _timeMinutesController.value = TextEditingValue(text: timeArray[0]);
    _timeSecondsController.value = TextEditingValue(text: timeArray[1]);
  }

  @override
  void dispose() {
    _dateDayFocusNode.dispose();
    _dateMonthFocusNode.dispose();
    _dateYearFocusNode.dispose();
    _timeMinutesFocusNode.dispose();
    _timeSecondsFocusNode.dispose();
    _timeMilisecondsFocusNode.dispose();
    _glucoseFocusNode.dispose();
    _carbohydratesFocusNode.dispose();
    _bolusFocusNode.dispose();
    _basalFocusNode.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }



  List<DropdownMenuItem<String>> _generateMenuItems(dynamic infoItems) {
    List<DropdownMenuItem<String>> tempList = [];

    for (var item in infoItems) {
      tempList.add(
        DropdownMenuItem<String>(
          child: Text(item.name),
          value: item.id,
        ),
      );
    }

    return tempList;
  }

  _dateListener() {
    String tempDate = '${_dateYearController.text}-${_dateMonthController.text}-${_dateDayController.text}';
    callback('date', '${tempDate}T');
  }
  _timeListener() {
    String tempTime = '${_timeMinutesController.text}:${_timeSecondsController.text}';
    callback('time', tempTime,);
  }
  _glucoseListener() {
    callback('glucose', _glucoseController.text);
  }
  _carbohydratesListener() {
    callback('carbohydrates', _carbohydratesController.text);
  }
  _bolusListener() {
    callback('bolus_count', _bolusController.text);
    callback('drugs_bolus', _bolus);
  }
  _basalListener() {
    callback('basal_count', _basalController.text);
    callback('drugs_basal', _basal);
  }
  _notesListener() {
    callback('notes', _notesController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryBloc, DiaryState>(
      listener: (context, state) {
        if (state is FetchDiaryInfoState) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<DiaryBloc, DiaryState>(
        builder: (context, state) {
          List<DropdownMenuItem<String>> categories = [];
          List<DropdownMenuItem<String>> drugsBolus = [];
          List<DropdownMenuItem<String>> drugsBasal = [];
          List<Drugs> bolusList = [];
          List<Drugs> basalList = [];
          List<Category> categoriesList = [];

          if (state is DiaryListsFetched) {
            categoriesList = state.categoriesList;
            bolusList = state.drugsList.where((drug) => drug.type == '0').toList();
            basalList = state.drugsList.where((drug) => drug.type == '1').toList();
            categories = _generateMenuItems(categoriesList);
            drugsBolus = _generateMenuItems(bolusList);
            drugsBasal = _generateMenuItems(basalList);

            if (_category == null) {
              _category = categoriesList[0].id;
              _bolus = bolusList[0].id;
              _basal = basalList[0].id;

              callback('category', _category);
            }
          }

          return Container(
            padding: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Дата',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconTheme(
                              data: IconThemeData(
                                size: 12,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              locale: LocaleType.ru,
                              onConfirm: (date) {
                                _dateDayController.value = TextEditingValue(text: DateFormat('dd').format(date));
                                _dateMonthController.value = TextEditingValue(text: DateFormat('MM').format(date));
                                _dateYearController.value = TextEditingValue(text: DateFormat('yyyy').format(date));
                              }
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Center(
                                      child: TextFormField(
                                        focusNode: _dateDayFocusNode,
                                        controller: _dateDayController,
                                        style: TextStyle(),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(2),
                                          hintText: 'дд',
                                          errorText: null,
                                          errorStyle: TextStyle(
                                            fontSize: 0,
                                            height: 0,
                                          ),
                                        ),
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(_dateMonthFocusNode);
                                        },
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _dateMonthFocusNode,
                                    controller: _dateMonthController,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: 'мм',
                                      errorText: null,
                                      errorStyle: TextStyle(
                                        fontSize: 0,
                                        height: 0,
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(_dateYearFocusNode);
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    focusNode: _dateYearFocusNode,
                                    controller: _dateYearController,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: 'гггг',
                                      errorText: null,
                                      errorStyle: TextStyle(
                                        fontSize: 0,
                                        height: 0,
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(_timeMinutesFocusNode);
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Время',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconTheme(
                              data: IconThemeData(
                                size: 12,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          DatePicker.showTimePicker(
                              context,
                              showTitleActions: true,
                              locale: LocaleType.ru,
                              currentTime: DateTime.now(),
                              onConfirm: (date) {
                                List<String> timeArray = DateFormat.Hm('ru_RU').format(date).split(':');
                                _timeMinutesController.value = TextEditingValue(text: timeArray[0]);
                                _timeSecondsController.value = TextEditingValue(text: timeArray[1]);
                              }
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _timeMinutesFocusNode,
                                    controller: _timeMinutesController,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: 'чч',
                                    ),
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(_timeSecondsFocusNode);
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _timeSecondsFocusNode,
                                    controller: _timeSecondsController,
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(2),
                                      hintText: 'мм',
                                    ),
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(_timeMilisecondsFocusNode);
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 100,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: Text(
                        'Категория',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(31, 31, 31, 0.3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _category,
                        items: categories,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _category = value;
                          });
                          callback('category', _category);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: Text(
                        'Глюкоза',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(31, 31, 31, 0.3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _glucoseFocusNode,
                        controller: _glucoseController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          hintText: '00.00',
                          suffix: Text('mmol/L'),
                          errorText: null,
                          errorStyle: TextStyle(
                            fontSize: 0,
                            height: 0,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_carbohydratesFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: Text(
                        'Углеводы',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(31, 31, 31, 0.3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _carbohydratesFocusNode,
                        controller: _carbohydratesController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          hintText: '00',
                          suffix: Text('грамм'),
                          errorText: null,
                          errorStyle: TextStyle(
                            fontSize: 0,
                            height: 0,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_bolusFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField(
                              value: _bolus,
                              items: drugsBolus,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(2),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _bolus = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _bolusFocusNode,
                        controller: _bolusController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          hintText: '00.00',
                          suffix: Text('ед.'),
                          errorText: null,
                          errorStyle: TextStyle(
                            fontSize: 0,
                            height: 0,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_basalFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40 - 30,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField(
                              value: _basal,
                              items: drugsBasal,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(2),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _basal = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _basalFocusNode,
                        controller: _basalController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          hintText: '00.00',
                          suffix: Text('ед.'),
                          errorText: null,
                          errorStyle: TextStyle(
                            fontSize: 0,
                            height: 0,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_notesFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Примечания',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(31, 31, 31, 0.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _notesController,
                      focusNode: _notesFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Введите запись сюда…',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
