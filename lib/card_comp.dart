import 'package:flutter/material.dart';

class MyCardComp extends StatelessWidget {
  
  // Make variables to change there values when using the component
  Key keyVal;
  Animation<double> animation;
  String item;
  Color color;
  void Function()? process;
  //////////////////////////////////////////////////////////////////
  
  // Pass the values in the constractor
  MyCardComp({
    super.key,
    required this.keyVal,
    required this.animation,
    required this.item,
    required this.color,
    // this field is optional to set value to it
    this.process,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      // add unique key to each widget that help us in remove specific widget
      key: UniqueKey(),
      // add the animation
      sizeFactor: animation,
      child: Card(
        color: color,
        child: ListTile(
          title: Text(
            item,
            style: const TextStyle(
              color: Color.fromARGB(255, 185, 149, 248),
            ),
          ),
          // Put the icon in the right direction
          trailing: IconButton(
            onPressed: process,
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 185, 149, 248),
            ),
          ),
        ),
      ),
    );
  }
}
