// ignore_for_file: public_member_api_docs, sort_constructors_first
class Calisan {
  final int? id;
  final String resimYolu;
  final String adresYolu;
  final String kisiAd;
  final String kisiTC;
  final String departman;
  final int maas;
  final int calisanYili;

  Calisan({
    this.id,
    required this.resimYolu,
    required this.adresYolu,
    required this.kisiAd,
    required this.kisiTC,
    required this.departman,
    required this.maas,
    required this.calisanYili,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'resimYolu': resimYolu,
      'adresYolu': adresYolu,
      'kisiAd': kisiAd,
      'kisiTC': kisiTC,
      'departman': departman,
      'maas': maas,
      'calisanYili': calisanYili,
    };
  }
}
