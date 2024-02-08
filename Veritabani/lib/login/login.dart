import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veritabani/login/pageA.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKulaniciAdi = sp.getString("KullaniciAdi") ?? "Kullanıcı Adı Yok!";
    String spSifre = sp.getString("Sifre") ?? "Sifre Yok!";
    if(spKulaniciAdi=="Admin" && spSifre=="123"){
      return true;

    }
    else{
      return false;

    }












  }
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:FutureBuilder<bool>(
        future: oturumKontrol(),
          builder: (context,snapshot){
          if(snapshot.hasData){
            bool gecisIzni= snapshot.data!;
              return gecisIzni ? LoginEkrani() : PageA();

          }
          else{
            return Container();
          }
          }
      ),
    );
  }
}
class LoginEkrani extends StatefulWidget {

  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}
class _LoginEkraniState extends State<LoginEkrani> {
  var tfkullaniciadi=TextEditingController();
  var tfsifre=TextEditingController();
  var ScaffoldKey=GlobalKey<ScaffoldState>();
  Future<void> girisKontrol() async{
    var ka=tfkullaniciadi.text;
    var s=tfsifre.text;

    if(ka=="admin" && s=="123"){
      var sp=await SharedPreferences.getInstance();
      sp.setString("KullaniciAdi", ka);
      sp.setString("Sifre", s);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PageA()));



    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Giriş Hatalı"),));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
          title: Text("Login Ekranı"),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfkullaniciadi,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),
              TextField(
                obscureText: true,
                controller: tfsifre,
                decoration: InputDecoration(
                  hintText: "Şifre",
                ),
              ),
              ElevatedButton(
                child: Text("Giriş Yap"),
                onPressed: (){
                  girisKontrol();


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),



    );



  }
}