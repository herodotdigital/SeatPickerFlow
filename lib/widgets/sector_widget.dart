import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_picker_flow/pager_notifier.dart';
import 'package:seat_picker_flow/theme.dart';

class SectorChooserWidget extends StatelessWidget {

  List<Widget> mockSectors(){
    return [
      SectorItem(0, child: Text('C', style: sectorTextStyle), visibleShadow: true),
      SectorItem(1, child: Text('D', style: sectorTextStyle), isStartItem: true),
      SectorItem(2, child: Text('E', style: sectorTextStyle)),
      SectorItem(3, child: Text('F', style: sectorTextStyle)),
      SectorItem(4, child: Text('G', style: sectorTextStyle)),
      SectorItem(5, child: Text('H', style: sectorTextStyle)),
      SectorItem(6, child: Text('I', style: sectorTextStyle), isEndItem: true),
      SectorItem(7, child: Text('J', style: sectorTextStyle), visibleShadow: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sectors = mockSectors();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              sectors[1],
              sectors[2],
              sectors[3],
              sectors[4],
              sectors[5],
              sectors[6],
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectors[0],
                sectors[7],
              ],
            ),
          )
        ],
      ),
    );
  }

}

class SectorItem extends StatelessWidget {
  final int index;
  final bool isStartItem;
  final bool isEndItem;
  final Text child;
  final bool visibleShadow;

  const SectorItem(
    this.index, {
    Key key,
    this.isStartItem = false,
    this.isEndItem = false,
    this.visibleShadow = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.zero;
    if (isStartItem)
      radius = BorderRadius.only(
        topLeft: Radius.circular(50),
      );
    else if (isEndItem) {
      radius = BorderRadius.only(
        topRight: Radius.circular(50),
      );
    }

    EdgeInsets padding = EdgeInsets.zero;
    if (isStartItem) {
      padding = EdgeInsets.only(left: 8.0);
    } else if (isEndItem) {
      padding = EdgeInsets.only(right: 8.0);
    }

    PagerNotifier notifier = Provider.of<PagerNotifier>(context, listen: true);

    double _opacity = index == notifier.position ? 1 : 0.4;
    BorderSide _border = index == notifier.position
        ? BorderSide(color: primaryColor, width: 4)
        : BorderSide.none;
    Color _fillColor =
        index == notifier.position ? Colors.white : cardBackground;

    final buttonSize = (MediaQuery.of(context).size.width / 6) - 8;

    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: [
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: radius, side: _border),
            elevation: 0,
            constraints: BoxConstraints.tight(Size(buttonSize, buttonSize)),
            fillColor: _fillColor,
            highlightElevation: 2,
            child: Padding(
              padding: padding,
              child: child,
            ),
            onPressed: () {
              notifier.setupOnPosition(index);
            },
          ),
          Visibility(
            visible: visibleShadow,
            child: Positioned(
              bottom: 0,
              width: buttonSize,
              child: Container(
                height: 20.0,
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
          )
        ],
      ),
    );
  }
}
