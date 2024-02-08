import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veritabani/login/login.dart';

class PageA extends StatefulWidget {





  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  late String spKulaniciAdi;
  late String spSifre;

  Future<void> oturumBilgiOku() async{
    var sp=await SharedPreferences.getInstance();
    setState(() {
      spKulaniciAdi=sp.getString("KullaniciAdi")?? "Kullanıcı Adı Yok!";
      spSifre=sp.getString("Sifre") ?? "Sifre Yok!";
    });








  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("KullaniciAdi");
    sp.remove("Sifre");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginEkrani()));
  }
@override
  void initState() {
    oturumBilgiOku();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.deepPurple,
    title: Text("Anasayfa", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              onPressed: (){
                cikisYap();

              },
              icon: Icon(Icons.exit_to_app),
            )

          ],

    ),
    body:Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Kullanıcı Adı:$spKulaniciAdi",style: TextStyle(fontSize: 25),),
          Text("Şifre:$spSifre",style: TextStyle(fontSize: 25),),
        ],
      ),
    ),
    );
  }
}



