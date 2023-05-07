class Product {
  String id;
  String idcustomer;
  String idseller;
  String idcart;
  String title;
  String description;
  int qtyseller;
  int qtycart;
  String price;
  String address;
  // List<String> variant;
  String imageUrl;

  Product({
    required this.id,
    this.idcustomer = '',
    this.idseller = '',
    this.idcart = '',
    required this.title,
    required this.description,
    this.qtyseller = 0,
    this.qtycart = 0,
    required this.price,
    required this.address,
    // required this.variant,
    required this.imageUrl,
  });
}
