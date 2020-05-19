import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

typedef KeyExtractor<T> = String Function(T item);

class DraggableItem extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;

  DraggableItem({
    @required Key key,
    @required this.child,
    @required this.isFirst,
    @required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: key,
      childBuilder: _buildChild,
    );
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        border: Border(
          top: isFirst && !placeholder
              ? Divider.createBorderSide(context)
              : BorderSide.none,
          bottom: isLast && placeholder
              ? BorderSide.none //
              : Divider.createBorderSide(context),
        ),
        color: placeholder ? null : Colors.white,
      );
    }

    return Container(
      decoration: decoration,
      child: Opacity(
        opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
        child: child,
      ),
    );
  }
}

class DraggableHandle extends StatelessWidget {
  const DraggableHandle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Reordenar',
      child: ReorderableListener(
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pressione e arraste para reordenar'),
              ),
            );
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: const ShapeDecoration(
              color: Color(0x0B000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Center(
              child: Icon(Icons.reorder, color: Color(0xFF888888)),
            ),
          ),
        ),
      ),
    );
  }
}
