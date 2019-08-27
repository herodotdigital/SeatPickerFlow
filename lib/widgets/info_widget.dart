import 'package:flutter/material.dart';
import 'package:seat_picker_flow/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: cardBackground.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.only(right: 8),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.shieldAlt,
                              color: shieldColor,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 4),
                                  Text('Home',
                                      style: additionalTextStyle.copyWith(
                                          fontSize: 11)),
                                  Text('AIM', style: primaryTextStyle),
                                  SizedBox(height: 4),
                                  Text('All In Mobile',
                                      style: secondaryTextStyle),
                                  SizedBox(height: 4),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Text('vs'),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 4),
                                  Text('Away',
                                      style: additionalTextStyle.copyWith(
                                          fontSize: 11)),
                                  Text('MAN', style: primaryTextStyle),
                                  SizedBox(height: 4),
                                  Text('Manchester Utd.',
                                      style: secondaryTextStyle),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.shieldAlt,
                              color: shieldColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.location_on,
                              color: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Oporowa 25',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14)),
                                Text('Wrocław', style: additionalTextStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              FontAwesomeIcons.stopwatch,
                              color: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('5:30 PM',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 14)),
                                Text('13th May, 2018',
                                    style: additionalTextStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
