import 'package:flutter/material.dart';
import 'package:veritabani/Kisiler/Kisilerdao.dart';
import 'package:veritabani/Kisiler/mainKisiler.dart';

class KisiKayit extends StatefulWidget {


  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {
  var tfKisiAdi=TextEditingController();
  var tfKisiTel=TextEditingController();
  Future<void> kayit(String kisi_ad,String kisi_tel) async{
    await Kisilerdao().kisiEkle(kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Kişi Kayıt",style: TextStyle(color: Colors.white)),
    ),
    body:Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 50,right: 50),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Kisi Ad"),
          controller: tfKisiAdi,
        ),
        TextField(
          decoration: InputDecoration(hintText: "Kisi Tel"),
          controller: tfKisiTel,
        ),
      ],
      ),
    ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          kayit(tfKisiAdi.text, tfKisiTel.text);


        },
        tooltip: 'Kişi Kayıt',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
