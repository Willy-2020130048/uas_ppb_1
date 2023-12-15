import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.email);
    return StreamBuilder(
      stream: getData(FirebaseAuth.instance.currentUser?.email),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        } else if(snapshot.hasData){
          final data = snapshot.data!;
          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.red,
                child:  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          data[0].nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Akun",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Nama"),
                        trailing: Text(data[0].nama),
                      ),
                      ListTile(
                        title: const Text("Email"),
                        trailing: Text(data[0].email),
                      ),
                      ListTile(
                        title: const Text("Nomor Telp"),
                        trailing: Text(data[0].handphone),
                      ),
                      ListTile(
                        title: const Text("Alamat"),
                        trailing: Text(data[0].alamat),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Transaksi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("History Pembelian"),
                        trailing: Icon(Icons.arrow_right),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text("No Data");
        }
      },
    );
  }

  Stream<List<UserData>> getData(String? email) => FirebaseFirestore.instance
      .collection("Users")
      .where("email", isEqualTo: email)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => UserData.fromJson(e.data())).toList());
}
