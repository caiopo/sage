import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sage_client/sage_client.dart';
import 'package:sage_flutter/pages/auth_page.dart';
import 'package:sage_flutter/utils/hooks.dart';

Future<QuestionOption?> showOptionBottomSheet(
  BuildContext context, {
  QuestionOption? option,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return _OptionModal(option: option);
    },
  );
}

class _OptionModal extends HookWidget {
  const _OptionModal({super.key, this.option});

  final QuestionOption? option;

  @override
  Widget build(BuildContext context) {
    final globalKey = useGlobalKey<FormBuilderState>();
    final controller = useTextEditingController(
      text: option?.value,
    );

    void onSave() {
      final form = globalKey.currentState!;

      if (form.saveAndValidate()) {
        final value = form.value['option'];

        final oldOption = option;

        final newOption = oldOption == null
            ? QuestionOption(
                optionId: Uuid().v4obj(),
                value: value,
              )
            : oldOption.copyWith(value: value);

        Navigator.pop(context, newOption);
      }
    }

    return FormBuilder(
      key: globalKey,
      child: SizedBox(
        width: double.infinity,
        child: SafeArea(
          minimum: EdgeInsets.all(24),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'option',
                decoration: InputDecoration(
                  labelText: 'Option',
                ),
                controller: controller,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onSave,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
