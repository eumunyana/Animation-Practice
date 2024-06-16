import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Flutter Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedWidgetExample(),
    );
  }
}

class AnimatedWidgetExample extends StatefulWidget {
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationSize;
  late Animation<double> _animationRotation;
  late Animation<Color?> _animationColor;
  late Animation<Offset> _animationPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animationSize = Tween<double>(begin: 50, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animationRotation =
        Tween<double>(begin: 0, end: 2 * 3.141592653589793).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animationColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animationPosition =
        Tween<Offset>(begin: Offset.zero, end: Offset(1, 1)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _animationPosition.value *
                  MediaQuery.of(context).size.width /
                  2,
              child: Transform.rotate(
                angle: _animationRotation.value,
                child: Container(
                  width: _animationSize.value,
                  height: _animationSize.value,
                  color: _animationColor.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
