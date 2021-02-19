import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 15, color: Colors.green[900]),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}