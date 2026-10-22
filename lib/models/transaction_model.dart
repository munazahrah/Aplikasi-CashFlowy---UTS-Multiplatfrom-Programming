class TransactionModel {
  int? id;
  String type; // 'pemasukan' atau 'pengeluaran'
  double amount;
  String category;
  String date;
  String note;

  TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.note = '',
  });

  // Mengubah objek ke Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'category': category,
      'date': date,
      'note': note,
    };
  }

  // Membuat objek dari Map yang diambil dari SQLite
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      category: map['category'],
      date: map['date'],
      note: map['note'],
    );
  }
}