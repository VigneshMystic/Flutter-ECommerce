import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sally/appBar/appBar.dart';
import 'package:sally/drawerMenu/drawerMenu.dart';
import 'package:sally/itemInCart.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../database.dart';


//Description : The Cart page to display items added to cart for purchase
//Coded by Vignesh
class productList {
  String image;
  String price;
  double rating = 0.0;
  String productName;

  productList(this.image, this.price, this.rating, this.productName);

  productList.map(dynamic obj) {
    this.image = obj['image'];
    this.price = obj['price'];
    this.rating = obj['rating'];
    this.productName = obj['name'];
  }
}

class cartPage extends StatefulWidget {
  @override
  _cartPageState createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  static String _image = "";

  static int _price = 0;

  static double _rating = 0.0;

  static String _name = "";

  int total = 0;

  int _itemId = 0;

  final cartItems = [];

  List _word;

  //Description : Using Future to get data added in local databse
  //Coded by Vignesh
  Future<List> read() async {
    var db = await DatabaseHelper();
    _word = await db.getAll();
    var id = db.productId;
    print(_word);
    for (int i = 0; i <= _word.length; i++) {
      CartItem cart = CartItem.map(_word[i]);
      if (cart != null) {
        _image = cart.image;
        _price = cart.price;
        _rating = cart.rating;
        _name = cart.name;
        _itemId = cart.id;
        total = total + cart.price;
        cartItems.add({
          "image": "$_image",
          "price": _price,
          "rating": _rating,
          "name": "$_name",
          "total": total,
          "id": _word[i][id]
        });
      } else {
        cartItems.add({
          "image": "$_image",
          "price": _price,
          "rating": _rating,
          "name": "$_name",
          "total": total,
          "id": _word[i][id]
        });
      }
      print('read row : ${cart.name}');
      print('read cartItems : ${cartItems[i]["image"]}');
      print('read cartItems : ${cartItems[i]['id']}');
    }
  }

  //Description : Using Future to Delete data that is added in local databse
  //Coded by Vignesh
  Future<int> delete(int i) async {
    var db = await DatabaseHelper();
    var value = await db.deleteItem(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawerMenu(),
      appBar: BaseAppBar(
        title: Text(''),
        appBar: AppBar(),
      ),
      //Description : Using FutureBuilder to get data from local databse and display it in list
      //Coded by Vignesh
      body: FutureBuilder<List>(
        future: read(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (cartItems.length > 0) {
            return Column(children: <Widget>[
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
                          "Cart",
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
                    fit: FlexFit.tight,
                    child: Container(
                      color: Color.fromRGBO(255, 179, 191, 0.8),
                      height: 40.5,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                        size: 20.5,
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: GridView.count(
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(8.0),
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1.7,
                    children: cartItems
                        .asMap()
                        .map((int i, data) => MapEntry(
                            i,
                            Card(
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 10,
                                    height: 200.0,
                                    width: 165.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset("${data["image"]}"),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 20,
                                    child: Text("\$ ${data["price"]}",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                        )),
                                  ),
                                  Positioned(
                                      top: 25,
                                      left: 5,
                                      child: SmoothStarRating(
                                        rating: data["rating"],
                                        size: 13.0,
                                        starCount: 5,
                                        allowHalfRating: false,
                                      )),
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Text("${data["name"]}"),
                                  ),
                                  Positioned(
                                    top: 15,
                                    right: 25,
                                    child: InkWell(
                                      onTap: () => {
                                            delete(data["id"]),
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Item removed from cart"),
                                              duration:
                                                  Duration(milliseconds: 800),
                                            ))
                                          },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Icon(
                                            Icons.remove_shopping_cart,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )))
                        .values
                        .toList()),
              ),
              BottomAppBar(
                color: Colors.pinkAccent,
                child: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Price",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                            child: Text(
                          "\$ $total",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          } else {
            return Container(
                child: Column(children: <Widget>[
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
                          "Cart",
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
                    fit: FlexFit.tight,
                    child: Container(
                      color: Color.fromRGBO(255, 179, 191, 0.8),
                      height: 40.5,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                        size: 20.5,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "No Item in Cart",
                        style: TextStyle(fontSize: 17.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
              BottomAppBar(
                color: Colors.pinkAccent,
                child: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Price",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                            child: Text(
                          "\$ $total",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
          }
        },
      ),
    );
  }
}
