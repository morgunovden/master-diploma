import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:patient/blocs/bottom_navigation/bloc.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            size: 32,
            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
          ),
          child: item.icon,
        ),
        SizedBox(
          width: isSelected ? 13 : 0,
        ),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          child: item.title,
          style: isSelected ? TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor) : TextStyle(fontSize: 0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _onTap(int index) {
      BlocProvider.of<BottomNavigationBloc>(context).add(
          PageTapped(index: index)
      );
    }

    return BlocListener<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {
      },
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          List<NavigationItem> items = [
            NavigationItem(Icon(Icons.home), Text('Главная')),
            NavigationItem(Icon(Icons.list), Text('Дневник')),
            NavigationItem(Icon(OMIcons.insertChartOutlined), Text('Аналитика')),
            NavigationItem(Icon(Icons.add_circle_outline), Text('Доктор')),
            NavigationItem(Icon(OMIcons.settings), Text('Настройки')),
          ];

          return Container(
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 1.0))),
            width: MediaQuery.of(context).size.width,
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((item) {
                int itemIndex = items.indexOf(item);
                return GestureDetector(
                  onTap: () {
                    _onTap(itemIndex);
                    setState(() {
                      selectedIndex = itemIndex;
                    });
                  },
                  child: _buildItem(item, selectedIndex == itemIndex),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;

  NavigationItem(this.icon, this.title);
}

