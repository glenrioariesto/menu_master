class Product {
  String id;
  String idcustomer;
  String idseller;
  String title;
  String description;
  String qty;
  String price;
  String address;
  // List<String> variant;
  String imageUrl;

  Product({
    required this.id,
    this.idcustomer = '',
    this.idseller = '',
    required this.title,
    required this.description,
    required this.qty,
    required this.price,
    required this.address,
    // required this.variant,
    required this.imageUrl,
  });
}
