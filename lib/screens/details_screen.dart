import 'package:flutter/material.dart';
import 'package:seat_picker_flow/theme.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Your order',
          style: titleTextStyle.copyWith(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(60).copyWith(left: 80, right: 80),
        child: Column(
          children: <Widget>[
            TicketSummary(),
            SizedBox(height: 40),
            TicketSummary(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8.0).copyWith(left: 16, right: 16),
                    child: Text(
                      'Order & Pay',
                      style: priceTextStyle,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketSummary extends StatelessWidget {
  const TicketSummary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Standart ticket', style: summaryPrimaryTextStyle),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Sector',
              style: summarySecondaryTextStyle,
            ),
            Text(
              'F',
              style: summarySecondaryTextStyle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Row',
              style: summarySecondaryTextStyle,
            ),
            Text(
              '6',
              style: summarySecondaryTextStyle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Seat',
              style: summarySecondaryTextStyle,
            ),
            Text(
              '21',
              style: summarySecondaryTextStyle,
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Price',
                style: summaryPrimaryTextStyle.copyWith(fontSize: 20)),
            Text('\$42.50',
                style: summaryPrimaryTextStyle.copyWith(fontSize: 20))
          ],
        ),
      ],
    );
  }
}
