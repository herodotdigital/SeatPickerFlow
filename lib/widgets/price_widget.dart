import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_picker_flow/pager_notifier.dart';
import 'package:seat_picker_flow/theme.dart';

class PriceWidget extends StatefulWidget {
  final List<Text> children = [
    Text('\$125', style: priceTextStyle),
    Text('\$150', style: priceTextStyle),
    Text('\$175', style: priceTextStyle),
    Text('\$200', style: priceTextStyle),
    Text('\$225', style: priceTextStyle),
    Text('\$250', style: priceTextStyle),
    Text('\$275', style: priceTextStyle),
    Text('\$300', style: priceTextStyle.copyWith(color: Colors.red))
  ];


  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> with TickerProviderStateMixin {
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
                  child: widget.children[Provider.of<PagerNotifier>(context).position],
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
