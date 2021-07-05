import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';

import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/product.dart';

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

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.grey.shade500, BlendMode.multiply),
          image: NetworkImage(getImageUrl(product.imageUrl!)),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(
                  'check out this product https://https://classifiedsserver.herokuapp.com/api/v1/public/products${product.id}',
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              SizedBox(height: 10),
              TextDisplay(
                title: 'Name: ',
                text: product.name!,
              ),
              SizedBox(height: 10),
              TextDisplay(
                title: 'Category: ',
                text: product.category!,
              ),
              SizedBox(height: 10),
              TextDisplay(
                title: 'Description: ',
                text: product.description!,
              ),
              SizedBox(height: 10),
              TextDisplay(
                title: 'Manufactored: ',
                text: format.format(product.manufactureDate!),
              ),
              SizedBox(height: 30),
              TextDisplay(
                title: 'Price: RWF',
                text: product.price!.toStringAsFixed(2),
              ),
            ],
          ),
        ),
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       expandedHeight: 250,
      //       pinned: true,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(product.name!),
      //         background: Hero(
      //           tag: product.id!,
      //           child: FadeInImage.assetNetwork(
      //             placeholder: 'assets/images/placeholder.png',
      //             image: getImageUrl(product.imageUrl!),
      //             height: 300,
      //             width: double.infinity,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildListDelegate(
      //         [
      //           SizedBox(height: 20),
      //           TextDisplay(
      //             title: 'Description: ',
      //             text: product.description!,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
