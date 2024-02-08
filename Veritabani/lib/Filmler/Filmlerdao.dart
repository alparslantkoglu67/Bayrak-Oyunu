import 'package:veritabani/Filmler/Filmler.dart';
import 'package:veritabani/Filmler/Kategoriler.dart';
import 'package:veritabani/Filmler/VeriTabaniYardimcisiFilmler.dart';
import 'package:veritabani/Filmler/Yonetmenler.dart';

class Filmlerdao{
  Future<List<Filmler>> tumFilmlerByKategoriID(int kategori_id) async {
    var db = await VeritabaniYardimcisiFilmler.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM filmler,kategoriler,yonetmenler WHERE "
            "filmler.kategori_id=kategoriler.kategori_id AND filmler.yonetmen_id=yonetmenler.yonetmen_id AND"
            " filmler.kategori_id=$kategori_id");
    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var k=Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
      var y=Yonetmenler(satir["yonetmen_id"], satir["yonetmen_ad"]);
      var f=Filmler(satir["kategori_id"], satir["film_ad"], satir["film_yil"], satir["film_resim"], k, y);


      return f;
    });
  }

}