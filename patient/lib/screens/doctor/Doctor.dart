import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/auth/blocs.dart';
import 'package:patient/blocs/doctor/bloc.dart';
import 'package:patient/models/models.dart';

import 'Conversation.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorBloc>(
      builder: (context) => DoctorBloc(authBloc: BlocProvider.of<AuthBloc>(context))..add(FetchDoctor()),
      child: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          Doctor doctor;
          String fullName = '';
          if (state is DoctorFetched) {
            doctor = state.doctor;
            fullName = '${doctor.first_name} ${doctor.last_name}';
          }

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Conversation(doctor: doctor,);
                        }
                    ));
                  },
                  icon: Icon(Icons.chat),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            body: doctor != null ? Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 122,
                        height: 122,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://eu.ui-avatars.com/api/?name=$fullName'
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            fullName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            doctor.university.name,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Загруженость',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              '${doctor.patients.length}/10',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                height: 1,
                              ),
                            ),
                            Text(
                              'пациентов',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Стаж',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(31, 31, 31, 0.6),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              '${doctor.experience}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                height: 1,
                              ),
                            ),
                            Text(
                              'лет работы',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Divider(),
                  SizedBox(height: 32,),
                  Text(
                    'О себе',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    doctor.about,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ) : Container(),
          );
        }
      ),
    );
  }
}
