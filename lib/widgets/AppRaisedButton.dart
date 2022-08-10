import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';

class AppRaisedButton extends StatelessWidget {
  const AppRaisedButton({
    Key key,
    @required String title,
    @required Color color,
    @required Function onPressed,
    @required Icon icon,
  })  : _title = title,
        _color = color,
        _onPressed = onPressed,
        _icon = icon,
        super(key: key);

  final String _title;
  final Color _color;
  final Function _onPressed;
  final Icon _icon;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPressed,
      color: _color,
      textColor: Colors.white,
      shape: new RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.colorSecondary,
            width: 1.2,
            style: BorderStyle.solid,
          ),
          borderRadius: new BorderRadius.circular(5)),
      child: Container(
        height: 60,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _title,
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Regular'),
              ),
              _icon,
            ],
          ),
        ),
      ),
    );
  }
}
