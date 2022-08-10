import 'package:flutter/material.dart';
import 'package:huxla/models/service_category.dart';

class AppServicesListTile extends StatelessWidget {
  const AppServicesListTile({
    Key key,
    @required this.serviceCategory,
    @required bool isActive,
    @required Function onPressed,
  })  : _isActive = isActive,
        _onPressed = onPressed,
        super(key: key);

  final ServiceCategory serviceCategory;
  final bool _isActive;
  final Function _onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      highlightColor: Colors.black,
      onTap: _onPressed,
      onLongPress: () {},
      child: ListTile(
        selected: _isActive,
        selectedTileColor: Colors.white,
        tileColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Image.asset(
            serviceCategory.image,
            height: 60,
            width: 60,
          ),
        ),
        title: Container(
          transform: Matrix4.translationValues(10.0 - 15, 0.0, 0.0),
          child: Text(
            serviceCategory.title,
            style: TextStyle(fontFamily: 'Poppins-Bold', fontSize: 16),
          ),
        ),
        subtitle: Container(
          transform: Matrix4.translationValues(10.0 - 15, 0.0, 0.0),
          child: Text(
            serviceCategory.subtitle,
            style: TextStyle(fontFamily: 'Poppins-Light', fontSize: 12),
          ),
        ),
      ),
    );
  }
}
