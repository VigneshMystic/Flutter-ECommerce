import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sally/appBar/appBar.dart';
import 'package:sally/drawerMenu/drawerMenu.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../database.dart';
import '../itemInCart.dart';

//Description : This page displays the Products list
//Coded by Vignesh
class productList {
  String image;
  int price;
  double rating = 0.0;
  String productName;

  productList(this.image, this.price, this.rating, this.productName);
}

//Description : This used to Search and filter the list (Not completed)
//Coded by Vignesh
class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: null,
        ),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return null;
  }
}

//Description : To display the product in grid
//Coded by Vignesh
class gridList extends StatefulWidget {
  @override
  _gridListState createState() => _gridListState();
}

class _gridListState extends State<gridList> {
  var db = new DatabaseHelper();

  final _images = [
    productList('images/brush.png', 68, 2.5, "Makeup Brushes"),
    productList('images/gel.png', 25, 4.5, "Lakme Alovera gel"),
    productList('images/makeup.png', 21, 1.0, "Touchup Combo"),
    productList('images/makeupset.png', 42, 4.0, "Makeup-Kits"),
    productList('images/compact.png', 30, 3.0, "Compact"),
    productList('images/facwash.png', 95, 3.5, "Skin cream"),
    productList('images/touchup.png', 154, 5.0, "Lakme rose powder"),
    productList('images/lipstick.png', 35, 0.5, "Lipstick")
  ];

  Future<List<productList>> _save(
      String image, int price, double rating, String name) async {
    CartItem cart = CartItem(name, price, rating, image);

    var value = await db.saveItem(cart);
    print('inserted row: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8.0),
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.7,
        children: _images
            .map((data) => Card(
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
                        child: Text("\$${data.price}",
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
                      Positioned(
                        bottom: 15,
                        left: 10,
                        child: InkWell(
                          onTap: () => {
                                _save(data.image, data.price, data.rating,
                                    data.productName),
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Item added to cart"),
                                  duration: Duration(milliseconds: 800),
                                ))
                              },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

//Description : This used to show a secondary appbar like field
//Coded by Vignesh
class nextPage extends StatelessWidget {
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
                          "Makeup",
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
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Fiter is pressed"),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.filter_list,
                                  color: Colors.black87,
                                  size: 17.5,
                                ),
                                Text(
                                  "Filter",
                                  style: TextStyle(fontSize: 14.5),
                                )
                              ],
                            ))),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        color: Color.fromRGBO(255, 179, 191, 0.8),
                        height: 40.5,
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Sort is pressed"),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.sort,
                                color: Colors.black87,
                                size: 17.5,
                              ),
                              Text(
                                "Sort",
                                style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        color: Color.fromRGBO(255, 179, 191, 0.8),
                        height: 40.5,
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("List is pressed"),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.list,
                                color: Colors.black87,
                                size: 17.5,
                              ),
                            ],
                          ),
                        )),
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
}
