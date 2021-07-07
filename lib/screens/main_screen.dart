import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

import 'package:classifieds_app/widgets/main_products.dart';
import 'package:classifieds_app/components/custom_loading.dart';
import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<SliderMenuContainerState> _key =
      GlobalKey<SliderMenuContainerState>();

  bool _isLoading = false;
  bool _isInit = true;

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<ProductLogic>(context).getAllProducts();

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
    return Scaffold(
      body: _isLoading
          ? CustomLoading()
          : SliderMenuContainer(
              appBarColor: Colors.white,
              appBarHeight: 90,
              drawerIconColor: Theme.of(context).primaryColor,
              key: _key,
              sliderMenuOpenSize: 200,
              title: Text(
                'Classifields App',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              sliderMenu: MainDrawer(),
              sliderMain: MainProducts(),
            ),
    );
  }
}
