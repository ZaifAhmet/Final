class Bordro {
  final int? id;
  final String? kisiTC;
  final DateTime? maasTarihi;
  final int? maas;

  Bordro(
      {required this.id,
      required this.kisiTC,
      required this.maasTarihi,
      required this.maas});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'kisiTC': kisiTC,
      'maasTarihi': maasTarihi?.millisecondsSinceEpoch,
      'maas': maas,
    };
  }
}
