import 'package:flutter/widgets.dart';
import 'package:sage/di/di.dart';
import 'package:sage/viewmodels/viewmodel.dart';

mixin ViewModelState<VM extends ViewModel, W extends StatefulWidget>
    on State<W> {
  VM viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = inject<VM>();
    viewmodel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }
}
