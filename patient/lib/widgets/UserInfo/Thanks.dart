import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/patient_info/blocs.dart';
import 'package:patient/screens/HomeScreen.dart';

class Thanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientInfoBloc, PatientInfoState>(
      listener: (context, state) {
        if (state is PatientUpdateFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is FilledPatientInfoState) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      },
      child: BlocBuilder<PatientInfoBloc, PatientInfoState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  'Спасибо!',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                AutoSizeText(
                  'Регистрация завершена',
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
