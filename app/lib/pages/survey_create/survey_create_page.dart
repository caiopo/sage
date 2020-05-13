import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';
import 'package:sage/data/db.dart';
import 'package:sage/di/di.dart';
import 'package:sage/pages/survey_create/discard_dialog.dart';
import 'package:sage/pages/survey_create/identicon_text_field.dart';
import 'package:sage/router/router.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';
import 'package:sage/widgets/question_icon.dart';

class SurveyCreatePage extends StatefulWidget {
  @override
  _SurveyCreatePageState createState() => _SurveyCreatePageState();
}

class _SurveyCreatePageState extends State<SurveyCreatePage> {
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
          title: Text(
            'Novo questionário',
//            style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
          ),
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
          onPressed: () {
            navigator(context).pushQuestionCreate();
          },
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => inject<SurveyCreateViewModel>(),
      child: _SurveyList(),
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
                  _SectionTitle('Título'),
                  SizedBox(height: 8),
                  _SurveyHeader(),
                  SizedBox(height: 32),
                  _SectionTitle('Perguntas'),
                  SizedBox(height: 8),
                ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: 86 /* FAB */ + MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _QuestionItem(
                      question: questions[index],
                      // first and last attributes affect border drawn during dragging
                      isFirst: index == 0,
                      isLast: index == questions.length - 1,
                    );
                  },
                  childCount: questions.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  _QuestionItem({
    this.question,
    this.isFirst,
    this.isLast,
  });

  final Question question;
  final bool isFirst;
  final bool isLast;

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
        child: ListTile(
          leading: QuestionIcon(type: question.type),
          title: Text(question.title),
          subtitle: Text(question.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _QuestionPopupButton(question: question),
              const _QuestionDraggableHandle(),
            ],
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
        Provider.of<SurveyCreateViewModel>(context)
            .performPopupAction(action, question.uuid);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
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
            children: <Widget>[
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
            children: <Widget>[
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

class _QuestionDraggableHandle extends StatelessWidget {
  const _QuestionDraggableHandle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Reordenar',
      child: ReorderableListener(
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Pressione e arraste para reordenar'),
              ),
            );
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: ShapeDecoration(
              color: Color(0x0B000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: Center(
              child: Icon(Icons.reorder, color: Color(0xFF888888)),
            ),
          ),
        ),
      ),
    );
  }
}