import 'package:flutter/widgets.dart';
import 'package:suf_linux/styles.dart';

class SectionHeading extends StatelessWidget {
  final String text;

  const SectionHeading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 2),
      child: Text(
        text,
        style: heading2,
      ),
    );
  }
}
