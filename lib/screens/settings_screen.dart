import 'package:flutter/material.dart';
import '../utils/shared_prefs_helper.dart';
import '../main.dart'; // Mengambil global theme notifier

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    String name = await SharedPrefsHelper.getUsername();
    bool isDark = await SharedPrefsHelper.getTheme();
    setState(() {
      _nameController.text = name;
      _isDarkMode = isDark;
    });
  }

  Future<void> _saveName() async {
    await SharedPrefsHelper.setUsername(_nameController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nama berhasil disimpan')),
    );
  }

  void _toggleTheme(bool value) async {
    await SharedPrefsHelper.setTheme(value);
    setState(() {
      _isDarkMode = value;
    });
    // Mengubah tema aplikasi secara global
    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Panggilan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveName,
              child: const Text('Simpan Nama'),
            ),
            const Divider(height: 40),
            SwitchListTile(
              title: const Text('Mode Gelap (Dark Mode)'),
              value: _isDarkMode,
              onChanged: _toggleTheme,
            ),
          ],
        ),
      ),
    );
  }
}