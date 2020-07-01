import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sage/data/db.dart';
import 'package:sage/pages/home/survey_tile.dart';
import 'package:sage/router/router.dart';
import 'package:sage/utils/hooks.dart';
import 'package:sage/viewmodels/home_viewmodel.dart';
import 'package:sage/widgets/sage_wordmark.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel<HomeViewModel>();

    useEffect(() {
      viewModel.init();
      return null;
    }, const []);

    final surveys = useStream(viewModel.surveys);

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
      body: _buildBody(surveys),
    );
  }

  Widget _buildBody(AsyncSnapshot<List<Survey>> surveys) {
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
        if (surveys.hasData && surveys.data.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SurveyTile(
                  survey: surveys.data[index],
                );
              },
              childCount: surveys.data.length,
            ),
          )
        else
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/ginger-cat/page-not-found.png'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Crie seu primeiro questionário no botão abaixo',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 80), // Compensate for FAB
                ],
              ),
            ),
          )
      ],
    );
  }
}
