import 'package:flutter/material.dart';
import 'package:seat_picker_flow/pager_notifier.dart';
import 'dart:math';
import 'package:seat_picker_flow/theme.dart';
import 'package:provider/provider.dart';

class PlacesWidget extends StatefulWidget {

  @override
  _PlacesWidgetState createState() => _PlacesWidgetState();
}

class _PlacesWidgetState extends State<PlacesWidget> {
  int destPage = -1;
  PageController _controller = PageController(initialPage: 0);

  List<Widget> mockZones() {
    return [
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
      ZonePlacesWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PagerNotifier>(context).addListener(() {
      destPage = Provider.of<PagerNotifier>(context).position;
      _controller.animateToPage(destPage,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
    return PageView(
      controller: _controller,
      children: mockZones(),
      onPageChanged: (page) {
        if (destPage != -1 && page == destPage) {
          destPage = -1;
        } else if (destPage == -1) {
          Provider.of<PagerNotifier>(context).setupOnPosition(page);
          destPage = -1;
        }
      },
    );
  }
}

class ZonePlacesWidget extends StatelessWidget {
  final int placesCount = 100;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GridView.count(
            childAspectRatio: 1,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
            crossAxisCount: 10,
            children: mockZones(),
          ),
        ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
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
    final startSelect = next(0, placesCount);
    List<Widget> mockContent = List<Widget>();
    for (int i = 0; i < placesCount; i++) {
      if (i == startSelect)
        mockContent.add(PlaceItem(startSelected: true));
      else if (i == startSelect + 1)
        mockContent.add(PlaceItem(endSelected: true));
      else
        mockContent.add(PlaceItem());
    }
    return mockContent;
  }
}

class PlaceItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(20));
    if (startSelected) {
      radius = BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20));
    } else if (middleSelected) {
      radius = BorderRadius.zero;
    } else if (endSelected) {
      radius = BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20));
    }

    EdgeInsets padding = EdgeInsets.all(4.0);
    if (startSelected) {
      padding = padding.copyWith(right: 0);
    } else if (middleSelected) {
      padding = padding.copyWith(right: 0, left: 0);
    } else if (endSelected) {
      padding = padding.copyWith(left: 0);
    }

    return Padding(
      padding: padding,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          color: (startSelected || middleSelected || endSelected)
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
