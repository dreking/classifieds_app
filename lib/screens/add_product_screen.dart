import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:classifieds_app/components/custom_button.dart';
import 'package:classifieds_app/components/custom_dialog.dart';
import 'package:classifieds_app/components/custom_dismiss_keyboard.dart';
import 'package:classifieds_app/components/custom_input_card.dart';
import 'package:classifieds_app/components/custom_loading.dart';
import 'package:classifieds_app/models/product.dart';
import 'package:classifieds_app/providers/product_logic.dart';
import 'package:classifieds_app/widgets/image_input_widget.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';

  AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  Product _product = Product();

  void _onSelectedImage(File pickedImage) {
    setState(() {
      _product.image = pickedImage;
    });
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    String validations = '';
    if (_product.manufactureDate == null)
      validations += 'Add Manufacturing Date\n';
    if (_product.manufactureDate == null)
      validations += 'Choose a product Image\n';

    if (validations.isNotEmpty) {
      return await showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: 'Validation Errors',
          text: validations,
          status: false,
          onTap: () => Navigator.of(context).pop(),
        ),
      );
    }

    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final response = await Provider.of<ProductLogic>(
      context,
      listen: false,
    ).createProduct(_product);

    setState(() {
      _isLoading = false;
    });

    await showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Add Product Status',
        text: response.message,
        status: response.status,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMd();
    final categories = Provider.of<ProductLogic>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: _isLoading
          ? CustomLoading()
          : Form(
              key: _form,
              child: CustomDismissKeyboard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(15),
                        children: [
                          CustomInputCard(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: 'Product Name',
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Name';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _product.name = value!;
                                });
                              },
                            ),
                          ),
                          CustomInputCard(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: 'Product Price',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter price';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _product.price = double.parse(value!);
                                });
                              },
                            ),
                          ),
                          CustomInputCard(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: 'Product Description',
                                border: InputBorder.none,
                              ),
                              minLines: 1,
                              maxLines: 4,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Description';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _product.description = value;
                                });
                              },
                            ),
                          ),
                          CustomInputCard(
                            child: DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: 'Choose Category',
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              items: categories
                                  .map(
                                    (category) => DropdownMenuItem(
                                      child: Text(category),
                                      value: category,
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Choose category';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _product.category = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _product.category = value;
                                });
                              },
                            ),
                          ),
                          CustomInputCard(
                            color: _product.manufactureDate == null
                                ? Theme.of(context).errorColor
                                : null,
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),
                              ),
                              child: Text(
                                '${_product.manufactureDate != null ? 'Manufacturing Date: ' + format.format(_product.manufactureDate!) : 'Choose Manufacturing Date'}',
                              ),
                              onPressed: () async {
                                _product.manufactureDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now(),
                                );
                                setState(() {});
                              },
                            ),
                          ),
                          ImageInputWidget(
                            onSelectImage: _onSelectedImage,
                            buttonText: 'Add Image',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        onTap: _saveForm,
                        text: 'Save',
                        icon: Icons.save,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
