import 'package:flutter/material.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/pages/question_create/option_list.dart';

class CreateTypeQuestion extends StatelessWidget {
  final QuestionType type;
  final ValueChanged<QuestionExtras> onChanged;
  final QuestionExtras extras;

  const CreateTypeQuestion({
    Key key,
    this.type,
    this.onChanged,
    this.extras,
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
        return CreateSingleQuestion(onChanged: onChanged, extras: extras);
      case QuestionType.multi:
        return CreateMultiQuestion(onChanged: onChanged, extras: extras);
      case QuestionType.numeric:
        return CreateNumericQuestion(onChanged: onChanged, extras: extras);
      case QuestionType.text:
        return CreateTextQuestion(onChanged: onChanged, extras: extras);
    }

    return Container();
  }
}

class CreateSingleQuestion extends StatelessWidget {
  final ValueChanged<QuestionExtras> onChanged;
  final QuestionExtras extras;

  const CreateSingleQuestion({Key key, this.onChanged, this.extras})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initialValues = <String>[];

    // autocast only works for local variables
    final _extras = extras;
    if (_extras != null && _extras is QuestionExtrasSingle) {
      initialValues = _extras.options;
    }

    return OptionList(
      initialValues: initialValues,
      onSaved: (values) {
        onChanged(QuestionExtrasSingle(options: values));
      },
    );
  }
}

class CreateMultiQuestion extends StatelessWidget {
  final ValueChanged<QuestionExtras> onChanged;
  final QuestionExtras extras;

  const CreateMultiQuestion({Key key, this.onChanged, this.extras})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initialValues = <String>[];

    // autocast only works for local variables
    final _extras = extras;
    if (_extras != null && _extras is QuestionExtrasMulti) {
      initialValues = _extras.options;
    }

    return OptionList(
      initialValues: initialValues,
      onSaved: (values) {
        onChanged(QuestionExtrasMulti(options: values));
      },
    );
  }
}

class CreateNumericQuestion extends StatefulWidget {
  final ValueChanged<QuestionExtras> onChanged;
  final QuestionExtras extras;

  const CreateNumericQuestion({Key key, this.onChanged, this.extras})
      : super(key: key);

  @override
  _CreateNumericQuestionState createState() => _CreateNumericQuestionState();
}

class _CreateNumericQuestionState extends State<CreateNumericQuestion> {
  int min;
  int max;

  @override
  void initState() {
    super.initState();
    final extras = widget.extras;
    if (extras != null && extras is QuestionExtrasNumeric) {
      min = extras.min;
      max = extras.max;
    }
  }

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
  final QuestionExtras extras;

  const CreateTextQuestion({Key key, this.onChanged, this.extras})
      : super(key: key);

  @override
  _CreateTextQuestionState createState() => _CreateTextQuestionState();
}

class _CreateTextQuestionState extends State<CreateTextQuestion> {
  int minLength;
  int maxLength;

  @override
  void initState() {
    super.initState();
    final extras = widget.extras;
    if (extras != null && extras is QuestionExtrasText) {
      minLength = extras.minLength;
      maxLength = extras.maxLength;
    }
  }

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
              errorMaxLines: 2,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                minLength = int.tryParse(value);
              });
            },
            validator: (str) {
              if (str == null || str.isEmpty) {
                return null;
              }

              if (minLength == null) {
                return 'Número inválido';
              }

              if (minLength < 0) {
                return 'Deve ser positivo';
              }

              if (maxLength != null && minLength > maxLength) {
                return 'Deve ser menor que o tamanho máximo';
              }

              return null;
            },
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
              errorMaxLines: 2,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                maxLength = int.tryParse(value);
              });
            },
            validator: (str) {
              if (str == null || str.isEmpty) {
                return null;
              }

              if (maxLength == null) {
                return 'Número inválido';
              }

              if (maxLength < 0) {
                return 'Deve ser positivo';
              }

              if (minLength != null && minLength > maxLength) {
                return 'Deve ser maior que o tamanho mínimo';
              }

              return null;
            },
            onSaved: (max) {
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
