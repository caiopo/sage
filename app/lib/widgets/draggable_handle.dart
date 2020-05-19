import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class DraggableHandle extends StatelessWidget {
  const DraggableHandle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Reordenar',
      child: ReorderableListener(
        child: GestureDetector(
          onTap: () {
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
