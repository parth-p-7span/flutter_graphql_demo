import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class SortableListItem extends StatefulWidget {
  final bool isIconVisible;
  final Widget? child;
  final ReorderableItemState? state;
  final ValueKey childKey;

  const SortableListItem(
      {Key? key,
      required this.isIconVisible,
      this.child,
      this.state,
      required this.childKey})
      : assert(childKey != null),
        super(key: key);

  @override
  _SortableListItemState createState() => _SortableListItemState();
}

class _SortableListItemState extends State<SortableListItem> {
  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: widget.childKey,
        childBuilder: (BuildContext contet, ReorderableItemState state) {
          return Opacity(
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: widget.child,
                    ),
                  ),
                  widget.isIconVisible
                      ? SizedBox(
                          width: 4,
                        )
                      : Container(),
                  widget.isIconVisible
                      ? ReorderableListener(
                          child: Opacity(
                            opacity:
                                widget.state == ReorderableItemState.placeholder
                                    ? 0.0
                                    : 1.0,
                            child: Center(
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  bottom: 6,
                                  left: 6,
                                  right: 6,
                                ),
                                child: Icon(
                                  Icons.drag_indicator_sharp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}
