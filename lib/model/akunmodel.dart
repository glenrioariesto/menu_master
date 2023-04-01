class AkunModel {
  String id;
  String username;
  String alamat;
  String imageUrl;
  String status;

  AkunModel(
      {required this.id,
      required this.username,
      required this.status,
      this.imageUrl = '',
      this.alamat = ''});
}
