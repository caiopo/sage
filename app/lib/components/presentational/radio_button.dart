import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final bool selected;
  final String label;
  final void Function(bool selected, T value) onSelected;
  final T value;

  const RadioButton({
    Key key,
    @required this.selected,
    @required this.label,
    @required this.onSelected,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(!selected, value),
      child: Row(
        children: <Widget>[
          IgnorePointer(
            ignoring: true,
            child: Radio(
              onChanged: (value) {},
              groupValue: true,
              value: selected,
            ),
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
