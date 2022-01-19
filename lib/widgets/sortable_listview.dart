import 'package:flutter/material.dart';
import 'package:flutter_graphql/widgets/sortable_list_item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart'
    as listOrder;

typedef OnSortableItemBuilder = Widget Function(
    BuildContext context, int index);

typedef OnReOrder = bool Function(Key draggedIndex, Key newIndex);
typedef OnReOrderDone = void Function(Key draggedIndex);
typedef IsReOrderable = bool Function(int index);
typedef OnValueKeyGenerate = ValueKey Function(int index);

class SortableListView extends StatelessWidget {
  final OnSortableItemBuilder onSortableItemBuilder;
  final OnReOrder onReOrder;
  final OnReOrderDone onReOrderDone;
  final int itemCount;
  final IsReOrderable isReOrderable;
  final OnValueKeyGenerate onValueKeyGenerate;
  final bool isIconVisible;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const SortableListView({
    Key? key,
    required this.onSortableItemBuilder,
    required this.onReOrder,
    required this.onReOrderDone,
    required this.itemCount,
    required this.isReOrderable,
    required this.onValueKeyGenerate,
    this.padding,
    this.isIconVisible = false,
    this.physics,
    this.shrinkWrap = false,
  })  : assert(onSortableItemBuilder != null),
        assert(onReOrder != null),
        assert(onReOrderDone != null),
        assert(itemCount != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return listOrder.OldReorderableList(
      child: CustomScrollView(
        physics: physics,
        shrinkWrap: shrinkWrap,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                final widget = onSortableItemBuilder.call(context, index);
                final isReorderable = isReOrderable.call(index) ?? false;
                if (!isReorderable) return widget;
                return SortableListItem(
                  child: widget,
                  isIconVisible: isIconVisible,
                  childKey: onValueKeyGenerate.call(index),
                );
              },
            ),
          ),
        ],
      ),
      onReorder: (Key draggedItem, Key newPosition) {
        return onReOrder(draggedItem, newPosition);
      },
      onReorderDone: (Key draggedItem) {
        return onReOrderDone(draggedItem);
      },
      decoratePlaceholder: (Widget item, double opacity) {
        return listOrder.DecoratedPlaceholder(widget: item, offset: 0);
      },
    );
  }
}
