import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sally/cartPage/cart.dart';

//Description : A common app bar design for overall application
//Coded by Vignesh
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

// you can add more fields that meet your needs
//Description : Passing optional parameters for appbar
//Coded by Vignesh
  const BaseAppBar(
      {Key key, this.title, this.backgroundColor, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => cartPage())),
              },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => print("text"),
        ),
        Builder(
          builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
