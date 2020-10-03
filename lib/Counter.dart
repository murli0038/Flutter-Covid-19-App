import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

class Counter extends StatelessWidget {

  final int number;
  final Color colour;
  final String title;

  const Counter({
    Key key, this.number, this.colour, this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colour.withOpacity(.25)
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                    color: colour,
                    width: 2
                )
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "$number",
          style: TextStyle(
              fontSize: 30,
              color: colour
          ),
        ),
        Text(
          title,
          style: kSubTextStyle,
        )
      ],
    );
  }
}



class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

