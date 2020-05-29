import 'package:flutter/widgets.dart';
import 'package:sage/di/di.dart';
import 'package:sage/viewmodels/viewmodel.dart';

mixin ViewModelState<VM extends ViewModel, W extends StatefulWidget>
    on State<W> {
  VM _viewModel;

  VM get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = inject<VM>();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
