import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient/blocs/auth/blocs.dart';
import 'package:patient/blocs/diary/bloc.dart';
import 'package:patient/screens/SplashScreen.dart';
import 'package:patient/widgets/DIary/DiaryItemWrapper.dart';
import 'package:patient/widgets/DIary/Filter.dart';
import 'package:patient/screens/Diary/CreateDiaryRecord.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DiaryBloc _diaryBloc;
//  AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 100), value: 0.0);
    _diaryBloc = DiaryBloc(authBloc: BlocProvider.of<AuthBloc>(context));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
//    _diaryBloc.close();

//    _rotationController.dispose();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  static const _PANEL_HEADER_HEIGHT = 0.0;

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - _PANEL_HEADER_HEIGHT;
    final double bottom = -_PANEL_HEADER_HEIGHT;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);

    return new Container(
      color: theme.backgroundColor,
      child: new Stack(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              return BlocListener<DiaryBloc, DiaryState>(
                listener: (context, state) {
                },
                child: BlocBuilder<DiaryBloc, DiaryState>(
                  builder: (context, state) {
                    if (state is DiaryListsFetched) {
                      var list = groupBy(state.diaryList, (item) => DateFormat('dd.MM.yyyy').format(DateTime.parse(item.date)));
                      return Container(
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              Container(
//                                padding: EdgeInsets.only(bottom: 50),
                                child: ListView.builder(
                                  itemBuilder: (context, position) {
                                    List<dynamic> keys = list.keys.toList();

                                    return DiaryItemWrapper(diaryItems: list[keys[position]], date: keys[position],);
                                  },
                                  itemCount: list.length,
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  left: constraints.biggest.width / 2 - 50,
                                  child: ButtonTheme(
                                    minWidth: 100,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(220),
                                    ),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return BlocProvider.value(
                                                  value: _diaryBloc,
                                                  child: CreateDiaryRecord()
                                              );
                                            }
                                        ));
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: IconTheme(
                                        data: IconThemeData(
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          )
                      );
                    }
                    return Container();
                  },
                ),
              );
            },
          ),
          PositionedTransition(
            rect: animation,
            child: GestureDetector(
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0)),
                elevation: 2,
                child: Column(children: <Widget>[
                  Container(
                    height: _PANEL_HEADER_HEIGHT,
                  ),
                  _isPanelVisible ? Expanded(child: Filter(),) : Container(),
                ]),
              ),
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        return _diaryBloc;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          primary: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  color: Color.fromRGBO(31, 31, 31, 0.6),
                ),
                child: Icon(
                  Icons.cloud_done,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Записи синхронизированы',
                style: TextStyle(
                  color: Color.fromRGBO(31, 31, 31, 0.6),
                  fontSize: 14,
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              color: Color.fromRGBO(31, 31, 31, 0.6),
              onPressed: () {
                _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
              },
              icon: RotationTransition(turns:  Tween(begin: 0.0, end: 0.5).animate(_controller), child: Icon(Icons.filter_list),),
//            icon: _open ? RotationTransition(turns:  Tween(begin: 0.0, end: 1.0).animate(_rotationController), child: Icon(Icons.filter_list),) : Icon(Icons.filter_list),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(),
            ),
          ),
        ),
        body: BlocBuilder<DiaryBloc, DiaryState>(
          builder: (context, state) {
            if (state is InitialDiaryState) {
              _diaryBloc.add(FetchDiaryLists());
            }

            if (state is DiaryListsFetched) {
              return LayoutBuilder(
                builder: _buildStack,
              );
            }

            return SplashPage();
          },
      ),
      ),
    );
  }
}
