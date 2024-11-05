import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sage_client/sage_client.dart';
import 'package:sage_flutter/logic/questions.dart';
import 'package:sage_flutter/pages/survey_form/option_modal.dart';
import 'package:sage_flutter/utils/hooks.dart';
import 'package:sage_flutter/utils/uuid.dart';
import 'package:sage_flutter/widgets/body.dart';
import 'package:sage_flutter/widgets/button_bottom_bar.dart';
import 'package:sage_flutter/widgets/drag_handle.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class QuestionFormPage extends HookConsumerWidget {
  const QuestionFormPage({
    super.key,
    this.question,
  });

  final Question? question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useGlobalKey<FormBuilderState>();

    final isEdit = false;

    final type = useState<QuestionType?>(null);
    final options = useState<List<QuestionOption>>([]);

    void onSave() async {
      final form = formKey.currentState!;

      if (form.saveAndValidate()) {
        final values = form.value;
        final question = Question(
          title: values['title'],
          description: values['description'],
          required: values['required'],
          type: values['type'],
        );
        Navigator.pop(
          context,
          question,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: isEdit ? Text('Edit question') : Text('New question'),
        backgroundColor: theme.colorScheme.tertiaryContainer,
        foregroundColor: theme.colorScheme.onTertiaryContainer,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSave,
        icon: Icon(Icons.save),
        label: Text('Save'),
        backgroundColor: theme.colorScheme.tertiaryContainer,
        foregroundColor: theme.colorScheme.onTertiaryContainer,
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
                    validator: FormBuilderValidators.required(),
                    minLines: 1,
                    maxLines: 5,
                  ),
                  SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      helperText: 'Optional',
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                  SizedBox(height: 8),
                  FormBuilderCheckbox(
                    name: 'required',
                    initialValue: false,
                    title: Text(
                      'Required',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Question type',
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  FormBuilderRadioGroup(
                    name: 'type',
                    validator: FormBuilderValidators.required(),
                    onChanged: (final questionType) {
                      if (questionType != null) {
                        type.value = questionType;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    orientation: OptionsOrientation.vertical,
                    options: [
                      for (final type in QuestionType.values)
                        FormBuilderFieldOption(
                          value: type,
                          child: Row(
                            children: [
                              Text(type.label),
                              SizedBox(width: 8),
                              Icon(type.icon, size: 20),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            if (type.value == QuestionType.single ||
                type.value == QuestionType.multi)
              MultiSliver(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text(
                        'Options',
                        style: theme.textTheme.headlineMedium,
                      ),
                      Spacer(),
                      TextButton.icon(
                        onPressed: () async {
                          final option = await showOptionBottomSheet(context);
                          if (option != null) {
                            options.value = [...options.value, option];
                          }
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add option'),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                  SliverReorderableList(
                    itemBuilder: (context, index) {
                      return _OptionItem(
                        key: ValueKey(index),
                        index: index,
                        option: QuestionOption(
                          optionId: randomUuid(),
                          value: 'hello',
                        ),
                      );
                    },
                    itemCount: 10,
                    onReorder: (previousIndex, newIndex) {},
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    super.key,
    required this.index,
    required this.option,
  });

  final int index;

  final QuestionOption option;

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
          option.value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: DragHandle(index: index),
      ),
    );
  }
}
