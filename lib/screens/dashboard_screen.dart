import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/db_helper.dart';
import '../models/transaction_model.dart';
import '../utils/shared_prefs_helper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _username = "Pengguna";
  double _totalIncome = 0;
  double _totalExpense = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); // Memanggil fungsi asinkron saat widget dimuat
  }

  Future<void> _loadData() async {
    // Membaca nama pengguna dari SharedPrefs
    String name = await SharedPrefsHelper.getUsername();
    
    // Membaca transaksi dari SQLite
    List<TransactionModel> transactions = await DatabaseHelper.instance.getTransactions();
    
    double income = 0;
    double expense = 0;

    for (var tx in transactions) {
      if (tx.type == 'pemasukan') {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    setState(() {
      _username = name;
      _totalIncome = income;
      _totalExpense = expense;
      _isLoading = false;
    });
  }

  String formatRupiah(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    double balance = _totalIncome - _totalExpense;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Halo, $_username!", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text("Total Saldo", style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(formatRupiah(balance), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildSummaryCard("Pemasukan", _totalIncome, Colors.green)),
                const SizedBox(width: 10),
                Expanded(child: _buildSummaryCard("Pengeluaran", _totalExpense, Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(formatRupiah(amount), style: TextStyle(color: color, fontSize: 16)),
        ],
      ),
    );
  }
}