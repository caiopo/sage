import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/radio_button.dart';

@immutable
class RadioItem<T> {
  final String label;
  final T key;

  RadioItem({
    this.key,
    this.label,
  });
}

class CollapsingRadioGroup<T> extends HookWidget {
  final List<RadioItem<T>> items;
  final ValueChanged<T> onSelected;

  CollapsingRadioGroup({
    Key key,
    @required this.items,
    @required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = useState<T>(null);

    final setSelected = (bool s, T v) {
      selected.value = s ? v : null;
      onSelected(selected.value);
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var item in items)
          _Collapsible(
            show: selected.value == null || selected.value == item.key,
            child: RadioButton<T>(
              label: item.label,
              selected: item.key == selected.value,
              value: item.key,
              onSelected: setSelected,
            ),
          )
      ],
    );
  }
}

class _Collapsible extends HookWidget {
  final bool show;
  final Widget child;

  const _Collapsible({
    Key key,
    this.show,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();

    return AnimatedOpacity(
      opacity: show ? 1 : 0,
      duration: const Duration(milliseconds: 100),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: show ? null : 0,
          child: child,
        ),
        vsync: ticker,
      ),
    );
  }
}
