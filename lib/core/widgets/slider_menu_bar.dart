import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .33;

    return Drawer(
      width: width,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF1E6), Color(0xFFFDD6D6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [
            /// PROFILE
            const SizedBox(height: 50),

            const CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),

            const SizedBox(height: 12),

            const Text(
              "Divya Trivedi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const Text(
              "Sr Principal Engineer",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),

            const SizedBox(height: 30),

            /// MENU ITEMS
            _menuItem(Icons.home, "Home"),

            _menuItem(Icons.people, "Employees"),

            _themeMenu(),

            const Spacer(),

            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Version 1.0",
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: () {});
  }

  Widget _themeMenu() {
    return ExpansionTile(
      leading: const Icon(Icons.palette),
      title: const Text("Theme"),
      children: const [
        ListTile(title: Text("Light")),
        ListTile(title: Text("Dark")),
      ],
    );
  }
}
