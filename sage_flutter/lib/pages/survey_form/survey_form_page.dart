import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_client/sage_client.dart';
import 'package:sage_flutter/logic/questions.dart';
import 'package:sage_flutter/router.gr.dart';
import 'package:sage_flutter/utils/collections.dart';
import 'package:sage_flutter/utils/hooks.dart';
import 'package:sage_flutter/widgets/body.dart';
import 'package:sage_flutter/widgets/button_bottom_bar.dart';
import 'package:sage_flutter/widgets/drag_handle.dart';

@RoutePage()
class SurveyFormPage extends HookConsumerWidget {
  const SurveyFormPage({
    super.key,
    @PathParam('id') this.surveyId,
  });

  final int? surveyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useGlobalKey<FormBuilderState>();

    final loading = useState(false);
    final questions = useState(<Question>[]);
    print(questions);

    final isEdit = surveyId != null;

    void addQuestion() async {
      final question =
          await context.router.push<Question?>(QuestionFormRoute());
      if (question != null) {
        questions.value = [...questions.value, question];
      }
    }

    void onSave() {}

    return Scaffold(
      appBar: AppBar(
        title: isEdit ? Text('Edit survey') : Text('New survey'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.save),
            label: Text('Save'),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(theme.colorScheme.primaryContainer),
              foregroundColor:
                  WidgetStatePropertyAll(theme.colorScheme.onPrimary),
            ),
          )
        ],
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addQuestion,
        icon: Icon(Icons.add),
        label: Text('Add question'),
      ),
      body: FormBuilder(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  FormBuilderTextField(
                    name: 'title',
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      helperText: 'Optional',
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Questions',
                    style: theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            SliverReorderableList(
              itemBuilder: (context, index) {
                return _QuestionItem(
                  key: ValueKey(index),
                  index: index,
                  question: questions.value[index],
                );
              },
              itemCount: questions.value.length,
              onReorder: (previousIndex, newIndex) {
                questions.value =
                    questions.value.reordered(previousIndex, newIndex);
              },
            ),
            SliverList.list(
              children: [
                SizedBox(height: 96),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  const _QuestionItem({
    super.key,
    required this.index,
    required this.question,
  });

  final int index;

  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = Colors.accents[index % Colors.accents.length];

    return Material(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.4),
          ),
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge,
          ),
        ),
        title: Text(
          question.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Icon(question.type.icon, size: 16),
            SizedBox(width: 8),
            Text(question.type.label),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            popupButton(context),
            SizedBox(width: 8),
            DragHandle(index: index),
          ],
        ),
      ),
    );
  }

  Widget popupButton(BuildContext context) {
    return PopupMenuButton<_QuestionAction>(
      tooltip: 'Opções extras',
      onSelected: (action) {},
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: _QuestionAction.edit,
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: _QuestionAction.copy,
          child: Row(
            children: const [
              Icon(Icons.content_copy),
              SizedBox(width: 16),
              Text('Copy'),
            ],
          ),
        ),
        PopupMenuItem(
          value: _QuestionAction.delete,
          child: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Remove'),
            ],
          ),
        ),
      ],
    );
  }
}

enum _QuestionAction {
  edit,
  copy,
  delete,
}
