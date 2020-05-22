import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/survey_create/discard_dialog.dart';
import 'package:sage/pages/survey_create/identicon_text_field.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/viewmodels.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';
import 'package:sage/widgets/draggable_item.dart';
import 'package:sage/widgets/question_icon.dart';
import 'package:sage/widgets/sliver_auto_animated_list.dart';

class SurveyCreatePage extends StatefulWidget {
  @override
  _SurveyCreatePageState createState() => _SurveyCreatePageState();
}

class _SurveyCreatePageState extends State<SurveyCreatePage>
    with ViewModelState<SurveyCreateViewModel, SurveyCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (context) => DiscardDialog(),
    );

    return quit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Novo questionário'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () async {
                final form = _formKey.currentState;
                validateQuestions();
                if (form.validate()) {
                  form.save();
                  await viewModel.save();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adicionar pergunta',
          child: Icon(Icons.add),
          onPressed: () async {
            final question = await navigator(context).pushQuestionCreate();
            print(question);
            if (question != null) {
              viewModel.addQuestion(question as Question);
            }
          },
        ),
        body: Form(
          key: _formKey,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: _SurveyList(),
    );
  }

  void validateQuestions() {
    if (viewModel.questions.isEmpty) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Você deve adicionar uma pergunta'),
      ));
    }
  }
}

class _SurveyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SurveyCreateViewModel>(context);
    return IdenticonTextField(
      title: viewmodel.title,
      onSaved: (title) => viewmodel.title = title,
    );
  }
}

class _SurveyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SurveyCreateViewModel>(context);
    final focusScope = FocusScope.of(context);

    final questions = viewmodel.questions;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels > 160) {
          focusScope.unfocus();
        }
        return true;
      },
      child: ReorderableList(
        onReorder: (Key draggedItem, Key newPosition) {
          focusScope.unfocus();
          return viewmodel.reorder(
            (draggedItem as ValueKey<String>).value,
            (newPosition as ValueKey<String>).value,
          );
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _SectionTitle('Título'),
                  const SizedBox(height: 8),
                  _SurveyHeader(),
                  const SizedBox(height: 32),
                  const _SectionTitle('Perguntas'),
                  const SizedBox(height: 8),
                ]),
              ),
            ),
            if (viewmodel.questions.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                    child: Column(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Image.asset(
                        'assets/images/ginger-cat/page-not-found.png',
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Adicione perguntas pressionando o ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.add),
                      ],
                    ),
                  ],
                )),
              )
            else
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 86 /* FAB */ + MediaQuery.of(context).padding.bottom,
                ),
                sliver: SliverAutoAnimatedList<Question>(
                  items: questions,
                  keyExtractor: (q) => q.uuid,
                  itemBuilder: (context, item) {
                    return _QuestionItem(
                      key: ValueKey(item.uuid),
                      question: item,
                      isFirst: item.uuid == questions.first?.uuid,
                      isLast: item.uuid == questions.last?.uuid,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final Question question;
  final bool isFirst;
  final bool isLast;

  _QuestionItem({
    Key key,
    @required this.question,
    @required this.isFirst,
    @required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableItem(
      key: ValueKey(question.uuid),
      isFirst: isFirst,
      isLast: isLast,
      child: ListTile(
        leading: SizedBox(
          width: 0, // minimum width the parent allows
          child: Center(
            child: QuestionIcon(type: question.type),
          ),
        ),
        title: Text(
          question.title,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(
          question.type.label,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _QuestionPopupButton(question: question),
            const DraggableHandle(),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 20));
  }
}

class _QuestionPopupButton extends StatelessWidget {
  final Question question;

  const _QuestionPopupButton({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<QuestionAction>(
      tooltip: 'Opções extras',
      onSelected: (action) {
        Provider.of<SurveyCreateViewModel>(context, listen: false)
            .performPopupAction(context, action, question.uuid);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Editar'),
            ],
          ),
          value: QuestionAction.edit,
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.content_copy),
              SizedBox(width: 16),
              Text('Duplicar'),
            ],
          ),
          value: QuestionAction.copy,
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Remover'),
            ],
          ),
          value: QuestionAction.delete,
        ),
      ],
    );
  }
}
