import 'package:flutter/material.dart';

class CommonGridView<T> extends StatelessWidget {
  final bool isLoading;
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Widget Function(BuildContext context, int index) loadingItemBuilder;
  final Widget noData;

  const CommonGridView({
    super.key,
    required this.isLoading,
    required this.items,
    required this.itemBuilder,
    required this.loadingItemBuilder,
    required this.noData,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemBuilder: loadingItemBuilder,
      );
    }

    if (items.isEmpty) {
      return noData;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return itemBuilder(context, index, items[index]);
      },
    );
  }
}