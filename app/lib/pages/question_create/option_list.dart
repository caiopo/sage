import 'package:flutter/material.dart';
import 'package:sage/utils/collections.dart';

typedef OptionEvent = void Function(OptionAction action);

enum OptionAction {
  up,
  down,
  edit,
  delete,
}

class OptionList extends StatefulWidget {
  final List<String> initialValues;
  final ValueChanged<List<String>> onSaved;

  const OptionList({
    Key key,
    @required this.initialValues,
    @required this.onSaved,
  }) : super(key: key);

  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  List<String> _values;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues.toList();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<void>(
      onSaved: (_) {
        // when the enclosing Form saves
        widget.onSaved(_values);
      },
      validator: (_) {
        if (_values == null || _values.isEmpty) {
          return 'Obrigatório';
        }

        return null;
      },
      builder: (FormFieldState<void> field) {
        return Column(
          children: <Widget>[
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Opções',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            for (final i in _values.indices)
              _OptionItem(
                title: _values[i],
                isFirst: i == 0,
                isLast: i == _values.length - 1,
                onAction: (action) => _handleAction(action, i),
              ),
            if (_values.isEmpty)
              Text(
                'Nenhuma opção adicionada',
                style: TextStyle(
                  color: field.hasError ? Colors.red : null,
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 16),
            OutlineButton.icon(
              focusNode: _focusNode,
              icon: const Icon(Icons.add),
              label: const Text('ADICIONAR OPÇÃO'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _handleAdd(),
            )
          ],
        );
      },
    );
  }

  Future<void> _handleAction(OptionAction action, int index) async {
    final value = _values[index];

    switch (action) {
      case OptionAction.up:
        if (index != 0) {
          _values.removeAt(index);
          _values.insert(index - 1, value);
        }
        break;
      case OptionAction.down:
        if (index != _values.length - 1) {
          _values.removeAt(index);
          _values.insert(index + 1, value);
        }
        break;
      case OptionAction.edit:
        final newValue = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (context) => _AddOptionDialog(initialValue: value),
        );

        if (newValue != null &&
            newValue.isNotEmpty &&
            !_containsValue(newValue)) {
          _values[index] = newValue;
        }
        break;
      case OptionAction.delete:
        _values.removeAt(index);
        break;
    }

    setState(() {});
  }

  Future<void> _handleAdd() async {
    final value = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _AddOptionDialog(),
    );

    _focusNode.requestFocus();

    if (value != null && value.isNotEmpty && !_containsValue(value)) {
      setState(() {
        _values.add(value);
      });
    }
  }

  bool _containsValue(String str) {
    final contains = _values.contains(str);
    if (contains) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('A opção "$str" já existe'),
      ));
    }
    return contains;
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final OptionEvent onAction;
  final bool isFirst;
  final bool isLast;

  const _OptionItem({
    Key key,
    this.title,
    this.onAction,
    this.isFirst,
    this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _OptionPopupButton(onAction: onAction),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () => onAction(OptionAction.up),
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () => onAction(OptionAction.down),
          ),
        ],
      ),
    );
  }
}

class _OptionPopupButton extends StatelessWidget {
  final OptionEvent onAction;

  const _OptionPopupButton({Key key, this.onAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OptionAction>(
      tooltip: 'Opções extras',
      onSelected: onAction,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Editar'),
            ],
          ),
          value: OptionAction.edit,
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Remover'),
            ],
          ),
          value: OptionAction.delete,
        ),
      ],
    );
  }
}

class _AddOptionDialog extends StatefulWidget {
  final String initialValue;

  const _AddOptionDialog({Key key, this.initialValue}) : super(key: key);

  @override
  _AddOptionDialogState createState() => _AddOptionDialogState();
}

class _AddOptionDialogState extends State<_AddOptionDialog> {
  String option;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    option = widget.initialValue ?? '';
    _controller = TextEditingController(text: option);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialValue == null ? 'Nova opção' : 'Editar opção'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Opção',
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          textColor: Colors.red,
          onPressed: () {
            Navigator.pop<String>(context);
          },
        ),
        FlatButton(
          child: Text('ADICIONAR'),
          onPressed: () {
            Navigator.pop<String>(context, _controller.value.text);
          },
        ),
      ],
    );
  }
}
