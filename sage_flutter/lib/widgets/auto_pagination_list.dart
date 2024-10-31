import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PageLoader<T> = Future<(List<T>, bool)> Function(int pageKey);

class AutoPaginationList<T> extends HookWidget {
  const AutoPaginationList({
    super.key,
    required this.itemBuilder,
    required this.pageLoader,
  });

  final ItemWidgetBuilder<T> itemBuilder;
  final PageLoader<T> pageLoader;

  @override
  Widget build(BuildContext context) {
    final controllerRef = useRef<PagingController<int, T>?>(null);

    useEffect(() {
      final controller = PagingController<int, T>(
        firstPageKey: 0,
      );

      controller.addPageRequestListener((pageKey) async {
        try {
          final (items, finished) = await pageLoader(pageKey);
          if (finished) {
            controller.appendLastPage(items);
          } else {
            controller.appendPage(items, pageKey + 1);
          }
        } on Exception catch (e) {
          controller.error = e;
        }
      });

      controllerRef.value = controller;

      return () => controller.dispose();
    });

    return PagedListView(
      pagingController: controllerRef.value!,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: itemBuilder,
      ),
    );
  }
}
