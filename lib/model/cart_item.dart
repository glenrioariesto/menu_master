class CartItem {
  String id;
  String idUser;
  String idProduct;
  String title;
  String price;
  String image;
  int qty;

  CartItem(
      {required this.id,
      required this.idUser,
      required this.idProduct,
      required this.title,
      required this.price,
      required this.qty,
      required this.image});
}
