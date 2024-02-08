import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:veritabani/bayrakquiz/Bayraklar.dart';
import 'package:veritabani/bayrakquiz/Bayraklardao.dart';
import 'package:veritabani/bayrakquiz/sonucEkrani.dart';

class QuizEkrani extends StatefulWidget {


  @override
  State<QuizEkrani> createState() => _QuizEkraniState();
}

class _QuizEkraniState extends State<QuizEkrani> {
  var sorular=<Bayraklar>[];
  var yanlissecenekler=<Bayraklar>[];
  late Bayraklar dogrusoru;
  var tumsecenekler=HashSet<Bayraklar>();

  int soruSayac=0;
  int dogruSayac=0;
  int yanlisSayac=0;
  String resim_Adi="placeholder.png";
  String butona_Yazi="";
  String butonb_Yazi="";
  String butonc_Yazi="";
  String butond_Yazi="";
  @override
  void initState() {

    sorulariAl();


    }
  Future<void> sorulariAl() async{
    sorular=await Bayraklardao().rastgeleGetir();
    sorulariYukle();
  }
  Future<void> sorulariYukle() async{
    dogrusoru=sorular[soruSayac];
    resim_Adi=dogrusoru.Bayrak_resim;
    yanlissecenekler=await Bayraklardao().rastgeleYanlisGetir(dogrusoru.Bayrak_id);
    tumsecenekler.clear();
    tumsecenekler.add(dogrusoru);
    tumsecenekler.add(yanlissecenekler[0]);
    tumsecenekler.add(yanlissecenekler[1]);
    tumsecenekler.add(yanlissecenekler[2]);
    butona_Yazi=tumsecenekler.elementAt(0).Bayrak_ad;
    butonb_Yazi=tumsecenekler.elementAt(1).Bayrak_ad;
    butonc_Yazi=tumsecenekler.elementAt(2).Bayrak_ad;
    butond_Yazi=tumsecenekler.elementAt(3).Bayrak_ad;
    setState(() {

    });

  }
  void sorusayacKontrol(){
    soruSayac=soruSayac+1;
    if(soruSayac!=15){
      sorulariYukle();
    }else{

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SonucEkrani(dogrusayisi:dogruSayac,)));
    }
  }
  void dogrukontrol(String butonYazi){
    if(dogrusoru.Bayrak_ad==butonYazi){
      dogruSayac=dogruSayac+1;

    }else{
      yanlisSayac=yanlisSayac+1;

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Quiz Ekranı",style: TextStyle(color: Colors.white),),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru: $dogruSayac",style: TextStyle(fontSize: 18,color: Colors.white),),
                Text("Yanlış: $yanlisSayac",style: TextStyle(fontSize: 18,color: Colors.white),),

              ],
            ),
            soruSayac !=15 ? Text("${soruSayac+1}. Soru",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),):Text("15. Soru",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width:350,
                  height: 250,
                  child: Image.asset("resimler/bayraklar/$resim_Adi")),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogrukontrol(butona_Yazi);
                  sorusayacKontrol();


                },
                child: Text("$butona_Yazi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogrukontrol(butonb_Yazi);
                  sorusayacKontrol();

                },
                child: Text("$butonb_Yazi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogrukontrol(butonc_Yazi);
                  sorusayacKontrol();

                },
                child: Text("$butonc_Yazi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  dogrukontrol(butond_Yazi);
                  sorusayacKontrol();

                },
                child: Text("$butond_Yazi"),
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
