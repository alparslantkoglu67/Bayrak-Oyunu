import 'package:flutter/material.dart';
import 'package:veritabani/bayrakquiz/Main.dart';

class SonucEkrani extends StatefulWidget {
  int dogrusayisi;


  SonucEkrani({required this.dogrusayisi});

  @override
  State<SonucEkrani> createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Sonuç Ekranı",style: TextStyle(color: Colors.white),),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Doğru Sayısı :${widget.dogrusayisi}   Yanlış Sayısı:${15-widget.dogrusayisi}",style: TextStyle(fontSize: 25),),

            Text("%${((widget.dogrusayisi*100)/15).toInt()} Başarı Oranı",style: TextStyle(fontSize: 30,color: Colors.pinkAccent),),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                child: Text("Tekrar Dene"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}
