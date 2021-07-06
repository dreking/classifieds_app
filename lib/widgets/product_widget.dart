import 'package:classifieds_app/data/data.dart';
import 'package:classifieds_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: product.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: getImageUrl(product.imageUrl!),
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            product.name!,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 10),
          Text(
            'RWF ' + product.price!.toStringAsFixed(2),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
