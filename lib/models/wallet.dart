class Wallet {
  final int id;
  final String name;

  Wallet({required this.id, required this.name});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      name: json['name'],
    );
  }
}
