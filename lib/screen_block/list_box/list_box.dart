import 'package:flutter/material.dart';

class ListBox extends StatelessWidget {
  const ListBox({
    Key? key,
    required this.element,
    required this.color,
  }) : super(key: key);
  final String element;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: 250,
      height: 50,
      child: Center(
        child: Text(
          element,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
