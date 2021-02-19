import 'package:flutter/material.dart';

class MyDuck extends StatelessWidget {
  const MyDuck({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 60, width: 60, child: Image.asset('lib/images/duck.png'));
  }
}
