import 'package:flutter/material.dart';
import 'pages/mahasiswa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTheme = "Biru";

  Color appBarColor = Colors.blue;
  Color buttonColor = Colors.lightBlue;
  Color backgroundColor = Colors.white;

  void changeTheme(String theme) {
    setState(() {
      selectedTheme = theme;

      switch (theme) {
        case "Biru":
          appBarColor = Colors.blue;
          buttonColor = Colors.lightBlue;
          backgroundColor = Colors.white;
          break;

        case "Hijau":
          appBarColor = Colors.green;
          buttonColor = Colors.teal;
          backgroundColor = Colors.green.shade50;
          break;

        case "Merah":
          appBarColor = Colors.red;
          buttonColor = Colors.orange;
          backgroundColor = Colors.red.shade50;
          break;

        case "Ungu":
          appBarColor = Colors.deepPurple;
          buttonColor = Colors.purple;
          backgroundColor = Colors.purple.shade50;
          break;

        case "Dark":
          appBarColor = Colors.black;
          buttonColor = Colors.blueGrey;
          backgroundColor = Colors.grey.shade900;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Pilih Tema",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(
              value: selectedTheme,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "Biru", child: Text("Biru")),
                DropdownMenuItem(value: "Hijau", child: Text("Hijau")),
                DropdownMenuItem(value: "Merah", child: Text("Merah")),
                DropdownMenuItem(value: "Ungu", child: Text("Ungu")),
                DropdownMenuItem(value: "Dark", child: Text("Dark Mode")),
              ],
              onChanged: (value) {
                if (value != null) {
                  changeTheme(value);
                }
              },
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text(
                "Data Mahasiswa",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MahasiswaPage()),
                );
              },
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Icon(Icons.school, size: 60),
                    SizedBox(height: 10),
                    Text(
                      "Aplikasi CRUD Mahasiswa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("Flutter + Google Sheet"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
