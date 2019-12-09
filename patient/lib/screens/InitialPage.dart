import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/screens/Analitics.dart';
import 'package:patient/screens/Diary/DiaryScreen.dart';
import 'package:patient/screens/HomeScreen.dart';
import 'package:patient/widgets/BottomNav.dart';

import 'doctor/Doctor.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return BottomNavigationBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
        );
      },
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: Builder(
              builder: (ctx) {
                if (state is HomePageLoaded) {
                  return HomeScreen();
                }
                if (state is DiaryPageLoaded) {
                  return DiaryScreen();
                }
                if (state is DoctorPageLoaded) {
                  return DoctorScreen();
                }
                if (state is AnalyticsPageLoaded) {
                  return Analitics();
                }
                return Container();
              },
            ),
            bottomNavigationBar: Builder(
              builder: (ctx) {
                return BottomNav();
//                return BottomNavigationBar(
//                  currentIndex: bottomNavigationBloc.index,
//                  items: _items,
//                );
              },
            ),
          );
        },
      ),
    );
  }
}

