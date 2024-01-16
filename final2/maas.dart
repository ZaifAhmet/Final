// ignore_for_file: public_member_api_docs, sort_constructors_first

class Maas {
  final int? id;
  final double maas;
  final String maasTarihi;
  final String kisiTC;

  Maas(
      {this.id,
      required this.maas,
      required this.maasTarihi,
      required this.kisiTC});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'maas': maas,
      'maasTarihi': maasTarihi,
      'kisiTC': kisiTC,
    };
  }
}
