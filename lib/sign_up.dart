 import 'dart:ffi';

import 'package:flutter/material.dart';

import 'db.dart';
import 'login.dart';

class ArtWorkSignUp extends StatefulWidget {
  const ArtWorkSignUp({Key? key}) : super(key: key);

  @override
  State<ArtWorkSignUp> createState() => _ArtWorkSignUpState();
}

class _ArtWorkSignUpState extends State<ArtWorkSignUp> {
  GlobalKey<FormState> _formkey = GlobalKey<
      FormState>(); //***********************************************-2 global anahtar tanımlıyoruz

  //***********Controller need to check password*********************************>>> Şifreleri kontrol etmek için ;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
//****************************girilen tuşları gizlemek için oluşturuldu*********************>>>> obscure1
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure =true;
  //-*-*-*-*-*-*-*-*-*-*-*-*-*-*-DATABASE-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-DATABASE
  Db database = Db();//********************dahile ettik ve "database" isimli bir instance oluşturduk DATABASE-1

  @override
  void initState() {
    database.open();//*-------------------database açtık --------------**************-----------------------DATABASE2
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/sign.jpg"), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 600,
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
                "Sign Up",
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
                      nameTextFormField(),
                      emailTextFormField(),
                      passwordTextFormField(),
                      confirmPasswordTextFormField(),
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
                      onPressed: () async {
                        // sign up butonuna basıldığında bütün verileri kontrol et ve login page e götür
                        if (_formkey.currentState!.validate()) {
                          //*********************************database kayıt işlemi yaptığımız kısım*******************************>>>>>>>>>>>>>DATABASE3
                          await database.db!.rawInsert(""
                              "INSERT INTO artworks(username,email,password) VALUES (?,?,?);",[
                             _username.text,
                            _email.text,
                            _password.text,
                          ]);

                          ScaffoldMessenger.of(context).showSnackBar(//************************************>>>>>>>>>>>> KAYIT EDİLDİĞİNİ GÖSTEREN BİLDİRİM YAZIYORUZ
                            SnackBar(
                              content: Text(
                                "user data added to Database",
                                style: TextStyle(
                                  color: Colors.amber
                                ),
                              ),
                            )
                          );

                          // *************************************************************************************ESKİ KULLANICI BİLGİLERİ GÖSTERİLMESİN DİYE BOŞ TANIMLIYORUZ

                          _username.text = '';
                          _email.text = '';
                          _password.text = '';
                          _confirmPassword.text ='';


                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ArtWorkLogin()),
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
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
                        //******if user click on this button navigate to Login Page******************************>> Giriş sayfasına yönlendir
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ArtWorkLogin()));
                      },
                      child: Text(
                        "I have an Account",
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

  Widget confirmPasswordTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          validator: (String? value) {
            //boş mu dolu mu kontrol et
            if (value!.isEmpty) {
              return "please confirm your password";
            }
            // passwordtext ile eşleşmesini kontrol et
            else if (_password.text != _confirmPassword.text) {
              return "password to not match,please try again";
            }
            return null;
          },
          controller: _confirmPassword,
          cursorColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
          //***********textstyle***********
          style: TextStyle(
            color: Color.fromARGB(255, 24, 54, 10),
            fontSize: 13,
          ),
          obscureText: isConfirmPasswordObscure,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            hintStyle: TextStyle(fontSize: 14),
            //******************Hide Icon *******************************************
            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  isConfirmPasswordObscure = !isConfirmPasswordObscure;
                });
              },
              child: isConfirmPasswordObscure ? Icon(
                Icons.visibility_off,
                size: 16,
              ) : Icon(Icons.visibility,
              size: 16,)
            ),
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
          obscureText: isPasswordObscure,//*********hide text***********************************
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(fontSize: 14),
            //******************Hide Icon *******************************************
            // if user click on this button hide password
            suffixIcon: GestureDetector(
              onTap: (){
                //************** USE obscure************
                setState(() {
                  isPasswordObscure = !isPasswordObscure;
                });
              },
              child: isPasswordObscure ? Icon(
                Icons.visibility_off,
                size: 16,
              ) : Icon(Icons.visibility,size: 16,)
            ),
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
  Widget nameTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          controller: _username,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please provide a name"; //**************************************check if name field is empty
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
            hintText: "username",
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
