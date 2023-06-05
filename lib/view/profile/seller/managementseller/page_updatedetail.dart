import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import '../../../../model/akunmodel.dart';
import '../../../../model/product.dart';
import '../../../../provider/akunprovider.dart';
import '../../../../provider/auth.dart';
import '../../../../provider/products.dart';
import '../../../../shared/constants.dart';

class UpdateDetail extends StatefulWidget {
  const UpdateDetail({super.key, required this.products});

  final Product products;

  @override
  State<UpdateDetail> createState() => _UpdateDetailState();
}

class _UpdateDetailState extends State<UpdateDetail> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();

  Future<String> _updateProdukSeller(title, description, qty, price, imageUrl) {
    return Future.delayed(const Duration(milliseconds: 2250)).then((_) async {
      print("masuk update 2");
      try {
        final auth = Provider.of<Auth>(context, listen: false);
        final akunProv = Provider.of<AkunProvider>(context, listen: false);
        var product = widget.products;
        akunProv.getDataById(auth.userId.toString());
        print("tes1");
        AkunModel akun = akunProv.selectById(auth.userId.toString());

        await Provider.of<Products>(context, listen: false).updateProduct(
            product,
            title != '' ? title : product.title,
            description != '' ? description : product.description,
            qty != '' ? int.parse(qty) : product.qtyseller,
            price != '' ? price : product.price,
            imageUrl != '' ? imageUrl : product.imageUrl);
      } catch (e) {
        return "An Errorerror occurred: ${e.toString()}";
      }
      return 'Update Product Success';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: const Text(
            "Update Product",
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
                          labelText: 'Enter the update product title',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      maxLength: 15,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                          labelText:
                              'Enter a description of your update product',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      autofocus: false,
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _qty,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.add_shopping_cart_sharp,
                            color: ColorPalette.primaryColor,
                          ),
                          labelText: 'Enter the number of available products',
                          errorStyle:
                              TextStyle(color: ColorPalette.primaryColor)),
                      maxLength: 3,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _price,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.attach_money,
                          color: ColorPalette.primaryColor,
                        ),
                        labelText: 'Enter the updated price of your product',
                        errorStyle: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      maxLength: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _imageUrl,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: ColorPalette.primaryColor,
                        ),
                        labelText: 'Enter your update product image',
                        errorStyle: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      onSaved: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 8, 15, 8),
                      child: ElevatedButton(
                        autofocus: true,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              _isLoading = true;
                            });
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: 20),
                                      Text('Saving Product...'),
                                    ],
                                  ),
                                );
                              },
                            );
                            await _updateProdukSeller(
                              _title.text,
                              _description.text,
                              _qty.text,
                              _price.text,
                              _imageUrl.text,
                            );
                            Navigator.pop(context); // Close the dialog

                            // await _updateProdukSeller(
                            //         _title.text,
                            //         _description.text,
                            //         _qty.text,
                            //         _price.text,
                            //         _imageUrl.text)
                            //     .then((value) {
                            //   setState(() {
                            //     _isLoading = false;
                            //   });
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(SnackBar(
                            //     content: Text(
                            //         'The product was successfully removed'),
                            //     duration: Duration(milliseconds: 1000),
                            //   ));
                            // });
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
