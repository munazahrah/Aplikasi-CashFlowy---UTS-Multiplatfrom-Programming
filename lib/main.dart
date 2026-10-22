import 'package:flutter/material.dart';
import 'utils/shared_prefs_helper.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/input_screen.dart';

// ValueNotifier global untuk menangani perubahan tema secara realtime
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Membaca tema terakhir yang disimpan secara asinkron sebelum runApp
  bool isDark = await SharedPrefsHelper.getTheme();
  themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CashFlowy',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: currentMode,
          home: const MainNavigation(),
        );
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Kunci global untuk memanggil _loadData() di DashboardScreen
  // agar saldo terupdate setiap kali berpindah tab
  Key _dashboardKey = UniqueKey();
  Key _historyKey = UniqueKey();

  final List<Widget> screens = [
    const DashboardScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(key: _dashboardKey),
          HistoryScreen(key: _historyKey),
          const SettingsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Menunggu hingga halaman input selesai ditutup
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputScreen()),
          );
          // Jika ada data baru tersimpan (result = true), segarkan dashboard
          if (result == true) {
            setState(() {
              _dashboardKey = UniqueKey(); // Memaksa Dashboard render ulang
              _historyKey = UniqueKey();
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _dashboardKey = UniqueKey();
            } else if (index == 1) {
              _historyKey = UniqueKey();
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Riwayat'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
