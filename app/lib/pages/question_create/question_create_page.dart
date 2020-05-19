import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/models/question.dart';
import 'package:sage/pages/question_create/question_type_layouts.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/viewmodels.dart';
import 'package:sage/viewmodels/question_create_viewmodel.dart';

@MaterialRoute(
  returnType: Question,
)
class QuestionCreatePage extends StatefulWidget {
  final Question question;

  const QuestionCreatePage({Key key, this.question}) : super(key: key);

  @override
  _QuestionCreatePageState createState() => _QuestionCreatePageState();
}

class _QuestionCreatePageState extends State<QuestionCreatePage>
    with ViewModelState<QuestionCreateViewModel, QuestionCreatePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova pergunta',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                navigator(context).pop(viewModel.question);
              }
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pergunta',
                        hintText: 'Qual sua cor favorita?',
                        helperText: 'Obrigatório',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obrigatório';
                        }
                        return null;
                      },
                      onSaved: (title) => viewModel.mutateQuestion(
                        (question) => question.copyWith(title: title),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Texto auxiliar',
                        hintText: 'Qual sua cor favorita?',
                        helperText: 'Será exibido abaixo da pergunta',
                      ),
                      onSaved: (description) => viewModel.mutateQuestion(
                        (question) =>
                            question.copyWith(description: description),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<QuestionType>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tipo de pergunta',
                        helperText: 'Obrigatório',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Obrigatório';
                        }
                        return null;
                      },
                      items: [
                        for (final type in QuestionType.values)
                          DropdownMenuItem(
                            child: Text(type.label),
                            value: type,
                          ),
                      ],
                      onChanged: (type) => viewModel.changeType(type),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              CheckboxListTile(
                title: Text('Obrigatória'),
                activeColor: Theme.of(context).primaryColor,
                controlAffinity: ListTileControlAffinity.leading,
                value: !viewModel.question.optional,
                onChanged: (required) => viewModel.mutateQuestion(
                  (question) => question.copyWith(optional: !required),
                ),
              ),
              SizedBox(height: 16),
              CreateTypeQuestion(type: viewModel.question.type),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
