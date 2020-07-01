import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sage/di/di.dart';
import 'package:sage/viewmodels/viewmodel.dart';

typedef Initializer<VM extends ViewModel> = void Function(VM viewModel);

VM useViewModel<VM extends ViewModel>([Initializer<VM> initializer]) {
  return Hook.use(
    _ViewModelHook<VM>(initializer: initializer),
  );
}

class _ViewModelHook<VM extends ViewModel> extends Hook<VM> {
  final Initializer<VM> initializer;

  const _ViewModelHook({
    this.initializer,
  });

  @override
  _ViewModelHookState<VM> createState() => _ViewModelHookState<VM>();
}

class _ViewModelHookState<VM extends ViewModel>
    extends HookState<VM, _ViewModelHook<VM>> {
  VM viewModel;

  @override
  void initHook() {
    super.initHook();
    viewModel = inject<VM>();
    hook.initializer?.call(viewModel);
    viewModel.addListener(_listener);
  }

  @override
  void dispose() {
    viewModel.removeListener(_listener);
    viewModel.dispose();
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  VM build(BuildContext context) {
    return viewModel;
  }
}
