import 'package:flutter/material.dart';
import 'package:sally/appBar/appBar.dart';
import 'package:sally/drawerMenu/drawerMenu.dart';
import 'package:sally/tips/tipsPage.dart';
import 'package:sally/productListPage/productListPage.dart';

//Description : Home page design application
//Coded by Vignesh
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawerMenu(),
      //Description : Appbar design fetched from another page for the application
      //Coded by Vignesh
      appBar: BaseAppBar(
        title: Text('Sally Beauty'),
        appBar: AppBar(),
      ),
      body: Container(
        margin: const EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return nextPage();
                      }));
                    },
                    child: Image.asset(
                      "images/download.png",
                      width: 550.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return nextPage();
                        }));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            "images/hairstyle.png",
                            width: 200.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return tipsPage();
                        }));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            "images/makeup.png",
                            width: 200.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
