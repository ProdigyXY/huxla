import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';

class AppUnderlinedTextField extends StatelessWidget {
  const AppUnderlinedTextField({
    Key key,
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required String label,
    @required bool isObscure,
    @required Widget prefixIcon,
    @required Widget suffixIcon,
  })  : _controller = controller,
        _focusNode = focusNode,
        _label = label,
        _isObscure = isObscure,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _controller;
  final FocusNode _focusNode;
  final String _label;
  final bool _isObscure;
  final Widget _prefixIcon;
  final Widget _suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: _label,
        labelStyle: TextStyle(
            color: _focusNode.hasFocus ? AppColors.colorSecondary : Colors.grey,
            fontSize: 16.0),
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1.5),
        ),
        focusColor: AppColors.colorSecondary,
        focusedBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.colorSecondary, width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
      ),
      cursorColor: AppColors.colorSecondary,
      style: TextStyle(fontSize: 18, fontFamily: 'Poppins-Regular'),
    );
  }
}
