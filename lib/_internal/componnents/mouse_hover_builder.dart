import 'package:flutter/material.dart';

typedef HoverBuilder = Widget Function(BuildContext context, bool isHovering);

class MouseHoverBuilder extends StatefulWidget {
  final bool isClickable;

  const MouseHoverBuilder({Key? key, required this.builder, this.isClickable = false}) : super(key: key);

  final HoverBuilder builder;

  @override
  // ignore: library_private_types_in_public_api
  _MouseHoverBuilderState createState() => _MouseHoverBuilderState();
}

class _MouseHoverBuilderState extends State<MouseHoverBuilder> {
  bool isOver = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isClickable? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (p) => setOver(true),
      onExit: (p) => setOver(false),
      child: widget.builder(context, isOver),
    );
  }

  void setOver(bool value) => setState(() => isOver = value);
}
