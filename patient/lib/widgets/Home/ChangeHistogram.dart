import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient/blocs/home/bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:patient/helpers/functions.dart';
import 'package:patient/models/models.dart';

class HomeChangeHistogram extends StatefulWidget {
  @override
  _HomeChangeHistogramState createState() => _HomeChangeHistogramState();
}

class _HomeChangeHistogramState extends State<HomeChangeHistogram> {

  static List<charts.Series<DayGlucose, DateTime>> _createSampleData(List<Diary> records) {
    final List<DayGlucose> _data = records.map<DayGlucose>((record) {
      return new DayGlucose(DateTime.parse(record.date), double.parse(record.glucose), getColorFromGlucose(double.parse(record.glucose)));
    }).toList();

    return [
      new charts.Series<DayGlucose, DateTime>(
        id: 'DayGlucoseHistogram',
        data: _data,
        colorFn: (DayGlucose glucose, _) => new charts.Color(r: Color.fromRGBO(47, 163, 156, 1).red, g: Color.fromRGBO(47, 163, 156, 1).green, b: Color.fromRGBO(47, 163, 156, 1).blue, a: Color.fromRGBO(47, 163, 156, 1).alpha),
        domainFn: (DayGlucose glucose, _) => glucose.time,
        measureFn: (DayGlucose glucose, _) => glucose.value,
        strokeWidthPxFn: (_, __) => 0.5,
      ),
      new charts.Series<DayGlucose, DateTime>(
        id: 'Point',
        domainFn: (DayGlucose glucose, _) => glucose.time,
        measureFn: (DayGlucose glucose, _) => glucose.value,
        data: _data,
        fillColorFn: (DayGlucose glucose, _) => new charts.Color(r: Colors.white.red, g: Colors.white.green, b: Colors.white.blue, a: Colors.white.alpha),
        strokeWidthPxFn: (_, __) => 1.5,
        colorFn: (DayGlucose glucose, _) => new charts.Color(r: getColorFromGlucose(glucose.value).red, g: getColorFromGlucose(glucose.value).green, b: getColorFromGlucose(glucose.value).blue, a: getColorFromGlucose(glucose.value).alpha),
      )
      // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint')
    ];
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<charts.Series<DayGlucose, DateTime>> series = _createSampleData(state.records);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'График изменения сахара',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 250,
                ),
                child: new charts.TimeSeriesChart(
                  series,
                  animate: true,
                  customSeriesRenderers: [
                    new charts.PointRendererConfig(
                        customRendererId: 'customPoint'),
                  ],
                  domainAxis: new charts.DateTimeAxisSpec(
                    tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                      hour: new charts.TimeFormatterSpec(
                        format: 'hh',
                        transitionFormat: 'hh:mm',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DayGlucose {
  final DateTime time;
  final double value;
  final charts.Color color;

  DayGlucose(this.time, this.value, Color color) : this.color = new charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
