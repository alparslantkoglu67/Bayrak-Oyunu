import 'dart:core';

import 'package:veritabani/bayrakquiz/Bayraklar.dart';
import 'package:veritabani/bayrakquiz/VeritabaniYardimcisi.dart';

class Bayraklardao{
  Future<List<Bayraklar>> rastgeleGetir()async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM bayrak ORDER BY RANDOM() LIMIT 15");
    return List.generate(maps.length, (i) {
      var satir=maps[i];
      return Bayraklar(satir["Bayrak_ID"], satir["Bayrak_Ad"], satir["Bayrak_Resim"]);
    });

  }

  Future<List<Bayraklar>> rastgeleYanlisGetir(int bayrak_ID)async{
    var db=await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM bayrak WHERE Bayrak_ID != $bayrak_ID ORDER BY RANDOM() LIMIT 3");
    return List.generate(maps.length, (i) {
      var satir=maps[i];
      return Bayraklar(satir["Bayrak_ID"], satir["Bayrak_Ad"], satir["Bayrak_Resim"]);
    });

  }
}