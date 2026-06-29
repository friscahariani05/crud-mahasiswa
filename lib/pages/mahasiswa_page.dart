import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../form_mahasiswa_page.dart';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({super.key});

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  List mahasiswa = [];

  final String apiUrl =
      "https://script.google.com/macros/s/AKfycbwd5w4w8CUIh16jC0vn80dxpGUujqrOicaiy_CRWGwVPgoyUTzAWMOR_v-isF21RfzS/exec";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(Uri.parse(apiUrl));

    setState(() {
      mahasiswa = jsonDecode(response.body);
    });
  }

  Future<void> hapusData(String id) async {
    final url = "$apiUrl?action=delete&id=$id";

    await http.get(Uri.parse(url));

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Mahasiswa")),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormMahasiswaPage(apiUrl: apiUrl),
            ),
          );

          getData();
        },
      ),

      body: ListView.builder(
        itemCount: mahasiswa.length,

        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(mahasiswa[index]["nama"].toString()),

              subtitle: Text(mahasiswa[index]["prodi"].toString()),

              leading: CircleAvatar(
                child: Text(mahasiswa[index]["id"].toString()),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormMahasiswaPage(
                            apiUrl: apiUrl,
                            data: mahasiswa[index],
                          ),
                        ),
                      );

                      getData();
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      hapusData(mahasiswa[index]["id"].toString());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
