import 'package:flutter/material.dart';
import 'package:sally/mainMenu/mainMenu.dart';

//Description : The app drawer to display the sidemenu
//Coded by Vignesh
class drawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //Description : UserAccountsDrawerHeader to display the user profile related data
          //Coded by Vignesh
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.pinkAccent),
          ),
          //Description : to display the list of sidemenu shortcut
          //Coded by Vignesh
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return Menu();
                  }));
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
