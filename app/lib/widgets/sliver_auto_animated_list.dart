import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:list_diff/list_diff.dart';
import 'package:sage/widgets/slide_in_animation.dart';

enum AnimationMode {
  // animates only when [[items]] length changes
  addRemove,

  // animates all changes (doesn't work with reorderable lists)
  all,
}

typedef KeyExtractor<T> = String Function(T item);

typedef ItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
);

typedef AnimationBuilder = Widget Function(
  BuildContext context,
  Widget child,
  Animation<double> animation,
);

class SliverAutoAnimatedList<T> extends StatefulWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final KeyExtractor<T> keyExtractor;
  final AnimationMode mode;

  const SliverAutoAnimatedList({
    Key key,
    @required this.items,
    @required this.keyExtractor,
    @required this.itemBuilder,
    this.mode = AnimationMode.addRemove,
  }) : super(key: key);

  @override
  _SliverAutoAnimatedListState<T> createState() =>
      _SliverAutoAnimatedListState<T>();
}

class _SliverAutoAnimatedListState<T> extends State<SliverAutoAnimatedList<T>> {
  final _animatedListKey = GlobalKey<SliverAnimatedListState>();

  List<T> _items;

  @override
  void didUpdateWidget(SliverAutoAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newItems = widget.items.toList(growable: false);
    if (_items != null) {
      _updateData(_items, widget.items);
    }
    _items = newItems;
  }

  void _updateData(List<T> from, List<T> to) {
    if (widget.mode == AnimationMode.addRemove && from.length == to.length) {
      return;
    }

    final operations = diffSync<T>(
      from,
      to,
      areEqual: _areEqual,
    );

    final listState = _animatedListKey.currentState;

    for (final op in operations) {
      switch (op.type) {
        case OperationType.insertion:
          listState?.insertItem(op.index);
          break;
        case OperationType.deletion:
          listState?.removeItem(
            op.index,
            (context, animation) =>
                _buildAnimation(context, op.item, animation),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: _animatedListKey,
      itemBuilder: _buildItem,
      initialItemCount: widget.items.length,
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return _buildAnimation(context, widget.items[index], animation);
  }

  Widget _buildAnimation(
    BuildContext context,
    T item,
    Animation<double> animation,
  ) {
    final child = widget.itemBuilder(context, item);

    return SlideInTransition(
      animation: animation,
      child: child,
    );
  }

  bool _areEqual(T a, T b) => widget.keyExtractor(a) == widget.keyExtractor(b);
}
