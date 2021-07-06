import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/screens/product_details_screen.dart';
import 'package:classifieds_app/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainProducts extends StatelessWidget {
  const MainProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductLogic>(context).products;

    return Container(
      color: Colors.white,
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.6,
        children: products
            .map(
              (product) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailsScreen.routeName,
                    arguments: product,
                  );
                },
                child: ProductWidget(product: product),
              ),
            )
            .toList(),
      ),
    );
  }
}
