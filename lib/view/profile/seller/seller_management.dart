import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_master/view/homeseller.dart';

import 'package:provider/provider.dart';
import '../../../shared/constants.dart';

import '../../../model/akunmodel.dart';

import '../../../provider/auth.dart';
import '../../../provider/products.dart';
import '../../../provider/akunprovider.dart';
import '../../../widgets/widgets_massagesnackbar.dart';

class SellerManagement extends StatefulWidget {
  const SellerManagement({super.key});

  @override
  State<SellerManagement> createState() => _SellerManagementState();
}

class _SellerManagementState extends State<SellerManagement> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();

  Future<String> _addProdukSeller(title, description, qty, price, imageUrl) {
    return Future.delayed(const Duration(milliseconds: 2250)).then((_) async {
      try {
        final auth = Provider.of<Auth>(context, listen: false);
        final akunProv = Provider.of<AkunProvider>(context, listen: false);

        akunProv.getDataById(auth.userId.toString());
        AkunModel akun = akunProv.selectById(auth.userId.toString());
        await Provider.of<Products>(context, listen: false).addProduct(
            title, description, qty, price, akun.address, imageUrl, akun.id);
      } catch (e) {
        return "An Errorerror occurred: ${e.toString()}";
      }
      return 'Add Product Success';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: const Text(
            "Management Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.shopping_bag,
                            color: ColorPalette.primaryColor,
                          ),
                          labelText: 'Enter a new product title',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      maxLength: 15,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new product title';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      maxLength: 200,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: _description,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.description_outlined,
                            color: ColorPalette.primaryColor,
                          ),
                          labelText: 'Enter a description of your new product',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      autofocus: false,
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _qty,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.add_shopping_cart_sharp,
                            color: ColorPalette.primaryColor,
                          ),
                          labelText: 'Enter the number of available products',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      maxLength: 500,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of available products';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _price,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.attach_money,
                          color: ColorPalette.primaryColor,
                        ),
                        labelText: 'Enter the price of your new product',
                        errorStyle: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      maxLength: 3,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your new product price';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _imageUrl,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: ColorPalette.primaryColor,
                        ),
                        labelText: 'insert your new product image',
                        errorStyle: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please insert your new product image';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 8, 15, 8),
                      child: ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _addProdukSeller(
                              _title.text,
                              _description.text,
                              _qty.text,
                              _price.text,
                              _imageUrl.text,
                            ).then((response) {
                              if (response == 'Add Product Success') {
                                return Navigator.pushNamed(
                                    context, HomeSeller.nameRoute);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: ColorPalette.primaryColor,
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    content: MassageSnackBar(
                                        msgError: response,
                                        msg: "Oh Snapss!!!"),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorPalette.secondaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: const Text('Save',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
