import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/widgets/ghost.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  @override
  Widget build(BuildContext context) {
    final question = Question(
        uuid: 'a',
//        title: 'a',
        title:
            'Instead of mashing up nutty sweet chili sauce with oysters, use a handfull and a half teaspoons lentils juice and one cup pepper soup pot.',
        description:
            'Ferox, bi-color assimilatios satis convertam de domesticus, magnum onus.',
        type: QuestionType.single,
        optional: false,
        extras: QuestionExtrasSingle(
          options: [
            'Maçã',
            'Banana',
            'Goiaba',
            'Melancia',
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // question title and description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    question.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    question.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // options

            for (final option
                in (question.extras as QuestionExtrasSingle).options)
              RadioListTile(
                title: Text(option),
                value: false,
                onChanged: (v) {},
                groupValue: true,
                controlAffinity: ListTileControlAffinity.leading,
              ),

            Expanded(child: Container()),

            ButtonBar(
              showPrevious: true,
              onNext: () {},
              onPrevious: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonBar extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool showPrevious;

  const ButtonBar({
    Key key,
    this.onPrevious,
    this.onNext,
    this.showPrevious = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    final textColor = Theme.of(context).primaryColor;

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 3,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Ghost(
              show: showPrevious,
              child: FlatButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text(
                  'ANTERIOR',
                  style: textStyle,
                ),
                textColor: textColor,
                padding: EdgeInsets.all(16),
                onPressed: onPrevious,
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'PRÓXIMA',
                    style: textStyle,
                  ),
                  const SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward),
                ],
              ),
              textColor: textColor,
              padding: EdgeInsets.all(16),
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
