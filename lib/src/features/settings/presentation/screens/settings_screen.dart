import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
            title: Text('Settings'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    title: Text(
                      'Apperance',
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Icon(Icons.palette_outlined),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
