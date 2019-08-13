import 'package:flutter/material.dart';
import 'package:seat_picker_flow/theme.dart';
import '../place_controller.dart';

class PriceWidget extends StatefulWidget {
  final PlaceController controller;
  final List<Text> children;

  const PriceWidget({
    this.children,
    this.controller,
  });

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _slideIn;
  Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    animateIn();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('2x student tickets', style: additionalTextStyle),
          Row(
            children: <Widget>[
              Text(
                'Total',
                style: primaryTextStyle.copyWith(fontSize: 24),
              ),
              SizedBox(width: 30),
              SlideTransition(
                position: _slideIn,
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: widget.children[widget.controller.value],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void animateIn() {
    _animationController.reset();
    _slideIn = Tween<Offset>(
      begin: Offset(0.0, 0.4),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _fadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
