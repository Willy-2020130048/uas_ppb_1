import 'package:cloud_firestore/cloud_firestore.dart';

class Carts {
  String idProduk;
  String user;
  int jumlah;

  Carts({
    required this.idProduk,
    required this.user,
    required this.jumlah,
  });

  Carts.fromJson(Map<String, dynamic> json)
      : idProduk = json['idProduk'],
        user = json['user'],
        jumlah = json['jumlah'];

  Map<String, dynamic> toJson() {
    return {
      'idProduk': idProduk,
      'user': user,
      'jumlah': jumlah,
    };
  }

  factory Carts.fromDoc(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Carts(
      idProduk: data['idProduk'],
      user: data['user'],
      jumlah: data['jumlah'],
    );
  }
}
