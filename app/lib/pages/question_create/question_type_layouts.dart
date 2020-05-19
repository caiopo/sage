import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/widgets/draggable_handle.dart';

class CreateTypeQuestion extends StatelessWidget {
  final QuestionType type;
  final ValueChanged<QuestionExtras> onChanged;

  const CreateTypeQuestion({
    Key key,
    this.type,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildInternal(),
    );
  }

  Widget _buildInternal() {
    switch (type) {
      case QuestionType.single:
        return CreateSingleQuestion(onChanged: onChanged);
      case QuestionType.multi:
        return CreateMultiQuestion(onChanged: onChanged);
      case QuestionType.numeric:
        return CreateNumericQuestion(onChanged: onChanged);
      case QuestionType.text:
        return CreateTextQuestion(onChanged: onChanged);
    }

    return Container();
  }
}

class CreateSingleQuestion extends StatelessWidget {
  final ValueChanged<QuestionExtras> onChanged;

  const CreateSingleQuestion({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.red,
    );
  }
}

class CreateMultiQuestion extends StatefulWidget {
  final ValueChanged<QuestionExtras> onChanged;

  const CreateMultiQuestion({Key key, this.onChanged}) : super(key: key);

  @override
  _CreateMultiQuestionState createState() => _CreateMultiQuestionState();
}

class _CreateMultiQuestionState extends State<CreateMultiQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.purple,
    );
  }
}

class CreateNumericQuestion extends StatefulWidget {
  final ValueChanged<QuestionExtras> onChanged;

  const CreateNumericQuestion({Key key, this.onChanged}) : super(key: key);

  @override
  _CreateNumericQuestionState createState() => _CreateNumericQuestionState();
}

class _CreateNumericQuestionState extends State<CreateNumericQuestion> {
  int min;
  int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor mínimo',
            ),
            validator: _intValidator,
            onSaved: (_min) {
              setState(() {
                min = int.tryParse(_min);
              });
              widget.onChanged(QuestionExtrasNumeric(
                min: min,
                max: max,
              ));
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor máximo',
            ),
            validator: _intValidator,
            onSaved: (_max) {
              setState(() {
                max = int.tryParse(_max);
              });
              widget.onChanged(QuestionExtrasNumeric(
                min: min,
                max: max,
              ));
            },
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class CreateTextQuestion extends StatefulWidget {
  final ValueChanged<QuestionExtras> onChanged;

  const CreateTextQuestion({Key key, this.onChanged}) : super(key: key);

  @override
  _CreateTextQuestionState createState() => _CreateTextQuestionState();
}

class _CreateTextQuestionState extends State<CreateTextQuestion> {
  int minLength;
  int maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tamanho mínimo',
            ),
            validator: _intValidator,
            onSaved: (min) {
              setState(() {
                minLength = int.tryParse(min);
              });
              widget.onChanged(QuestionExtrasText(
                minLength: minLength,
                maxLength: maxLength,
              ));
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tamanho máximo',
            ),
            validator: _intValidator,
            onSaved: (max) {
              setState(() {
                maxLength = int.tryParse(max);
              });
              widget.onChanged(QuestionExtrasText(
                minLength: minLength,
                maxLength: maxLength,
              ));
            },
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

String _intValidator(String str) {
  if (str == null || str.isEmpty) {
    return null;
  }

  int value = int.tryParse(str);

  if (value == null) {
    return 'Número inválido';
  }

  return null;
}

class OptionList extends StatefulWidget {
  final List<String> initialValues;

  const OptionList({Key key, this.initialValues}) : super(key: key);

  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  List<String> _values;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: (Key draggedItem, Key newPosition) {
        final draggedValue = (draggedItem as ValueKey<String>).value;
        final newPositionValue = (draggedItem as ValueKey<String>).value;

        final draggedPosition = _values.indexOf(draggedValue);
        final newPosition = _values.indexOf(newPositionValue);

        _values.removeAt(draggedPosition);
        _values.insert(newPosition, draggedValue);

        return true;
      },
      child: Column(
        children: <Widget>[
          for (final s in _values) _OptionItem(title: s),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;

  const _OptionItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          _QuestionPopupButton(question: question),
          const DraggableHandle(),
        ],
      ),
    );
  }
}
