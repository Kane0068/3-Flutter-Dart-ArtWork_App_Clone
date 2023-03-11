import 'package:flutter/material.dart';
import 'package:flutter_artwork/bottom_nav.dart';
import 'package:flutter_artwork/sign_up.dart';

import 'db.dart';
import 'home_page.dart';

class ArtWorkLogin extends StatefulWidget {
  const ArtWorkLogin({Key? key}) : super(key: key);

  @override
  State<ArtWorkLogin> createState() => _ArtWorkLoginState();
}

class _ArtWorkLoginState extends State<ArtWorkLogin> {
  GlobalKey<FormState> _formkey = GlobalKey<
      FormState>(); //***********************************************-2 global anahtar tanımlıyoruz

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isPasswordObscure =
      true; //*******************HİDE PASSWORD*******************************

  List<Map> userList = [];
  Db database = Db();

  @override
  void initState() {
    database.open();
    getuserData();
    super.initState();
  }

  void getuserData(){
    Future.delayed(Duration(seconds: 1),() async {
      userList = await database.db!.rawQuery("SELECT *FROM artworks");
      setState(() {});
      print(userList);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/sign.jpg"), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                child: Form(
                  //***************************************************************** 1- bilgilerin girildiği yer
                  key: _formkey,
                  child: Column(
                    children: [
                      emailTextFormField(),
                      passwordTextFormField(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 55,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 29, 66, 20),
                              Color.fromARGB(255, 45, 96, 22),
                              Color.fromARGB(255, 119, 241, 68)
                            ])),
                    child: TextButton(
                      onPressed: () {
                        //############################KARŞILAŞTIRMA YAPACAĞIZ DATABASEDE VARSA GİR YOKSA UYARI BASTIR#################COMPARE EMAİL,PASSWORD,USERNAME
                        //### 1-KARŞILAŞTIRMAK İÇİN DEĞİŞKEN TANIMLIYORUZ SONRA DATABASEDEN VERİLERİ ÇEKMEMİZ GEREKİYOR
                        String? email;
                        String? password;
                        String? username;

                        // 2---DATABASE VERİ ÇEKİMİ

                        var userData = userList
                            .where((user) => (user["email"] == _email.text))
                            .toList();

                        for (var user in userData) {
                          email = user["email"];
                          password = user["password"];
                          username = user["username"];
                        }

                        print(email);
                        print(password);
                        print(username);

                        if (_formkey.currentState!.validate()) {

                          // **********ŞİFRELERİ DOĞRULAMA YAPACAZ************

                          if(_email.text == email){
                            //parola doğru şimdi password karşılaştır
                            if(_password.text == password){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ArtWorkBottomNavBar(username :username!)));
                            }else if(_password.text != _password){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.amber,
                                  content: Text(
                                    "invalid password,please try again"
                                  ),
                                )
                              );
                            }
                          }
                            else if(_email.text != email){
                            //Scaffold Message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.amber,
                                content: Text(
                                  "user does not exist,signup first and please try again",
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 29, 66, 20),
                              Color.fromARGB(255, 45, 96, 22),
                              Color.fromARGB(255, 119, 241, 68),
                            ]),
                        border: Border.all(width: 1.5, color: Colors.white)),
                    child: TextButton(
                      onPressed: () {
                        //******if user click on this button navigate to Signup Page******************************>> Giriş sayfasına yönlendir
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ArtWorkSignUp()));
                      },
                      child: Text(
                        "I don't have an Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          controller: _password,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "please provide a password";
            } else if (value.length >= 8) {
              return "password should not exceed 8 characters";
            }
            return null;
          },
          cursorColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
          //***********textstyle***********
          style: TextStyle(
            color: Color.fromARGB(255, 24, 54, 10),
            fontSize: 17,
          ),
          obscureText:
              isPasswordObscure, //*********hide text***********************************
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(fontSize: 14),
            //******************Hide Icon *******************************************
            // if user click on this button hide password
            suffixIcon: GestureDetector(
                onTap: () {
                  //************** USE obscure************
                  setState(() {
                    isPasswordObscure = !isPasswordObscure;
                  });
                },
                child: isPasswordObscure
                    ? Icon(
                        Icons.visibility_off,
                        size: 16,
                      )
                    : Icon(
                        Icons.visibility,
                        size: 16,
                      )),
            isDense: true,
            filled:
                true, //**************************************arkaplan içini doldur
            fillColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
            //****************border**************************>>>>>>>>>>>>>>>>>>>>>>>>>>>> kenarlıklar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
        ),
      );

  Widget emailTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          controller: _email,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "please provide an e-mail";
            } else if (!value.contains("@")) {
              return "please enter valid email adresss";
            }
            return null;
          },
          cursorColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
          //***********textstyle***********
          style: TextStyle(
            color: Color.fromARGB(255, 24, 54, 10),
            fontSize: 17,
          ),
          decoration: InputDecoration(
            hintText: "E-mail",
            hintStyle: TextStyle(fontSize: 14),
            isDense: true,
            filled:
                true, //**************************************arkaplan içini doldur
            fillColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
            //****************border**************************>>>>>>>>>>>>>>>>>>>>>>>>>>>> kenarlıklar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
        ),
      );
}
