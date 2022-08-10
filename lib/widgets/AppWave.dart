import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';
import 'package:huxla/widgets/AppBackButton.dart';

class AppWave extends StatelessWidget {
  const AppWave({
    Key key,
    @required bool isPushed,
    @required bool image,
    @required CustomClipper clipper,
  })  : _isPushed = isPushed,
        _image = image,
        _clipper = clipper,
        super(key: key);

  final bool _isPushed;
  final bool _image;
  final CustomClipper _clipper;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _clipper,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
              child: Visibility(
                  visible: _isPushed,
                  child: AppBackButton(),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true),
            ),
            SizedBox(height: 25),
            Center(
              child: Visibility(
                visible: _image,
                child: Text(
                  'Huxla',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstBottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 140);

    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SecondBottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 100);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
