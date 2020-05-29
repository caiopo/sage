import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/pages/answer/answer_type_layouts.dart';
import 'package:sage/utils/viewmodels.dart';
import 'package:sage/viewmodels/answer_viewmodel.dart';
import 'package:sage/widgets/ghost.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage>
    with ViewModelState<AnswerViewModel, AnswerPage> {
  int questionIndex = 0;
  bool pressedPrevious = false;

  @override
  Widget build(BuildContext context) {
    final question = viewModel.currentQuestion;
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
      ),
      body: Stack(
        children: <Widget>[
          PageTransitionSwitcher(
            reverse: viewModel.previousPressed,
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: SizedBox.expand(
              key: ValueKey(question.uuid),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (question.optional)
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Chip(
                            visualDensity: VisualDensity.comfortable,
                            label: Text(
                              'Opcional',
                            ),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        ),
                      ),

                    // question title and description
                    Padding(
                      padding: EdgeInsets.only(
                        top: question.optional ? 0 : 24,
                        left: 24,
                        right: 24,
                        bottom: 24,
                      ),
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
                          if (question.description != null)
                            Text(
                              question.description ?? '',
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
                    _buildTypeSpecific(),
                  ],
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) => Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(
                onPrevious: viewModel.onPrevious,
                onNext: viewModel.onNext,
                showPrevious: !viewModel.isFirstQuestion,
                showNext: !viewModel.isLastQuestion && viewModel.canAdvance(),
                showFinish: viewModel.isLastQuestion && viewModel.canAdvance(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSpecific() {
    final question = viewModel.currentQuestion;

    switch (question.type) {
      case QuestionType.single:
        return AnswerSingle(
          question: question,
          value: viewModel.currentAnswer as String,
          onChanged: viewModel.setAnswer,
        );

      case QuestionType.multi:
        return AnswerMulti(
          question: question,
          value: viewModel.currentAnswer as List<String>,
          onChanged: viewModel.setAnswer,
        );

      case QuestionType.numeric:
        return AnswerNumeric(
          question: question,
          value: viewModel.currentAnswer as int,
          onChanged: viewModel.setAnswer,
          validation: viewModel.validation,
        );

      case QuestionType.text:
        return AnswerText(
          question: question,
          value: viewModel.currentAnswer as String,
          onChanged: viewModel.setAnswer,
          validation: viewModel.validation,
        );
    }

    return Container();
  }
}

class ButtonBar extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool showPrevious;
  final bool showNext;
  final bool showFinish;

  const ButtonBar({
    Key key,
    @required this.onPrevious,
    @required this.onNext,
    @required this.showPrevious,
    @required this.showNext,
    @required this.showFinish,
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
              show: showNext || showFinish,
              child: FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      showFinish ? 'FINALIZAR' : 'PRÓXIMA',
                      style: textStyle,
                    ),
                    const SizedBox(width: 8.0),
                    Icon(showFinish ? Icons.done : Icons.arrow_forward),
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
