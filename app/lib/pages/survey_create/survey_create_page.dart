import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/survey_create/discard_dialog.dart';
import 'package:sage/pages/survey_create/identicon_text_field.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/viewmodels.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';
import 'package:sage/widgets/draggable_handle.dart';
import 'package:sage/widgets/question_icon.dart';
import 'package:sage/widgets/slide_in_animation.dart';

class SurveyCreatePage extends StatefulWidget {
  @override
  _SurveyCreatePageState createState() => _SurveyCreatePageState();
}

class _SurveyCreatePageState extends State<SurveyCreatePage>
    with ViewModelState<SurveyCreateViewModel, SurveyCreatePage> {
  final GlobalKey<SliverAnimatedListState> _animatedListKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    viewModel.eventListener = onQuestionEvent;
  }

  void onQuestionEvent(QuestionEvent event, int index, Question question) {
    print([event, index]);
    switch (event) {
      case QuestionEvent.added:
        _animatedListKey.currentState?.insertItem(index);
        break;
      case QuestionEvent.removed:
        _animatedListKey.currentState?.removeItem(
          index,
          (context, animation) => _QuestionItem(
            question: question,
            animation: animation,
            isFirst: index == 0,
            isLast: index == viewModel.questions.length - 1,
          ),
        );
        break;
    }
  }

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
        appBar: AppBar(
          title: const Text('Novo questionário'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adicionar pergunta',
          child: Icon(Icons.add),
          onPressed: () async {
            final question = await navigator(context).pushQuestionCreate();

            if (question != null) {
              viewModel.addQuestion(question as Question);
            }
          },
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: _SurveyList(animatedListKey: _animatedListKey),
    );
  }
}

class _SurveyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SurveyCreateViewModel>(context);
    return Container(
      color: Colors.white,
      child: IdenticonTextField(
        title: viewmodel.title,
        onChanged: (title) => viewmodel.title = title,
      ),
    );
  }
}

class _SurveyList extends StatelessWidget {
  final Key animatedListKey;

  _SurveyList({Key key, this.animatedListKey}) : super(key: key);

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
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: 86 /* FAB */ + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverAnimatedList(
                key: animatedListKey,
                initialItemCount: questions.length,
                itemBuilder: (context, index, animation) {
                  return _QuestionItem(
                    question: questions[index],
                    isFirst: index == 0,
                    isLast: index == questions.length - 1,
                    animation: animation,
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
  final Animation<double> animation;

  _QuestionItem({
    @required this.question,
    @required this.isFirst,
    @required this.isLast,
    @required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: ValueKey(question.uuid),
      childBuilder: _buildChild,
    );
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        border: Border(
          top: isFirst && !placeholder
              ? Divider.createBorderSide(context)
              : BorderSide.none,
          bottom: isLast && placeholder
              ? BorderSide.none //
              : Divider.createBorderSide(context),
        ),
        color: placeholder ? null : Colors.white,
      );
    }

    return Container(
      decoration: decoration,
      child: Opacity(
        opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
        child: SlideInAnimation(
          animation: animation,
          child: ListTile(
            leading: QuestionIcon(type: question.type),
            title: Text(question.title),
            subtitle: Text(question.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _QuestionPopupButton(question: question),
                const DraggableHandle(),
              ],
            ),
          ),
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
            .performPopupAction(action, question.uuid);
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
