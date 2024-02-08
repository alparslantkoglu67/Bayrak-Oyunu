import 'package:flutter/material.dart';
import 'package:veritabani/Filmler/Filmler.dart';

class DetaySayfa extends StatefulWidget {
  Filmler film;


  DetaySayfa({required this.film});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.film.film_ad),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: 250,
                width: 300,
                child: Image.asset("resimler/filmler/${widget.film.film_resim}")),
            Text(widget.film.film_ad,style: TextStyle(fontSize: 25,color: Colors.blue),),
            Text("Yıl: ${widget.film.film_yil}",style: TextStyle(fontSize: 15,)),
            Text("Kategori: ${widget.film.kategori.kategori_ad}",style: TextStyle(fontSize: 15,)),
            Text("Yönetmen: ${widget.film.yonetmen.yonetmen_ad}",style: TextStyle(fontSize: 15,)),
          ],
        ),
      ),



    );
  }
}
