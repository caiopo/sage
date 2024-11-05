import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      waitDuration: const Duration(seconds: 2),
      message: 'Press and drag to reorder questions',
      child: ReorderableDragStartListener(
        index: index,
        child: Container(
          height: 32,
          width: 32,
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
    );
  }
}
