import 'package:flutter/material.dart';
import 'package:sally/appBar/appBar.dart';
import 'package:sally/drawerMenu/drawerMenu.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class productList {
  String image;
  String price;
  double rating = 0.0;
  String productName;

  productList(this.image, this.price, this.rating, this.productName);
}

class textAlert extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              maxLines: 8,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "TextField in Dialog"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: textAlert(),
    );
  }
}

class gridList extends StatefulWidget {
  @override
  _gridListState createState() => _gridListState();
}

class _gridListState extends State<gridList> {
  final _images = [
    new productList('images/brush.png', '\$68', 2.5, "Makeup Brushes"),
    new productList('images/gel.png', '\$25', 4.5, "Lakme Alovera gel"),
    new productList('images/makeup.png', '\$21', 1.0, "Touchup Combo"),
    new productList('images/makeupset.png', '\$42', 4.0, "Makeup-Kits"),
    new productList('images/compact.png', '\$30', 3.0, "Compact"),
    new productList('images/facwash.png', '\$95', 3.5, "Skin cream"),
    new productList('images/touchup.png', '\$154', 5.0, "Lakme rose powder"),
    new productList('images/lipstick.png', '\$35', 0.5, "Lipstick")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(8.0),
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 1.7,
        children: _images
            .map((data) => Card(
                  color: Colors.white70,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        height: 200.0,
                        width: 165.0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(data.image),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 20,
                        child: Text(data.price,
                            style: TextStyle(
                              fontSize: 22.0,
                            )),
                      ),
                      Positioned(
                          top: 25,
                          left: 5,
                          child: SmoothStarRating(
                            rating: data.rating,
                            size: 13.0,
                            starCount: 5,
                            allowHalfRating: false,
                          )),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Text(data.productName),
                      ),

                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class tipsPage extends StatelessWidget {
  var text = textAlert();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: drawerMenu(),
        appBar: BaseAppBar(
          title: Text(''),
          appBar: AppBar(),
        ),
        body: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 7,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Color.fromRGBO(255, 179, 191, 0.8),
                      height: 40.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Beauty Tips",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        color: Color.fromRGBO(255, 179, 191, 0.8),
                        height: 40.5,
                        child: InkWell(
                            onTap: () {
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text("tips is pressed"),
//                                duration: Duration(milliseconds: 500),
//                              ));
                              text._displayDialog(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add_box,
                                  color: Colors.pink,
                                  size: 20.5,
                                ),
                                Text(
                                  "tips",
                                  style: TextStyle(fontSize: 14.5),
                                )
                              ],
                            ))),
                  ),
                ],
              ),
              Flexible(
                child: gridList(),
              ),
            ],
          );
        }));
  }

  void textField(BuildContext context) {
    var alertDialog = AlertDialog(
      actions: <Widget>[
        Column(
          children: <Widget>[
            Container(
              color: Colors.black,
            )
          ],
        ),
      ],
    );
  }
}
