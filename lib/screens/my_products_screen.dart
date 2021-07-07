import 'package:classifieds_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:classifieds_app/components/custom_loading.dart';
import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/screens/add_product_screen.dart';

class MyProductsScreen extends StatefulWidget {
  static const routeName = '/my-products';

  MyProductsScreen({Key? key}) : super(key: key);

  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<ProductLogic>(
      context,
      listen: false,
    ).getMyProducts();

    await Provider.of<ProductLogic>(
      context,
      listen: false,
    ).getProdsuctCategories();

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
    final myProducts = Provider.of<ProductLogic>(context).myProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading
          ? CustomLoading()
          : ListView.builder(
              itemCount: myProducts.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailsScreen.routeName,
                    arguments: myProducts[index],
                  );
                },
                leading: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: getImageUrl(myProducts[index].imageUrl!),
                ),
                title: Text(myProducts[index].name!),
                subtitle: Text(myProducts[index].description!),
                trailing:
                    Text('RWF ${myProducts[index].price!.toStringAsFixed(2)}'),
              ),
            ),
    );
  }
}
