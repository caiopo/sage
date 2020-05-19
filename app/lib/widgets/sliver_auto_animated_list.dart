import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:list_diff/list_diff.dart';

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

  const SliverAutoAnimatedList({
    Key key,
    @required this.items,
    @required this.keyExtractor,
    @required this.itemBuilder,
  }) : super(key: key);

  @override
  _SliverAutoAnimatedListState<T> createState() =>
      _SliverAutoAnimatedListState<T>();
}

class _SliverAutoAnimatedListState<T> extends State<SliverAutoAnimatedList<T>> {
  final _animatedListKey = GlobalKey<SliverAnimatedListState>();

  List<T> _dataFromWidget;
  List<T> _dataForBuild = [];

  @override
  void didUpdateWidget(SliverAutoAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_dataFromWidget != widget.items) {
      _dataFromWidget = widget.items;
      _updateData(List.from(_dataForBuild), List.from(_dataFromWidget));
    }
  }

  Future<void> _updateData(List<T> from, List<T> to) async {
    final operations = await diff(from, to);
    if (!listEquals(_dataFromWidget, to) || !listEquals(_dataForBuild, from)) {
      // While we were calculating the operations, another update got in and is
      // currently being calculated based off the old version, so it doesn't
      // really make sense to execute what we calculated right here. The new
      // calculation will take care of the changes.
      return;
    }
    setState(() {
      final listState = _animatedListKey.currentState;
      for (final op in operations) {
        op.applyTo(_dataForBuild);
        if (op.isInsertion) {
          listState?.insertItem(op.index);
        } else if (op.isDeletion) {
          listState?.removeItem(op.index, (context, animation) {
            return _buildAnimation(context, op.item, animation);
          });
        }
      }
    });
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

    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1,
      child: SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1.5, 0.0),
          end: Offset.zero,
        )),
        child: child,
      ),
    );
  }

  bool _areEqual(T a, T b) => widget.keyExtractor(a) == widget.keyExtractor(b);
}
