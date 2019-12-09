import 'package:patient/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Conversation extends StatefulWidget {
  final Doctor doctor;

  Conversation({this.doctor});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  FocusNode _messageFocusNode;
  FocusNode _optionsFocusNode;
  AnimationController _controller;

  @override
  void initState() {
    _messageFocusNode = FocusNode();
    _optionsFocusNode = FocusNode();
    _controller = new AnimationController(vsync: this,duration: const Duration(milliseconds: 100), value: 0.0);
    super.initState();
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
      begin: new RelativeRect.fromLTRB(0.0, top + 65, 0.0, bottom + 65),
      end: new RelativeRect.fromLTRB(0.0, top - 280, 0.0, bottom + 65),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _messageFocusNode.dispose();
    _optionsFocusNode.dispose();
    super.dispose();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);

    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 56,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 49,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(47, 163, 156, 0.05),
                      border: Border.all(color: Color.fromRGBO(31, 31, 31, 0.05)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
//                        FocusScope.of(context).unfocus();
//                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
                      },
                      focusNode: _optionsFocusNode,
                      icon: IconTheme(
                        data: IconThemeData(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(Icons.apps),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                        focusNode: _messageFocusNode,
                        controller: _messageController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(31, 31, 31, 0.05),),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(31, 31, 31, 0.05),),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        PositionedTransition(
            rect: animation,
            child: _isPanelVisible ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0)),
              ),
              padding: EdgeInsets.only(
                top: 45,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor, size: 32,),
                        label: Text(
                          'Записаться к врачу',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        )
                    ),
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.format_list_bulleted, color: Theme.of(context).primaryColor, size: 32,),
                        label: Text(
                          'Поделиться записью дневника',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        )
                    ),
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.insert_chart, color: Theme.of(context).primaryColor, size: 32,),
                        label: Text(
                          'Поделиться аналитикой',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ) : Container(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String fullName = '${widget.doctor.first_name} ${widget.doctor.last_name}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
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
              SizedBox(width: 10,),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}

