import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class Identicon extends StatefulWidget {
  final String value;
  final int size;

  Identicon({
    this.value,
    @required this.size,
  }) : assert(size != null);

  @override
  _IdenticonState createState() => _IdenticonState();
}

class _IdenticonState extends State<Identicon> {
  String svg;

  @override
  void initState() {
    super.initState();
    compute();
  }

  @override
  void didUpdateWidget(Identicon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      compute();
    }
  }

  void compute() {
    final _svg = Jdenticon.toSvg(widget.value.toString(), size: widget.size);
    setState(() {
      svg = _svg;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (svg == null) {
      return Container(
        height: widget.size.toDouble(),
        width: widget.size.toDouble(),
      );
    }

    return SvgPicture.string(
      svg,
      fit: BoxFit.contain,
      height: widget.size.toDouble(),
      width: widget.size.toDouble(),
    );
  }
}
