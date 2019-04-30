import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/components/presentational/identicon.dart';
import 'package:gaia/utils/hooks/misc.dart';

class SurveyCreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useTheme();
    final title = useState('');

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Creating new survey'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'General info',
                  style: theme.textTheme.title,
                ),
              ),
              TitleInput(
                title: title.value,
                onChange: (String newTitle) {
                  title.value = newTitle;
                },
              ),
              Divider(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Questions',
                  style: theme.textTheme.title,
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return showDialog<bool>(
          context: context,
          builder: (context) => DiscardDialog(),
        ).then((b) => b ?? false);
      },
    );
  }
}

class DiscardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Discard Changes?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('If you go back now, your draft will be discarded.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'DISCARD',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: Text(
            'STAY',
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}

class TitleInput extends StatelessWidget {
  final String title;
  final void Function(String newTitle) onChange;

  const TitleInput({Key key, this.title, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Identicon(
          title,
          size: 64,
        ),
        SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextField(
              onChanged: onChange,
              decoration: InputDecoration(
                hintText: "Pesquisa de Opinião",
                labelText: "Title",
              ),
              style:
                  Theme.of(context).textTheme.subhead.copyWith(fontSize: 18),
              autofocus: true,
            ),
          ),
        ),
      ],
    );
  }
}
