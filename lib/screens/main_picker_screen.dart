import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seat_picker_flow/pager_notifier.dart';
import 'package:seat_picker_flow/theme.dart';
import 'package:seat_picker_flow/animations/fade_route_builder.dart';
import 'package:seat_picker_flow/screens/ticket_screen.dart';
import 'package:seat_picker_flow/widgets/info_widget.dart';
import 'package:seat_picker_flow/widgets/sector_widget.dart';
import 'package:seat_picker_flow/widgets/places_widget.dart';
import 'package:seat_picker_flow/widgets/price_widget.dart';
import 'package:rect_getter/rect_getter.dart';

class MainPickerScreen extends StatefulWidget {
  @override
  _MainPickerScreenState createState() => _MainPickerScreenState();
}

class _MainPickerScreenState extends State<MainPickerScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController toolbarController;
  Animation<Offset> _topOffset;
  Animation<Offset> _bottomOffset;
  Animation<double> _toolbarOpacity;
  PagerNotifier _notifier = PagerNotifier();

  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    toolbarController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _topOffset = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
        .animate(controller);
    _bottomOffset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
    _toolbarOpacity =
        Tween<double>(begin: 0.0, end: 1).animate(toolbarController);

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
                onPressed: () => SystemNavigator.pop()),
            title: FadeTransition(
                opacity: _toolbarOpacity,
                child: Text('Pick your seats', style: titleTextStyle)),
            brightness: Brightness.light,
          ),
          body: ListenableProvider<PagerNotifier>.value(
            value: _notifier,
            child: Column(
              children: [
                SlideTransition(position: _topOffset, child: InfoWidget()),
                SlideTransition(
                    position: _topOffset, child: SectorChooserWidget()),
                Expanded(
                    child: SlideTransition(
                        position: _bottomOffset, child: PlacesWidget())),
                SlideTransition(position: _bottomOffset, child: PriceWidget()),
              ],
            ),
          ),
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child: FloatingActionButton(
              onPressed: () {
                setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => rect = rect
                      .inflate(1.3 * MediaQuery.of(context).size.longestSide));
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
        .push(FadeRouteBuilder(page: TicketScreen()))
        .then((_) => setState(() => rect = null));
  }

  Widget _ripple() {
    if (rect == null) return Container();

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
