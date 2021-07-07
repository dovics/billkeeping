import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  Tag(this.text, {this.type = TagType.Default, this.fontsize = 10});
  final String text;
  final TagType type;
  final double fontsize; 
  Color type2Color() {
    switch (type) {
      case TagType.Success:
        return Color(0xFFF6FFED);
      case TagType.Processing:
        return Color(0xFFE6F7FF);
      case TagType.Error:
        return Color(0xFFFFF1F0);
      case TagType.Warning:
        return Color(0xFFFFF7E6);
      default:
        return Color(0xFFFAFAFA);
    }
  }

  Color type2TextColor() {
    switch (type) {
      case TagType.Success:
        return Color(0xff52C41A);
      case TagType.Processing:
        return Color(0xFF1890FF);
      case TagType.Error:
        return Color(0xFFF5222D);
      case TagType.Warning:
        return Color(0xFFFB9A59);
      default:
        return Color(0xff252525);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
      decoration: BoxDecoration(
        color: type2Color(),
        border: Border.all(color: type2TextColor(), width: 0.5),
        borderRadius: BorderRadius.all(Radius.elliptical(3, 3))
      ),
      child: Text(text,
          style: TextStyle(
            color: type2TextColor(),
            fontSize: fontsize,
          )),
    );
  }
}

enum TagType { Success, Processing, Error, Warning, Default }
