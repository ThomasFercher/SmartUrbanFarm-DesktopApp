import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorFadeIcon extends StatefulWidget {
  final Color begin;
  final Color end;
  final IconData icon;
  final bool forward;
  const ColorFadeIcon({
    Key key,
    this.begin,
    this.end,
    this.icon,
    this.forward,
  }) : super(key: key);

  @override
  _ColorFadeTextState createState() => _ColorFadeTextState();
}

class _ColorFadeTextState extends State<ColorFadeIcon>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> _colorAnim;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _colorAnim =
        ColorTween(begin: widget.begin, end: widget.end).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    if (widget.forward) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    ColorFadeIcon a = oldWidget;
    if (a.forward != widget.forward) {
      widget.forward ? controller.forward() : controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      color: _colorAnim.value,
      size: 18,
    );
  }
}
