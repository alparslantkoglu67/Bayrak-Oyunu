import 'package:flutter/material.dart';
import 'package:veritabani/sozluk/DetaySayfa.dart';
import 'package:veritabani/sozluk/Kelimeler.dart';
import 'package:veritabani/sozluk/Kelimelerdao.dart';

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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
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
  Future<List<Kelimeler>>tumKelimelerGoster()async{
    var kelimelerListesi=await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;

  }
  Future<List<Kelimeler>>aramaYap(String aramaKelimesi)async{
    var kelimelerListesi=await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [

          aramaYapiliyormu ?
          IconButton(
            onPressed: (){
              setState(() {
                aramaYapiliyormu=false;
                aramaKelimesi="";
              });
            },
            icon: Icon(Icons.cancel),)
              :IconButton(
            onPressed: (){
              setState(() {
                aramaYapiliyormu=true;
              });
            },
            icon: Icon(Icons.search),)
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: aramaYapiliyormu ? TextField(
          decoration: InputDecoration(
            hintText: "Arama İçin Bir Şey Yazın",
          ),
          onChanged: (aramaSonucu){
            print("Arama Sonucu: $aramaSonucu");
            setState(() {
              aramaKelimesi=aramaSonucu;
            });

          },
        ):
        Text("Sözlük Uygulaması"),
      ),
      body:FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyormu ? aramaYap(aramaKelimesi): tumKelimelerGoster(),
          builder: (context, snapshot){
          if(snapshot.hasData){
            var kelimelerListesi=snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi!.length,
              itemBuilder: (context,indeks){
                var kelime=kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kelime: kelime)));
                  },
                  child: SizedBox(
                    height:50 ,
                    child: Card(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(kelime.turkce,style: TextStyle(fontWeight: FontWeight.bold),),
                        ],

                      ),
                    ),
                  ),
                );
              },
            );

          }else{
            return Center();
          }
          }
      ),



    );



  }
}