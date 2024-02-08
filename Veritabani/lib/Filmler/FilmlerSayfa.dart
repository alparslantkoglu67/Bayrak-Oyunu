import 'package:flutter/material.dart';
import 'package:veritabani/Filmler/DetaySayfa.dart';
import 'package:veritabani/Filmler/Filmler.dart';
import 'package:veritabani/Filmler/Filmlerdao.dart';
import 'package:veritabani/Filmler/Kategoriler.dart';
import 'package:veritabani/Filmler/Yonetmenler.dart';

class FilmlerSayfa extends StatefulWidget {
  Kategoriler kategori;


  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  Future<List<Filmler>> fimleriGoster(int kategori_id) async{
    var filmlerListesi=await Filmlerdao().tumFilmlerByKategoriID(widget.kategori.kategori_id);

    return filmlerListesi;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("${widget.kategori.kategori_ad}"),
      ),
      body:FutureBuilder<List<Filmler>>(
        future:fimleriGoster(widget.kategori.kategori_id),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var filmlerListesi=snapshot.data;
            return GridView.builder(
              itemCount: filmlerListesi!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/3.5,

                ),
                itemBuilder: (context,indeks){
                var film=filmlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(film: film)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 250,
                              width: 300,
                              child: Image.asset("resimler/filmler/${film.film_resim}")),
                        ),
                        Text(film.film_ad,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ),
                );
                }
            );

          }else{
            return Center();
          }
        },
      ),



    );
  }
}
