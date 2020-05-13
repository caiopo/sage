import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/di/di.dart';
import 'package:sage/pages/survey_create/discard_dialog.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';

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
          title: Text('Novo questionário'),
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adicionar pergunta',
          child: Icon(Icons.add),
          onPressed: () {
//            navigator(context).pushAn
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('hello'),
    );
  }
}

class _SurveyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SurveyCreateViewModel>(context);

    final questions = viewmodel.questions;

    return ReorderableList(
      onReorder: (Key draggedItem, Key newPosition) {
        return viewmodel.reorder(draggedItem, newPosition);
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _SurveyHeader(),
            ]),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: 86 /* FAB */ + MediaQuery.of(context).padding.bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _QuestionItem(
                    data: questions[index],
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
    );
  }
}

class _QuestionItem extends StatelessWidget {
  _QuestionItem({
    this.data,
    this.isFirst,
    this.isLast,
  });

  final Question data;
  final bool isFirst;
  final bool isLast;

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
          leading: Icon(_getIconData()),
          title: Text(data.title),
          subtitle: Text(data.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildMenuButton(),
              ReorderableListener(
                child: Container(
                  width: 48,
                  decoration: ShapeDecoration(
                    color: Color(0x0D000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  height: 48,
                  child: Center(
                    child: Icon(Icons.reorder, color: Color(0xFF888888)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: ValueKey(data.uuid),
      childBuilder: _buildChild,
    );
  }

  Widget _buildMenuButton() {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Editar'),
            ],
          ),
          value: 0,
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Remover'),
            ],
          ),
          value: 1,
        ),
      ],
    );
  }

  IconData _getIconData() {
    switch (data.type) {
      case QuestionType.single:
        return Icons.radio_button_checked;

      case QuestionType.multi:
        return Icons.check_box;

      case QuestionType.numeric:
        return Icons.looks_one;

      case QuestionType.text:
        return Icons.question_answer;
    }

    return Icons.error_outline;
  }
}
