// ignore_for_file: use_build_context_synchronously

library keep_visible;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'debouncer.dart';

/// A widget that ensures it is always visible when keyboard is shown.
class KeepVisible extends StatefulWidget {
  const KeepVisible({
    Key? key,
    required this.child,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  /// The child widget that we are wrapping
  final Widget child;

  /// The curve we will use to scroll ourselves into view.
  ///
  /// Defaults to Curves.ease.
  final Curve curve;

  /// The duration we will use to scroll ourselves into view
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  @override
  KeepVisibleState createState() => KeepVisibleState();
}

class KeepVisibleState extends State<KeepVisible> with WidgetsBindingObserver {
  // bool get hasAnyFocus => widget.focusNodeList
  //     .map((focusNode) => focusNode.hasFocus)
  //     .reduce((a, b) => a || b);

  final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
  double lastKeyboardSize = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    debouncer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardSize = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio,
    ).bottom;
    final isKeyboardSizeBigger = keyboardSize > lastKeyboardSize;
    lastKeyboardSize = keyboardSize;
    if (isKeyboardSizeBigger) debouncer(_ensureVisible);

    super.didChangeMetrics();
  }

  Future<void> _ensureVisible() async {
    final RenderObject object = context.findRenderObject()!;
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object)!;

    ScrollableState? scrollableState = Scrollable.of(context);
    assert(
      scrollableState != null,
      '[$KeepVisibleState] To use this widget it need to have a Scrollable as ancestor in the widget tree.',
    );

    ScrollPosition position = scrollableState!.position;
    double alignment;
    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
      // Move down to the top of the viewport
      alignment = 0.0;
    } else if (position.pixels <
        viewport.getOffsetToReveal(object, 1.0).offset) {
      // Move up to the bottom of the viewport
      alignment = 1.0;
    } else {
      // No scrolling is necessary to reveal the child
      return;
    }
    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
