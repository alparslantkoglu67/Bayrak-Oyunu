import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veritabani/Kisiler/KisiDetay.dart';
import 'package:veritabani/Kisiler/KisiKayit.dart';
import 'package:veritabani/Kisiler/Kisiler.dart';
import 'package:veritabani/Kisiler/Kisilerdao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home:Anasayfa(),
    );
  }
}
class Anasayfa extends StatefulWidget {

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}
class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyormu=false;
  String aramaKelimesi="";
  Future<List<Kisiler>> tumKisilerGoster() async{
    var kisilerListesi=await Kisilerdao().tumKisiler();
    return kisilerListesi;

  }
  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async{
    var kisilerListesi=await Kisilerdao().kisiArama(aramaKelimesi);
    return kisilerListesi;

  }
  Future<bool> uygulamayiKapat() async{
    await exit(0);

  }
  Future<void> sil(int kisi_id) async{
    await Kisilerdao().kisiSil(kisi_id);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              uygulamayiKapat();
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          aramaYapiliyormu ? IconButton(
          onPressed: (){
          setState(() {
            aramaYapiliyormu=false;
            aramaKelimesi="";
          });

          },
              icon: Icon(Icons.cancel))

              :IconButton(
              onPressed: (){
                setState(() {
                  aramaYapiliyormu=true;
                });
              },
              icon: Icon(Icons.search)),
        ],
        backgroundColor: Colors.red,
        title: aramaYapiliyormu ? TextField(
          decoration: InputDecoration(hintText: "Aramak istediğiniz şeyi yazın.."),
          onChanged: (aramasonucu){
            print("Arama sonucu: $aramasonucu");
            setState(() {
              aramaKelimesi=aramasonucu;
            });

          },
        )
            : Text("Kişiler Uygulaması",style: TextStyle(color: Colors.white),),
      ),
      body: WillPopScope(

        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Kisiler>>(
    future: aramaYapiliyormu ? aramaYap(aramaKelimesi) : tumKisilerGoster(),
    builder: (context,snapshot){
        if(snapshot.hasData){
          var kisilerListesi=snapshot.data;
          return ListView.builder(
            itemCount: kisilerListesi!.length,
              itemBuilder: (context,indeks){
              var kisi=kisilerListesi[indeks];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetay(kisi: kisi)));
                },
                child: Card(



                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,



                      children: [
                        Text(kisi.kisi_ad,style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(kisi.kisi_tel.toString()),
                        IconButton(
                          onPressed: (){
                            sil(kisi.kisi_id);
                          },
                          icon: Icon(Icons.delete,color: Colors.grey),
                        )

                      ],
                    ),
                  ),
                ),
              );
              }
          );

        }else{
          return Center();
        }

    }
    ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => KisiKayit()));

        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),



    );




  }
}