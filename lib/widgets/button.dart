import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';

import '../helpers/glitch_extension.dart';
import '../screens/game_screen.dart';
import '../screens/info_screen.dart';

class CyberButton extends StatelessWidget {
  const CyberButton({Key key, this.text = 'Back'}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) => InkWell(
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.black38,
        shape: const BeveledRectangleBorder(
            side: BorderSide(color: Colors.cyanAccent),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomRight: Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 40.0, right: 42.0),
          child: Text(text,
              style: FontEnchantments.displayClean.copyWith(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute<Route>(
              fullscreenDialog: true, builder: (context) => ((text == 'Back') ? const InfoScreen() : const Game()))));
}
