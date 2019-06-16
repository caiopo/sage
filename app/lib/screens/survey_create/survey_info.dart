import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/identicon.dart';

class SurveyInfo extends HookWidget {
  final ValueNotifier<String> title;

  const SurveyInfo({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final tabController = DefaultTabController.of(context);

      final clearFocus = () {
        FocusScope.of(context).requestFocus(FocusNode());
      };

      tabController.addListener(clearFocus);

      return () => tabController.removeListener(clearFocus);
    }, []);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Identicon(
                title.value,
                size: 64,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      title.value = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Pesquisa de Opinião",
                      labelText: "Title",
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
