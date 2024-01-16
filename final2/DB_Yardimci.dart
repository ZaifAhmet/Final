import 'package:final2/maas.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'Calisan.dart';

class DBYardimci {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'Calisan.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE calisanlar(id INTEGER PRIMARY KEY AUTOINCREMENT, kisiAd TEXT, kisiTC TEXT, departman TEXT, maas INTEGER, resimYolu TEXT,adresYolu TEXT,calisanYili INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> CalisanEkle(Calisan calisan) async {
    final db = await DBYardimci.getDatabase();
    await db.insert('calisanlar', calisan.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("Calisan Eklendi");
  }

  static Future<List<Calisan>> CalisanGetir() async {
    final db = await DBYardimci.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('calisanlar');

    return List.generate(
      maps.length,
      (i) {
        return Calisan(
          id: maps[i]['id'],
          resimYolu: maps[i]['resimYolu'],
          adresYolu: maps[i]['adresYolu'],
          kisiAd: maps[i]['kisiAd'],
          kisiTC: maps[i]['kisiTC'],
          departman: maps[i]['departman'],
          maas: maps[i]['maas'],
          calisanYili: maps[i]['calisanYili'],
        );
      },
    );
  }

  static Future<void> calisanSil(int id) async {
    final db = await DBYardimci.getDatabase();
    print('Veritabanından siliniyor: $id');
    await db.delete(
      'calisanlar',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> tumCalisanlariSil() async {
    final db = await DBYardimci.getDatabase();
    await db.delete('calisanlar');
  }

  static Future<Database> getDatabase2() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'Maas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE maas(id INTEGER PRIMARY KEY AUTOINCREMENT,maas DOUBLE,maasTarihi TEXT,kisiTC TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> MaasEkle(Maas maas) async {
    final db = await DBYardimci.getDatabase2();
    await db.insert('maas', maas.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("Maas eklendi");
  }

  static Future<List<Maas>> MaasGetir() async {
    final db = await DBYardimci.getDatabase2();
    final List<Map<String, dynamic>> maps = await db.query('maas');

    return List.generate(
      maps.length,
      (i) {
        return Maas(
          id: maps[i]['id'],
          kisiTC: maps[i]['kisiTC'],
          maas: maps[i]['maas'],
          maasTarihi: maps[i]['maasTarihi'],
        );
      },
    );
  }

  static Future<String> ResimYolu(String TC) async {
    final db = await DBYardimci.getDatabase();
    final List<Map> results =
        await db.rawQuery("Select * From calisanlar where kisiTC == $TC");
    final String imagePath = results.first["resimYolu"];
    return imagePath;
  }

  static Future<String> Maaslar(String TC) async {
    final db = await DBYardimci.getDatabase2();
    final List<Map> maps =
        await db.rawQuery('Select * From maas where kisiTC == $TC');
    String maaslar = '';
    for (int i = 0; i < maps.length; i++) {
      String maas = maps[i]['maas'].toString();
      String tarih = maps[i]['maasTarihi'].toString();
      maaslar += ("Maas:$maas - Tarih:$tarih \n");
    }
    return maaslar;
  }
}
