import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/blocs/home/bloc.dart';

class HomeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        double carbohydrates = 0;
        String glucoseAvg = '0';
        double deviation = 0;
        double deviationPercentage = 0;

        if (state is HomeLoaded && state.records.length > 0) {
          carbohydrates = state.records.map<double>((record) => double.parse(record.carbohydrates)).reduce((accum, value) => accum + value);
          glucoseAvg = (double.parse(state.records.map((item) => item.glucose).reduce((value, element) => (double.parse(value) + double.parse(element)).toString())) / state.records.length).toStringAsFixed(1);
//          deviation = double.parse(glucoseAvg) / 7;
          deviation = double.parse(glucoseAvg) / 7;
          deviationPercentage = 100 - (deviation - 1) * 100;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Текущий уровень'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              state.lastRecord != null ? state.lastRecord.glucose : '0',
                              style: TextStyle(
                                fontSize: 55,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'ммоль',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'углеводы'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              carbohydrates.toString(),
                              style: TextStyle(
                                fontSize: 55,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'гр.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'ср. уровень глюкозы',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              glucoseAvg,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'ммоль',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'отклонения глюкозы',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 30,
                                    height: 0.5,
                                  ),
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 30,
                                    height: 0.3,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              deviation.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'ед.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'нормальная глюкоза',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text(
                              '${deviationPercentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

