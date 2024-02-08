import 'package:flutter/material.dart';
import 'package:veritabani/notlar//maiin.dart';
import 'package:veritabani/notlar/Notlardao.dart';

class NotKayitSayfa extends StatefulWidget {


  @override
  State<NotKayitSayfa> createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {
  var tfDersAdi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();
  Future<void> kayit(String ders_adi, int not1, int not2) async{
    await Notlardao().notEkle(ders_adi, not1, not2);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Not Kayıt"),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          kayit(tfDersAdi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));

        },
        tooltip: 'Not Kayıt',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),



    );
  }
}
