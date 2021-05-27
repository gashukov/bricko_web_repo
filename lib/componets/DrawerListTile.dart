import 'package:bricko_web/constants.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.active,
    @required this.title,
    @required this.iconData,
    @required this.press,
  }) : super(key: key);

  final bool active;
  final String title;
  final IconData iconData;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      tileColor: active ? primaryColor.withOpacity(.2) : null,
      horizontalTitleGap: 0.0,
      leading: Icon(iconData, color: Colors.white54),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white54,
            fontSize: active ? 20 : 16,
            fontWeight: active ? FontWeight.bold : FontWeight.w300),
      ),
    );
  }
}
