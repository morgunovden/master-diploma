import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/home/home_bloc.dart';
import 'package:patient/blocs/home/home_state.dart';

class HomeActiveBoluse extends StatefulWidget {
  @override
  _HomeActiveBoluseState createState() => _HomeActiveBoluseState();
}

class _HomeActiveBoluseState extends State<HomeActiveBoluse> {
  Timer _timer;
  String _left;
  final int total = 300;
  String _active;

  @override
  void initState() {
    super.initState();
    _left = '0ч.0м.';
    _active = '0';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          if (state.date.isNotEmpty) {
            DateTime startDate = DateTime.parse(state.date);
            DateTime endDate = startDate.add(Duration(hours: 5));
            DateTime now = DateTime.now();
            Duration difference = endDate.difference(now);
            List<String> differenceArray = difference.toString().split(':');

            if (difference.inMinutes.isNegative || difference.inMinutes == 0) {
              _left = '0ч.0м.';
              _active = '0';
            } else {
              _left = '${differenceArray[0]}ч.${differenceArray[1]}м.';
              _active = (double.parse(state.bolus) * (difference.inMinutes * 100 / total) / 100).toStringAsFixed(1);
            }

            _timer = new Timer.periodic(Duration(minutes: 1), (Timer timer) {
              difference = endDate.difference(now);
              differenceArray = difference.toString().split(':');
              _left = '${differenceArray[0]}ч.${differenceArray[1]}м.';
              if (!this.mounted) {
                timer.cancel();
              }
              if (this.mounted) {
                if (difference.inMinutes.isNegative || difference.inMinutes == 0) {
                  _left = '0ч.0м.';
                  _active = '0';
                  timer.cancel();
                } else {
                  setState(() {
                    _left = '${differenceArray[0]}ч.${differenceArray[1]}м.';
                    _active = (double.parse(state.bolus) * (difference.inMinutes * 100 / total) / 100).toStringAsFixed(1);
                  });
                }
              }
            });
          }
        }

        return Container(
          padding: EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color.fromRGBO(47, 163, 156, 1), Color.fromRGBO(53, 182, 174, 1),],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'активный инсулин'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$_active',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'из ${state.bolus}',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 25,),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Вывод',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'инсулина через',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      _left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

