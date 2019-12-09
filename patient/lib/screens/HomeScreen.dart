import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/auth/auth_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/blocs/home/home_bloc.dart';
import 'package:patient/blocs/home/home_event.dart';
import 'package:patient/blocs/home/home_state.dart';
import 'package:patient/helpers/functions.dart';
import 'package:patient/widgets/Home/ActiveBolus.dart';
import 'package:patient/widgets/Home/ChangeHistogram.dart';
import 'package:patient/widgets/Home/HbA1CInfo.dart';
import 'package:patient/widgets/Home/HomeInfo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _today = DateTime.now();
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc(authBloc: BlocProvider.of<AuthBloc>(context));
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  String _getDate(int number) {
    final day = _today.day;
    switch(number) {
      case 2:
        return '$day лют.';
      case 3:
        return '$day бер.';
      case 4:
        return '$day тра.';
      case 5:
        return '$day кві.';
      case 6:
        return '$day чер.';
      case 7:
        return '$day лип.';
      case 8:
        return '$day сер.';
      case 9:
        return '$day вер.';
      case 10:
        return '$day жов.';
      case 11:
        return '$day лис.';
      case 12:
        return '$day гру.';
      default:
        return '$day січ.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return _homeBloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          String _date = '';
          String _bolus = '';

          if (state is InitialHomeState) {
            _homeBloc.add(
              FetchDiaryHomeEvent(),
            );
          }

          if (state is HomePageLoaded) {
            _date = state.date;
            _bolus = state.bolus;
          }

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            primary: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        getWeekDay(_today.weekday),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getDate(_today.month),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Последний замер, ${state.lastDiaryTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: IconTheme(
                      data: IconThemeData(
                        color: Theme.of(context).primaryColorLight,
                        size: 32,
                      ),
                      child: Icon(
                        Icons.notifications_none,
                      ),
                    ),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'У вас 0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'подсказок',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    HomeActiveBoluse(),
                    SizedBox(height: 40,),
                    HomeInfo(),
                    SizedBox(height: 15,),
                    Divider(),
                    SizedBox(height: 25,),
                    HbA1CInfo(),
                    SizedBox(height: 35,),
                    HomeChangeHistogram(),
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
