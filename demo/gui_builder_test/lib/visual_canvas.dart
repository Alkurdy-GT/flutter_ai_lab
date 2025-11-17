import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:gui_builder_test/ai_designer.dart';

@Preview(name: 'Visual Canvas')
Widget visualCanvas() => const VisualCanvas();

class VisualCanvas extends StatefulWidget {
  const VisualCanvas({super.key});

  @override
  State<VisualCanvas> createState() => _VisualCanvasState();
}

class _VisualCanvasState extends State<VisualCanvas> {
  Offset position = const Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: const _Box(),
              childWhenDragging: const SizedBox.shrink(),
              onDragEnd: (details) {
                setState(() => position = details.offset);
              },
              child: const _Box(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Drag Me',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

@Preview(name: 'AiI Designer')
Widget aiDesignerPreview() => const AiDesigner();
