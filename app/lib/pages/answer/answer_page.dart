import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/widgets/ghost.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  int questionIndex = 0;
  bool pressedPrevious = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    final question = Question(
        uuid: 'a',
        title:
            'Instead of mashing up nutty sweet chili sauce with oysters, use a handfull and a half teaspoons lentils juice and one cup pepper soup pot.',
        description:
            'Ferox, bi-color assimilatios satis convertam de domesticus, magnum onus.',
        type: QuestionType.single,
        optional: false,
        extras: QuestionExtrasSingle(
          options: [
            'Maçã',
            'Goiaba',
            'Pêra',
            'Banana',
            'Pêssego',
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: PageTransitionSwitcher(
              reverse: pressedPrevious,
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Column(
                key: ValueKey(questionIndex),
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

//            for (final option
//                in (question.extras as QuestionExtrasSingle).options)
//              RadioListTile(
//                title: Text(option),
//                value: false,
//                onChanged: (v) {},
//                groupValue: true,
//                controlAffinity: ListTileControlAffinity.leading,
//              ),

                  for (final option
                      in (question.extras as QuestionExtrasSingle).options)
                    RadioListTile(
                      title: Text(option),
                      activeColor: primaryColor,
                      value: true,
                      groupValue: false,
                      onChanged: (v) {},
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                  SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // previous/next buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              onPrevious: () {
                setState(() {
                  questionIndex--;
                  pressedPrevious = true;
                });
              },
              onNext: () {
                setState(() {
                  questionIndex++;
                  pressedPrevious = false;
                });
              },
              showPrevious: true,
              showNext: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonBar extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool showPrevious;
  final bool showNext;

  const ButtonBar({
    Key key,
    this.onPrevious,
    this.onNext,
    this.showPrevious = true,
    this.showNext = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    final textColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
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
            child: Ghost(
              show: showNext,
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
          ),
        ],
      ),
    );
  }
}
