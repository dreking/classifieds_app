import 'package:classifieds_app/components/custom_loading.dart';
import 'package:classifieds_app/models/product.dart';
import 'package:classifieds_app/providers/auth_logic.dart';
import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/screens/product_details_screen.dart';
import 'package:classifieds_app/screens/signin_screen.dart';
import 'package:classifieds_app/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  List<Product> _products = [];

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _products = await Provider.of<ProductLogic>(context, listen: false)
        .getAllProducts();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) _loadData();
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthLogic>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Classifields App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Welcome to Classifields'),
                padding: EdgeInsets.all(50),
              ),
              if (user.id == null)
                ListTile(
                  title: Text(
                    'Sign In as Supplier',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  },
                ),
              if (user.id != null)
                ListTile(
                  title: Text(
                    'My Products',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  },
                ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? CustomLoading()
          : GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
              children: _products
                  .map(
                    (product) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ProductDetailsScreen.routeName,
                          arguments: product,
                        );
                      },
                      child: ProductWidget(
                        product: product,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
