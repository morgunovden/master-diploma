import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/home/bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:patient/helpers/functions.dart';
import 'package:patient/models/models.dart';

class HbA1CInfo extends StatefulWidget {
  @override
  _HbA1CInfoState createState() => _HbA1CInfoState();
}

class _HbA1CInfoState extends State<HbA1CInfo> {

  static List<charts.Series<DayGlucose, int>> _createSampleData(List<Diary> records) {
    final hippoLength = records.where((record) => double.parse(record.glucose) < 4).length;
    final lowLength = records.where((record) => double.parse(record.glucose) >= 4 && double.parse(record.glucose) <= 5).length;
    final normalLength = records.where((record) => double.parse(record.glucose) >= 5 && double.parse(record.glucose) < 8.5).length;
    final warnLength = records.where((record) => double.parse(record.glucose) >= 8.5 && double.parse(record.glucose) < 11).length;
    final troubleLength = records.where((record) => double.parse(record.glucose) > 11).length;
    final _data = [
      new DayGlucose(0, hippoLength, Color.fromRGBO(124, 85, 237, 1)),
      new DayGlucose(1, lowLength, Color.fromRGBO(85, 194, 255, 1)),
      new DayGlucose(2, normalLength, Color.fromRGBO(9, 202, 109, 1)),
      new DayGlucose(3, warnLength, Color.fromRGBO(249, 187, 30, 1)),
      new DayGlucose(4, troubleLength, Color.fromRGBO(242, 60, 60, 1)),
    ];

    return [
      new charts.Series(
        id: 'DayGlucose',
        data: _data,
        domainFn: (DayGlucose glucose, _) => glucose.type,
        measureFn: (DayGlucose glucose, _) => glucose.value,
        colorFn: (DayGlucose glucose, _) => glucose.color,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<charts.Series> seriesList = [
          new charts.Series(
            id: 'DayGlucoseEmpty',
            data: [],
            domainFn: (_, __) => 0,
            measureFn: (_, __) => 100,
            colorFn: (_, __) => new charts.Color(r: Theme.of(context).primaryColorLight.red, g: Theme.of(context).primaryColorLight.green, b: Theme.of(context).primaryColorLight.blue, a: Theme.of(context).primaryColorLight.alpha),
          ),
        ];
        double glucoseAvg = 0;
        String a1c = '0.0';

        if (state is HomeLoaded) {
          seriesList = _createSampleData(state.records);
          glucoseAvg = state.records.length > 0 ? double.parse(state.records.map((item) => item.glucose).reduce((value, element) => (double.parse(value) + double.parse(element)).toString())) / state.records.length : 0;
          a1c = calculateA1c(glucoseAvg);
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Распределение уровня сахара',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxHeight: 170,),
                      child: Stack(
                        children: <Widget>[
                          new charts.PieChart(
                            seriesList,
                            animate: true,
                            defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 15,
                            ),
                            layoutConfig: charts.LayoutConfig(
                              bottomMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0, minPixel: 0),
                              topMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0, minPixel: 0),
                              leftMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0, minPixel: 0),
                              rightMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0, minPixel: 0),
                            ),
                          ),
                          Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 60,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    a1c,
                                    style: TextStyle(
                                      fontSize: 30,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: getColorFromGlucose(glucoseAvg),
                                    ),
                                  ),
                                  Text(
                                    'HbA1C',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            getA1cTitle(double.parse(a1c)),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: getColorFromGlucose(glucoseAvg),
                            ),
                          ),
                          Text(
                            getA1cSubTitle(double.parse(a1c)),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(31, 31, 31, 0.6),
                            ),
                          ),
                        ],
                      ),
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

class DayGlucose {
  final int type;
  final int value;
  final charts.Color color;

  DayGlucose(this.type, this.value, Color color) : this.color = new charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
