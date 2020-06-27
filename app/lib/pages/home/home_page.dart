import 'package:flutter/material.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/home/survey_tile.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/viewmodels.dart';
import 'package:sage/viewmodels/home_viewmodel.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with ViewModelState<HomeViewModel, HomePage> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SageWordmark(size: 26),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Configurações',
            onPressed: () {
              navigator(context).pushSync();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('NOVO QUESTIONÁRIO'),
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
              child: Text(
                'Meus questionários',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
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
