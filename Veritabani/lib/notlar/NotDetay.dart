import 'package:flutter/material.dart';
import 'package:veritabani/notlar/maiin.dart';
import 'package:veritabani/notlar/Notlar.dart';
import 'package:veritabani/notlar/Notlardao.dart';

class NotDetay extends StatefulWidget {
  Notlar not;


  NotDetay({required this.not});

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var tfDersAdi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();

  Future<void> sil(int not_id) async{
    await Notlardao().notSil(not_id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  Future<void> guncelle(String ders_adi, int not1, int not2, int not_id) async{
    await Notlardao().notGuncelle(not_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }
  @override
  void initState() {
    var not=widget.not;
    tfDersAdi.text=not.ders_adi;
    tfnot1.text=not.not1.toString();
    tfnot2.text=not.not2.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: (){
                sil(widget.not.not_id);
              },
              child: Text("Sil",style: TextStyle(color: Colors.white),)
          ),
          TextButton(
              onPressed: (){
                guncelle(tfDersAdi.text, int.parse(tfnot2.text), int.parse(tfnot2.text), widget.not.not_id);
              },
              child: Text("Güncelle",style: TextStyle(color: Colors.white),)),
        ],
        title: Text("Not Detay",style: TextStyle(color: Colors.white),),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(hintText: "1.Not"),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(hintText: "2.Not"),
              ),
            ],
          ),
        ),
      ),




    );
  }
}
