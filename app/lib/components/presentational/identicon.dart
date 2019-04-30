import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class Identicon extends HookWidget {
  final String value;
  final int size;

  Identicon(
    this.value, {
    @required this.size,
  }) : assert(size != null);

  @override
  Widget build(BuildContext context) {
    String svg = useMemoized(
      () => Jdenticon.toSvg(value.toString(), size: size),
      [value],
    );

    return SvgPicture.string(
      svg,
      fit: BoxFit.contain,
      height: size.toDouble(),
      width: size.toDouble(),
    );
  }
}
