import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/widgets/Home/ChangeHistogram.dart';
import 'package:patient/widgets/Home/HbA1CInfo.dart';

class Analitics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc(authBloc: BlocProvider.of<AuthBloc>(context)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          BlocProvider.of<HomeBloc>(context)..add(FetchDiaryHomeEvent());

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Аналитика',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 35,),
                  HbA1CInfo(),
                  SizedBox(height: 35,),
                  HomeChangeHistogram(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

