import 'dart:async';

import 'package:flutter/material.dart';

class SpinKitRipple extends StatefulWidget {
  final List<Color> color;
  final double size;

  const SpinKitRipple({
    Key key,
    @required this.color,
    this.size = 80.0,
  }) : super(key: key);

  @override
  _SpinKitRippleState createState() => new _SpinKitRippleState();
}

class _SpinKitRippleState extends State<SpinKitRipple>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1, _animation2;
  Timer timer;
  int initialIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000))
      ..repeat();

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.75, curve: Curves.linear),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 1.0, curve: Curves.linear),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      setState(() {
        if (initialIndex == widget.color.length - 1) {
          initialIndex = 0;
        } else {
          initialIndex++;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 1.0 - _animation1.value,
            child: new Transform.scale(
              scale: _animation1.value,
              child: new Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: widget.color[initialIndex], width: 10.0),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 1.0 - _animation1.value,
            child: new Transform.scale(
              scale: _animation2.value,
              child: new Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: widget.color[initialIndex], width: 10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
