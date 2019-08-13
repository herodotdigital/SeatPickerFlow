import 'package:flutter/material.dart';
import 'package:seat_picker_flow/theme.dart';
import 'package:seat_picker_flow/animations/fade_route_builder.dart';
import 'package:seat_picker_flow/screens/details_screen.dart';
import 'package:seat_picker_flow/widgets/info_widget.dart';
import 'package:seat_picker_flow/widgets/sector_widget.dart';
import 'package:seat_picker_flow/widgets/places_widget.dart';
import 'package:seat_picker_flow/widgets/price_widget.dart';
import 'package:rect_getter/rect_getter.dart';

import '../place_controller.dart';

class MainPickerScreen extends StatefulWidget {
  @override
  _MainPickerScreenState createState() => _MainPickerScreenState();
}

class _MainPickerScreenState extends State<MainPickerScreen>
    with TickerProviderStateMixin {
  final DataModel data = DataModel();
  final PlaceController _controller = PlaceController();
  AnimationController controller;
  AnimationController toolbarController;
  Animation<Offset> _topOffset;
  Animation<double> _toolbarOpacity;

  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    toolbarController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _topOffset = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero).animate(controller);
    _toolbarOpacity = Tween<double>(begin: 0.0, end: 1).animate(toolbarController);
    controller.forward();
    toolbarController.forward();
  }

  @override
  Widget build(BuildContext context) => Stack(children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: primaryColor,
                  size: 30,
                ),
                onPressed: () {}),
            title: FadeTransition(
                opacity: _toolbarOpacity,
                child: Text('Pick your seats', style: titleTextStyle)),
          ),
          body: Column(
            children: [
              SlideTransition(
                position: _topOffset,
                child: Column(
                  children: <Widget>[
                    InfoWidget(),
                    SectorChooserWidget(
                      controller: _controller,
                      children: data.sectors,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PlacesWidget(
                  controller: _controller,
                  children: data.places,
                ),
              ),
              PriceWidget(
                controller: _controller,
                children: data.ticketPrice,
              ),
            ],
          ),
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child: FloatingActionButton(
              onPressed: () {
                setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide);
                  });
                  Future.delayed(
                    animationDuration + delay,
                    _goToNextPage,
                  );
                });
              },
              backgroundColor: primaryColor,
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ),
        _ripple()
      ]);

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: DetailsScreen()))
        .then((_) => setState(() => rect = null));
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
      ),
    );
  }
}

class DataModel {
  List<Text> sectors = [
    Text('D', style: sectorTextStyle),
    Text('E', style: sectorTextStyle),
    Text('F', style: sectorTextStyle),
    Text('G', style: sectorTextStyle),
    Text('H', style: sectorTextStyle),
    Text('I', style: sectorTextStyle),
    Text('C', style: sectorTextStyle),
    Text('J', style: sectorTextStyle),
  ];

  List<Widget> places = [
    ZonePlacesWidget(84),
    ZonePlacesWidget(86),
    ZonePlacesWidget(81),
    ZonePlacesWidget(84),
    ZonePlacesWidget(79),
    ZonePlacesWidget(85),
    ZonePlacesWidget(89),
    ZonePlacesWidget(89)
  ];

  List<Text> ticketPrice = [
    Text('\$125', style: priceTextStyle),
    Text('\$150', style: priceTextStyle),
    Text('\$175', style: priceTextStyle),
    Text('\$200', style: priceTextStyle),
    Text('\$225', style: priceTextStyle),
    Text('\$250', style: priceTextStyle),
    Text('\$275', style: priceTextStyle),
    Text('\$300', style: priceTextStyle.copyWith(color: Colors.red)),
  ];
}
