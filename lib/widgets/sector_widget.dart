import 'package:flutter/material.dart';
import 'package:seat_picker_flow/place_controller.dart';
import 'package:seat_picker_flow/theme.dart';

class SectorChooserWidget extends StatefulWidget {
  final List<Text> children;
  final PlaceController controller;

  SectorChooserWidget({this.children, this.controller});

  @override
  _SectorChooserWidgetState createState() => _SectorChooserWidgetState();
}

class _SectorChooserWidgetState extends State<SectorChooserWidget> {
  int selectedIndex;
  List<SectorItem> sectors = List();

  int reparseIndex(int index) {
    int returnIndex;
    if (index == 0)
      returnIndex = 6;
    else if (index == 7)
      returnIndex = index;
    else
      returnIndex = index - 1;
    return returnIndex;
  }
  int reverseParseIndex(int index) {
    int returnIndex;
    if (index == 6)
      returnIndex = 0;
    else if (index == 7)
      returnIndex = index;
    else
      returnIndex = index + 1;
    return returnIndex;
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      sectors[reparseIndex(selectedIndex)].unSelect();
      selectedIndex = widget.controller.value;
      sectors[reparseIndex(selectedIndex)].select();
    });

    Function(int) selectionChange = (int index) {
      widget.controller.value = reverseParseIndex(index);
    };

    for (int i = 0; i < widget.children.length; i++) {
      if (i == 0) {
        sectors.add(SectorItem(i,
            child: widget.children[i],
            isStartItem: true,
            isSelected: i == reparseIndex(widget.controller.value),
            onSelectionChanged: selectionChange));
      } else if (i == 5) {
        sectors.add(SectorItem(i,
            child: widget.children[i],
            isEndItem: true,
            isSelected: i == reparseIndex(widget.controller.value),
            onSelectionChanged: selectionChange));
      } else if (i == 6 || i == 7) {
        sectors.add(SectorItem(i,
            child: widget.children[i],
            onSelectionChanged: selectionChange,
            isSelected: i == reparseIndex(widget.controller.value),
            visibleShadow: true));
      } else {
        sectors.add(SectorItem(i,
            isSelected: i == reparseIndex(widget.controller.value),
            child: widget.children[i],
            onSelectionChanged: selectionChange));
      }
    }

    selectedIndex = widget.controller.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              sectors[0],
              sectors[1],
              sectors[2],
              sectors[3],
              sectors[4],
              sectors[5],
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectors[6],
                sectors[7],
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SectorItem extends StatefulWidget {
  final int index;
  final bool isStartItem;
  final bool isEndItem;
  final Text child;
  final bool visibleShadow;
  final Function onSelectionChanged;
  final bool isSelected;
  final _state = _SectorItemState();

  SectorItem(
    this.index, {
    this.isStartItem = false,
    this.isEndItem = false,
    @required this.child,
    @required this.onSelectionChanged,
    this.isSelected = false,
    this.visibleShadow = false,
  });

  @override
  _SectorItemState createState() => _state;

  void unSelect() => _state.unSelect();

  void select() => _state.select();
}

class _SectorItemState extends State<SectorItem> {
  BorderSide _border = BorderSide.none;
  double _opacity = 0.4;
  Color _fillColor = cardBackground;
  bool _isChecked = false;

  void handleState() {
    _opacity = _isChecked ? 1 : 0.4;
    _border = _isChecked
        ? BorderSide(color: primaryColor, width: 4)
        : BorderSide.none;
    _fillColor = _isChecked ? Colors.white : cardBackground;
  }

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.zero;
    if (widget.isStartItem)
      radius = BorderRadius.only(
        topLeft: Radius.circular(50),
      );
    else if (widget.isEndItem) {
      radius = BorderRadius.only(
        topRight: Radius.circular(50),
      );
    }

    EdgeInsets padding = EdgeInsets.zero;
    if (widget.isStartItem) {
      padding = EdgeInsets.only(left: 8.0);
    } else if (widget.isEndItem) {
      padding = EdgeInsets.only(right: 8.0);
    }

    handleState();

    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: [
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: radius, side: _border),
            elevation: 0,
            constraints: BoxConstraints.tight(Size(60, 60)),
            fillColor: _fillColor,
            highlightElevation: 2,
            child: Padding(
              padding: padding,
              child: widget.child,
            ),
            onPressed: () {
              widget.onSelectionChanged(widget.index);
              select();
            },
          ),
          Visibility(
            visible: widget.visibleShadow,
            child: Positioned(
              bottom: 0,
              width: 60,
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

  void unSelect() => setState(() => _isChecked = false);

  void select() => setState(() => _isChecked = true);
}
