
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi{
  static final String veriTabaniAdi="sozluk.db";
  static Future<Database> veritabaniErisim()async{
    String veritabaniYolu=join(await getDatabasesPath(), veriTabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("Veri tabanı zaten var kopyalamaya gerek yok!");
    }
    else{
      ///assetten veri tabanın alınması
      ByteData data= await rootBundle.load("veritabani/$veriTabaniAdi");
      ///veri tabanının kopyalanması için byte'a donusmesi
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush:true);
      print("Veri Tabanı Kopyalandı");
    }
    return openDatabase(veritabaniYolu);
  }
}