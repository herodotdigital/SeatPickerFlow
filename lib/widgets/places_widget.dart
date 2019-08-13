import 'package:flutter/material.dart';
import 'dart:math';
import 'package:seat_picker_flow/theme.dart';
import '../place_controller.dart';

class PlacesWidget extends StatefulWidget {
  final PlaceController controller;

  final List<Widget> children;

  const PlacesWidget({
    @required this.children,
    this.controller,
  });

  @override
  _PlacesWidgetState createState() => _PlacesWidgetState();
}

class _PlacesWidgetState extends State<PlacesWidget> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.controller.value);
    widget.controller.addListener(() {
      destPage = widget.controller.value;
      _controller.animateToPage(widget.controller.value,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  int destPage = -1;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: widget.children,
      onPageChanged: (page) {
        if (destPage != -1 && page == destPage) {
          destPage = -1;
        } else if (destPage == -1) {
          widget.controller.value = page;
          destPage = -1;
        }
      },
    );
  }
}


class ZonePlacesWidget extends StatelessWidget {
  final int placesCount;

  ZonePlacesWidget(this.placesCount);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
          crossAxisSpacing: 8,
          crossAxisCount: 9,
          children: mockZones(),
        ),
        Positioned(
          bottom: 0,
          width: 1000,
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white,
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }

  int next(int min, int max) => min + Random().nextInt(max - min);

  List<Widget> mockZones() {
    final startSelect = next(0, placesCount - 9);

    List<Widget> mockContent = List<Widget>();
    for (int i = 0; i < placesCount; i++) {
      if (i == startSelect)
        mockContent.add(PlaceItem(startSelected: true));
      else if (i == startSelect + 9)
        mockContent.add(PlaceItem(endSelected: true));
      else
        mockContent.add(PlaceItem());
    }
    return mockContent;
  }
}


class PlaceItem extends StatefulWidget {
  final startSelected;
  final endSelected;
  final middleSelected;

  const PlaceItem({
    Key key,
    this.startSelected = false,
    this.endSelected = false,
    this.middleSelected = false,
  }) : super(key: key);

  @override
  _PlaceItemState createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(20));
    if (widget.startSelected) {
      radius = BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20));
    } else if (widget.middleSelected) {
      radius = BorderRadius.zero;
    } else if (widget.endSelected) {
      radius = BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20));
    }

    EdgeInsets padding = EdgeInsets.all(4.0);
    if (widget.startSelected) {
      padding = padding.copyWith(right: 0);
    } else if (widget.middleSelected) {
      padding = padding.copyWith(right: 0, left: 0);
    } else if (widget.endSelected) {
      padding = padding.copyWith(left: 0);
    }

    return Padding(
      padding: padding,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          color: (widget.startSelected ||
                  widget.middleSelected ||
                  widget.endSelected)
              ? primaryColor
              : cardBackground,
          child: Center(
            child: Text('I', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
