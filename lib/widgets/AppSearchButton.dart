import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton(
      {Key key,
      @required String title,
      @required double size,
      @required Color color,
      @required Function onPressed,
      @required Widget icon,
      @required double paddingLeft,
      @required double paddingRight,
      @required bool isDisabled})
      : _title = title,
        _size = size,
        _color = color,
        _onPressed = onPressed,
        _icon = icon,
        _paddingLeft = paddingLeft,
        _paddingRight = paddingRight,
        _isDisabled = isDisabled,
        super(key: key);

  final String _title;
  final double _size;
  final Color _color;
  final Function _onPressed;
  final Widget _icon;
  final double _paddingLeft;
  final double _paddingRight;
  final bool _isDisabled;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(0.0),
      onPressed: _isDisabled ? null : _onPressed,
      color: _color,
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      disabledColor: AppColors.colorPrimary,
      disabledElevation: 4.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25)),
      child: Opacity(
        opacity: _isDisabled ? 0.4 : 1.0,
        child: Container(
          height: _size,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: [
                SizedBox(width: _paddingLeft),
                Text(
                  _title,
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Bold'),
                ),
                SizedBox(width: _paddingRight),
                _icon != null
                    ? Expanded(
                        child: CircleAvatar(
                          backgroundColor: AppColors.colorSecondary,
                          radius: 18,
                          child: _icon,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
