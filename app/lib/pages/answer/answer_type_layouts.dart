import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/utils/text_fields.dart';

class AnswerSingle extends StatelessWidget {
  final Question question;
  final String value;
  final ValueChanged<dynamic> onChanged;

  AnswerSingle({
    Key key,
    @required this.question,
    @required this.value,
    @required this.onChanged,
  })  : assert(question.type == QuestionType.single),
        assert(question.extras is QuestionExtrasSingle),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final extras = question.extras as QuestionExtrasSingle;

    return Column(
      children: <Widget>[
        for (final option in extras.options)
          RadioListTile<String>(
            title: Text(option),
            value: option,
            activeColor: primaryColor,
            onChanged: (v) => onChanged(v),
            groupValue: value,
            controlAffinity: ListTileControlAffinity.leading,
          ),
      ],
    );
  }
}

class AnswerMulti extends StatelessWidget {
  final Question question;
  final List<String> value;
  final ValueChanged<dynamic> onChanged;

  AnswerMulti({
    Key key,
    @required this.question,
    @required this.value,
    @required this.onChanged,
  })  : assert(question.type == QuestionType.multi),
        assert(question.extras is QuestionExtrasMulti),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final extras = question.extras as QuestionExtrasMulti;

    final value = this.value ?? [];

    return Column(
      children: <Widget>[
        for (final option in extras.options)
          CheckboxListTile(
            title: Text(option),
            value: value.contains(option),
            activeColor: primaryColor,
            onChanged: (checked) {
              if (checked) {
                onChanged(value + [option]);
              } else {
                onChanged(value.where((e) => e != option).toList());
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
      ],
    );
  }
}

class AnswerNumeric extends StatefulWidget {
  final Question question;
  final int value;
  final ValueChanged<dynamic> onChanged;
  final String validation;

  const AnswerNumeric({
    Key key,
    @required this.question,
    @required this.value,
    @required this.onChanged,
    @required this.validation,
  }) : super(key: key);

  @override
  _AnswerNumericState createState() => _AnswerNumericState();
}

class _AnswerNumericState extends State<AnswerNumeric> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value == null ? null : widget.value.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    assert(question.type == QuestionType.numeric);
    assert(question.extras is QuestionExtrasNumeric);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Resposta',
              errorText: widget.validation,
            ),
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: false,
            ),
            maxLines: 1,
            inputFormatters: [numberOnly],
            onChanged: (v) {
              final intValue = int.tryParse(v ?? '');
              widget.onChanged(intValue);
            },
          ),
        )
      ],
    );
  }
}

class AnswerText extends StatefulWidget {
  final Question question;
  final String value;
  final ValueChanged<dynamic> onChanged;
  final String validation;

  const AnswerText({
    Key key,
    @required this.question,
    @required this.value,
    @required this.onChanged,
    @required this.validation,
  }) : super(key: key);

  @override
  _AnswerTextState createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value == null ? null : widget.value.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    assert(question.type == QuestionType.text);
    assert(question.extras is QuestionExtrasText);

    final extras = question.extras as QuestionExtrasText;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Resposta',
              errorText: widget.validation,
            ),
            maxLines: 3,
            maxLength: extras.maxLength,
            onChanged: (v) => widget.onChanged(v),
          ),
        )
      ],
    );
  }
}
