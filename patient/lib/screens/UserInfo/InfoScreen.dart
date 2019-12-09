import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/blocs.dart';
import 'package:patient/blocs/patient_info/blocs.dart';
import 'package:patient/repositories/patient_info/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:patient/widgets/CommonButton.dart';
import 'package:patient/widgets/UserInfo/Parameters.dart';
import 'package:patient/widgets/UserInfo/PersonalInfo.dart';
import 'package:patient/widgets/UserInfo/Thanks.dart';
import 'package:patient/widgets/UserInfo/Therapy.dart';
import 'package:patient/widgets/UserInfo/Units.dart';

//class InfoScreen extends StatefulWidget {
//  @override
//  _InfoScreenState createState() => _InfoScreenState();
//}
class InfoScreen extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  var _data = {
    'first_name': '',
    'last_name': '',
    'sex': 'male',
    'diabetesType': '1',
    'typeOfUnits': '1',
    'glucoseUnit': '1',
    'weight': '0',
    'growth': '0',
    'birthday': '',
  };

  @override
  Widget build(BuildContext context) {
    final patientInfoRepository = PatientInfoRepository(
      patientInfoAPiClient: PatientInfoAPiClient(
        httpClient: http.Client(),
      ),
    );

    _saveData(String name, dynamic value) {
      print(value);
      _data[name] = value;

      print(_data);
    }
    return BlocProvider(
      builder: (context) {
        return PatientInfoBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
          patientInfoRepository: patientInfoRepository,
        );
      },
      child: BlocBuilder<PatientInfoBloc, PatientInfoState>(
        builder: (context, state) {
          _onNextStepButtonPressed() {
            switch(state.step) {
              case 0:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepOneDone(),
                );
                break;
              case 1:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepTwoDone(),
                );
                break;
              case 2:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepThreeDone(),
                );
                break;
              case 3:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepFourDone(),
                );
                break;
              case 4:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  SaveInfoToDatabase(
                    first_name: _data['first_name'],
                    last_name: _data['last_name'],
                    sex: _data['sex'],
                    weight: double.parse(_data['weight']),
                    growth: double.parse(_data['growth']),
                    birthday: _data['birthday'],
                    diabetes_type: int.parse(_data['diabetesType']),
//                    diabetesType: int.parse(_data['diabetesType']),
//                    typeOfUnits: int.parse(_data['typeOfUnits']),
//                    glucoseUnit: int.parse(_data['glucoseUnit']),
                  ),
                );
                break;
              default:
                print('Hello');
            }
          }
          _onPrevStepButtonPressed() {
            switch(state.step) {
              case 0:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  InitialStep(),
                );
                break;
              case 1:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  InitialStep(),
                );
                break;
              case 2:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepOneDone(),
                );
                break;
              case 3:
                BlocProvider.of<PatientInfoBloc>(context).add(
                  StepTwoDone(),
                );
                break;
              default:
                print('Hello');
            }
          }

          return Scaffold(
            backgroundColor: state.step == 4 ? Theme.of(context).primaryColor : Colors.white,
            appBar: AppBar(
              backgroundColor: state.step == 4 ? Theme.of(context).primaryColor : Colors.white,
              elevation: 0,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: state.step == 0 || state.step == 4 ? Text('') : FlatButton.icon(
                label: Text(
                  'Назад',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: _onPrevStepButtonPressed,
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0${state.step + 1} / 05',
                        style: TextStyle(
                          color: state.step == 4 ? Colors.white : Theme.of(context).primaryColorDark,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: Color.fromRGBO(242, 243, 255, 1),
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            ),
            body: SingleChildScrollView(
              controller: _controller,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 90,
                ),
                child: Container(
                  width: double.infinity,
//              height: MediaQuery.of(context).size.height - 85,
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
//                TODO: replace if statement
                      state is InitialPatientInfoState
                        ? PersonalInfo(callback: _saveData,)
                        : state is StepOneDonePatientInfoState
                          ? Units(callback: _saveData,)
                          : state is StepTwoDonePatientInfoState
                            ? Parameters(callback: _saveData,)
                            : state is StepThreeDonePatientInfoState
                              ? Therapy(callback: _saveData,)
                              : Thanks(),
                      CommonButton(
                        onPressed: _onNextStepButtonPressed,
                        isPrimaryFilled: state.step != 4,
                        isPrimary: state.step == 4,
                        text: state.step == 4 ? 'В приложение' : 'Вперед',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
    );
  }
}
