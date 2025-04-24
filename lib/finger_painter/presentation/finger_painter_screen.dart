import 'package:flutter/material.dart';

import 'lines_notifier.dart';

class FingerPainterScreen extends StatefulWidget {
  const FingerPainterScreen({super.key});

  @override
  State<FingerPainterScreen> createState() => _FingerPainterScreenState();
}

class _FingerPainterScreenState extends State<FingerPainterScreen> {
  final _linesNotifier = LinesNotifier();
  final _transformNotifier = ValueNotifier<Matrix4>(Matrix4.identity());

  Offset offset = Offset.zero;

  @override
  void dispose() {
    _linesNotifier.dispose();
    _transformNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          offset = details.localPosition;
        },
        onPanUpdate: (details) {
          _transformNotifier.value =
              Matrix4.identity()..translate(details.localPosition.dx - offset.dx, details.localPosition.dy - offset.dy);
        },
        child: LinesNotifierProvider(
          notifier: _linesNotifier,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _transformNotifier,
              builder: (context, _, __) {
                return FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.3,
                  child: Transform(
                    transform: _transformNotifier.value,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black),
                      child: RepaintBoundary(child: const FingerPainterBody()),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FingerPainterBody extends StatelessWidget {
  const FingerPainterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = LinesNotifierProvider.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: notifier.onPanStart,
          onPanUpdate: notifier.onPanUpdate,
          onPanEnd: notifier.onPanEnd,
          child: Stack(
            children: [CustomPaint(size: constraints.biggest, painter: FingerPainterMultiLine(notifier: notifier))],
          ),
        );
      },
    );
  }
}

class FingerPainterMultiLine extends CustomPainter {
  final LinesNotifier notifier;
  const FingerPainterMultiLine({required this.notifier}) : super(repaint: notifier);

  @override
  void paint(Canvas canvas, Size size) {
    final lines = [...notifier.value];
    for (final line in lines) {
      final paint =
          Paint()
            ..style = PaintingStyle.stroke
            ..color = line.color
            ..strokeWidth = line.strokeWidth
            ..strokeCap = StrokeCap.round;

      for (var i = 0; i < line.points.length - 1; i++) {
        canvas.drawLine(line.points[i], line.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant FingerPainterMultiLine oldDelegate) {
    return true;
  }
}
