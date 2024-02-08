import 'package:flutter/material.dart';
import 'package:veritabani/Kisiler/Kisiler.dart';
import 'package:veritabani/Kisiler/Kisilerdao.dart';
import 'package:veritabani/Kisiler/mainKisiler.dart';

class KisiDetay extends StatefulWidget {
  Kisiler kisi;


  KisiDetay({required this.kisi});

  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
  var tfKisiAdi=TextEditingController();
  var tfKisiTel=TextEditingController();
  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async{
    await Kisilerdao().kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var kisi=widget.kisi;
    tfKisiAdi.text=kisi.kisi_ad;
    tfKisiTel.text=kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

        backgroundColor: Colors.red,
        title: Text("Kişi Detay",style: TextStyle(color: Colors.white)),
    ),
    body:Center(
      child: Padding(
        padding: const EdgeInsets.only(left:50,right: 50),
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
          guncelle(widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);


        },
        tooltip: 'Kişi Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }
}
