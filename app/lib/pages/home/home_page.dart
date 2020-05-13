import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/home/survey_tile.dart';
import 'package:sage/router/router.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    print(media.size);

    return Scaffold(
      appBar: AppBar(
        title: SageWordmark(size: 26),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Configurações',
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Criar questionário',
        onPressed: () {
          navigator(context).pushSurveyCreate();
        },
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Questionários',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      OutlineButton.icon(
                        icon: Icon(Icons.sync),
                        label: Text('SINCRONIZAR'),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          navigator(context).pushSync();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return SurveyTile(
              survey: Survey(
                title:
                    'Lorem Ipsum Dolor Sit Amet Lorem Ipsum Dolor Sit Amet Lorem Ipsum Dolor Sit Amet $index',
                owner: 'aaa',
                uploadedAnswers: index,
                uuid: 'aa',
              ),
            );
          }),
        ),
      ],
    );
  }
}
