import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:classifieds_app/components/custom_button.dart';
import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/product.dart';
import 'package:share/share.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMd();

    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            elevation: 5,
            child: Container(
              height: 350,
              child: Stack(
                children: [
                  Hero(
                    tag: product.id!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: SafeArea(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.png',
                          image: getImageUrl(product.imageUrl!),
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.chevron_left,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () => Share.share(
                          'check out this product https://https://classifiedsserver.herokuapp.com/api/v1/public/products/${product.id}',
                        ),
                        icon: Icon(Icons.share, size: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  product.name!,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.category!,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      format.format(product.manufactureDate!),
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'RWF ' + product.price!.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                Text(
                  product.description!,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: CustomButton(
              onTap: () {},
              text: 'Add to Cart',
              icon: Icons.shopping_cart_outlined,
            ),
          )
        ],
      ),
    );
  }
}

class TextDisplay extends StatelessWidget {
  final String title;
  final String text;
  const TextDisplay({
    Key? key,
    required this.text,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
