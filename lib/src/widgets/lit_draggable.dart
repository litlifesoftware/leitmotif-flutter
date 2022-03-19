import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A draggable container that stretches across the whole screen.
///
/// It wrappes the [child] widget and therefore making its position adjustable
/// by the user by dragging it across the screen.
///
/// To avoid the [child] to be dragged outside the boundaries provided by the
/// screen, the [child] will only be dragged if it has been dragged on the
/// viewable area.
class LitDraggable extends StatefulWidget {
  final Widget child;
  final Offset initialDragOffset;
  final EdgeInsets padding;
  final Duration animationDuration;

  /// Creates a [LitDraggable].
  ///
  /// Provide a custom [padding] to constrain the draggable area.
  const LitDraggable({
    Key? key,
    required this.child,
    this.initialDragOffset = const Offset(8.0, 16.0),
    this.padding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 48.0,
    ),
    this.animationDuration = const Duration(milliseconds: 120),
  }) : super(key: key);
  @override
  _LitDraggableState createState() => _LitDraggableState();
}

class _LitDraggableState extends State<LitDraggable>
    with TickerProviderStateMixin {
  late AnimationController _dragAnimationController;

  /// The latest `dx` drag offset.
  late double _draggedDx;

  /// The latest `dy` drag offset.
  late double _draggedDy;

  /// Sets the [_draggedDx] and [_draggedDy] while animating the drag action.
  void _setDraggedOffset(double dx, double dy) {
    _dragAnimationController
        .reverse()
        .then((value) => _dragAnimationController.forward());
    setState(() {
      _draggedDx = dx;
      _draggedDy = dy;
    });
  }

  /// Handles the `onDragEnd` event and validates the provided drag [details].
  void _onDragEnd(DraggableDetails details) {
    final double adjustedHeight = MediaQuery.of(context).size.height -
        oldSize!.height -
        widget.padding.bottom -
        widget.padding.top;

    final double adjustedWidth = MediaQuery.of(context).size.width -
        oldSize!.width -
        widget.padding.left -
        widget.padding.right;

    // If dragged inside viewable screen area
    if (details.offset.dx > 0 && details.offset.dy > 0) {
      // If the drag occured inside the constrains
      if (details.offset.dx < adjustedWidth &&
          details.offset.dy < adjustedHeight) {
        _setDraggedOffset(details.offset.dx, details.offset.dy);

        /// Otherwise use the max constraints available.
      } else {
        if (details.offset.dx > adjustedWidth &&
            details.offset.dy > adjustedHeight) {
          _setDraggedOffset(adjustedWidth, adjustedHeight);
        }

        /// If only the `dy` position is valid
        if (details.offset.dx > adjustedWidth &&
            details.offset.dy < adjustedHeight) {
          _setDraggedOffset(adjustedWidth, details.offset.dy);
        }

        // If only the `dx` position is valid
        if (details.offset.dx < adjustedWidth &&
            details.offset.dy > adjustedHeight) {
          _setDraggedOffset(details.offset.dx, adjustedHeight);
        }
      }
      // Else it's outside the viewable area.
    } else {
      // Use the min constrains available.
      if (details.offset.dx < 0 && details.offset.dy < 0) {
        _setDraggedOffset(widget.padding.left, widget.padding.top);
      }

      if (details.offset.dx < 0 && details.offset.dy > 0) {
        if (details.offset.dy < adjustedHeight) {
          // Use the min `dx` and provided drag's `dy`.
          _setDraggedOffset(widget.padding.left, details.offset.dy);
        } else {
          // Use the min `dx` and max `dy` values available.
          _setDraggedOffset(widget.padding.left, adjustedHeight);
        }
      }

      if (details.offset.dx > 0 && details.offset.dy < 0) {
        if (details.offset.dx > adjustedWidth) {
          // Use the max `dx` and min `dy` available..
          _setDraggedOffset(adjustedWidth, widget.padding.top);
        } else {
          // Use the provided drag's `dx` and minimum `dy` value available.
          _setDraggedOffset(details.offset.dx, widget.padding.top);
        }
      }
    }
  }

  /// The container's key providing context on state.
  GlobalKey<State<StatefulWidget>> widgetKey = GlobalKey();

  /// The [widget.child]'s size.
  Size? oldSize = Size(0.0, 0.0);

  /// Sets the [oldSize] value on widget build.
  void _setSize(_) {
    BuildContext? context = widgetKey.currentContext;
    if (context == null) return;

    Size? newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
  }

  @override
  void initState() {
    super.initState();
    _draggedDx = widget.initialDragOffset.dx;
    _draggedDy = widget.initialDragOffset.dy;
    _dragAnimationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _dragAnimationController.forward();
  }

  @override
  void dispose() {
    _dragAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(_setSize);
    return Container(
      key: widgetKey,
      child: AnimatedBuilder(
        animation: _dragAnimationController,
        builder: (context, _) {
          return Positioned(
            left: _draggedDx,
            top: _draggedDy,
            // child: Draggable(
            //     feedback: FloatingActionButton(
            //         child: Icon(Icons.drag_handle), onPressed: () {}),
            //     child: FloatingActionButton(
            //         child: Icon(Icons.drag_handle), onPressed: () {}),
            //     childWhenDragging: Container(),
            //     onDragEnd: _onButtonDragEnd),

            child: Draggable(
              feedback: _Feedback(child: widget.child),
              child: widget.child,
              childWhenDragging: SizedBox(),
              onDragEnd: _onDragEnd,
            ),
          );
        },
      ),
    );
  }
}

class _Feedback extends StatefulWidget {
  final Widget child;
  const _Feedback({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  __FeedbackState createState() => __FeedbackState();
}

class __FeedbackState extends State<_Feedback> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 140), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        child: Opacity(
          opacity: 0.5,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Transform.scale(
                scale: 0.5 + (_animationController.value * 0.5),
                child: widget.child,
              );
            },
          ),
        ),
      ),
    );
  }
}
