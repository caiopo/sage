import 'package:flutter/widgets.dart';
import 'package:sage/di/di.dart';
import 'package:sage/viewmodels/viewmodel.dart';

mixin ViewModelState<VM extends ViewModel, W extends StatefulWidget>
    on State<W> {
  VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = inject<VM>();
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
