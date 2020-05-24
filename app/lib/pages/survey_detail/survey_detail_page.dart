import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/utils/datetime.dart';
import 'package:sage/utils/random.dart';
import 'package:sage/widgets/identicon.dart';

class SurveyDetailPage extends StatefulWidget {
  final String surveyUuid;

  SurveyDetailPage({@required this.surveyUuid});

  @override
  _SurveyDetailPageState createState() => _SurveyDetailPageState();
}

class _SurveyDetailPageState extends State<SurveyDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print(theme.colorScheme.background);

    final survey = Survey(
      uuid: 'sdnajksdfa',
      title: 'Pesquisa de opinião lorem ipsum dolor sit amet',
      owner: '',
      uploadedAnswers: 10,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
        actions: <Widget>[
          _SurveyPopupMenuButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.edit),
        label: Text('RESPONDER'),
        onPressed: () {},
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: <Widget>[
                    Identicon(value: survey.title, size: 80),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            survey.title,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 16,
                  children: <Widget>[
                    Chip(
                      label: Text('Última resposta há 3 dias'),
                      backgroundColor: theme.accentColor,
                    ),
                    Chip(
                      label: Text('62 respostas enviadas'),
                    ),
                    Chip(
                      label: Text('10 respostas não enviadas'),
                      backgroundColor: Colors.orange.shade300,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Respostas não enviadas',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index.isEven) {
                  return Divider(height: 1);
                }

                return ListTile(
                  leading: Icon(Icons.description),
                  title: Text(formatDayMonthYearHourMinute(randomMockDate())),
                  trailing: _AnswerPopupMenuButton(),
                );
              },
              childCount: 10 * 2 - 1,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

class _SurveyPopupMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: _SurveyPopupMenuButtonAction.edit,
            child: Row(
              children: const [
                Icon(Icons.edit, color: Colors.black45),
                SizedBox(width: 16),
                Text('Editar'),
              ],
            ),
          ),
          PopupMenuItem(
            value: _SurveyPopupMenuButtonAction.delete,
            child: Row(
              children: const [
                Icon(Icons.delete, color: Colors.black45),
                SizedBox(width: 16),
                Text('Excluir'),
              ],
            ),
          ),
        ];
      },
    );
  }
}

enum _SurveyPopupMenuButtonAction {
  edit,
  delete,
}

class _AnswerPopupMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: _AnswerPopupMenuButtonAction.delete,
            child: Row(
              children: const [
                Icon(Icons.delete),
                SizedBox(width: 16),
                Text('Excluir'),
              ],
            ),
          ),
        ];
      },
    );
  }
}

enum _AnswerPopupMenuButtonAction {
  delete,
}
