

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


class Animated_Window extends StatefulWidget {
  //Window's height
  double height;

  //Window's width
  double width;

  //Window's color
  Color? color;

  //Color of window's border
  Color borderColor;

  //Width of window's border
  double borderWidth;

  //Radius of window's border
  BorderRadius borderRadius;

  //Window's content
  Widget child;

  //Duration of animated opening and closing
  Duration animationDuration;


  //Is animation reverse (False=open, true=close)
  bool isReverse;


  //Window's position within scaffold
  Alignment alignment;

  //If true, animation type is scaling. Else, it is sizing.
  bool scale;


  Animated_Window({
    required this.height,
    required this.width,
    required this.color,
    this.borderWidth=0,
    this.borderColor=Colors.transparent,
    this.borderRadius=BorderRadius.zero,
    required this.child,
    this.animationDuration=const Duration(seconds: 1),
    this.isReverse=false,
    this.alignment=const Alignment(0,0),
    this.scale=false
  });

  @override
  _Animated_WindowState createState() => _Animated_WindowState();

}

class _Animated_WindowState extends State<Animated_Window> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //Using isReverse to set open/close
    if(widget.isReverse==false)
      _controller.forward();
    else
      _controller.reverse();

    //Using scale property to set scaling/sizing
    if(widget.scale==false)
      return Align(alignment:Alignment(0,0),child:size());
    else
      return Align(alignment:widget.alignment,child: scale());
  }


  late final AnimationController _controller = AnimationController(
    duration: widget.animationDuration,
    vsync: this,
  );


  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  Widget size(){
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      axisAlignment: 0,
      //Using alignment property to control position
      child:  Align(alignment:widget.alignment,child:Reset_Window()),
    );
  }


  Widget scale(){
    return ScaleTransition(
      scale: _animation,
      child: Reset_Window(),
      //Using alignment property to control position
      alignment: widget.alignment,
    );
  }


  Widget Reset_Window(){
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
            color: widget.color,
            shape: BoxShape.rectangle,
            borderRadius: widget.borderRadius
        ),
        child: widget.child
    );
  }


}
