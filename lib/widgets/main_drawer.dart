import 'package:classifieds_app/providers/auth_logic.dart';
import 'package:classifieds_app/screens/my_products_screen.dart';
import 'package:classifieds_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthLogic>(context).user;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Manage Products'),
              padding: EdgeInsets.all(50),
            ),
            if (user.id == null)
              ListTile(
                leading: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                title: Text(
                  'Sign In as Supplier',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SignInScreen.routeName);
                },
              ),
            SizedBox(height: 20),
            if (user.id != null)
              ListTile(
                leading: Icon(
                  Icons.cases_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'My Products',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MyProductsScreen.routeName);
                },
              ),
          ],
        ),
      ),
    );
  }
}
