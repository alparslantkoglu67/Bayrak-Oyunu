import 'package:flutter/material.dart';
import 'package:veritabani/Filmler/DetaySayfa.dart';
import 'package:veritabani/Filmler/FilmlerSayfa.dart';
import 'package:veritabani/Filmler/Kategoriler.dart';
import 'package:veritabani/Filmler/Kategorilerdao.dart';

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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  Future<List<Kategoriler>> tumKategorileriGoster() async{
    var kategoriListesi=await Kategorilerdao().tumKategoriler();
    return kategoriListesi;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Kategoriler"),
      ),
      body:FutureBuilder<List<Kategoriler>>(
          future: tumKategorileriGoster(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var kategoriListesi=snapshot.data;
              return ListView.builder(
                itemCount: kategoriListesi!.length,
                  itemBuilder: (context,indeks){
                  var kategori=kategoriListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FilmlerSayfa(kategori: kategori)));
                    },
                    child: Card(
                      child: SizedBox(height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                        ),
                      ),
                    ),
                  );
                  }
              );
            }
            else{
              return Center();
            }
          }
      ),



    );



  }
}