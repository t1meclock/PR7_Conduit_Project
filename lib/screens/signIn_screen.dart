import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/url.dart';
import '../models/user.dart';
import '../screens/user_sceen.dart';
import '../screens/signUp_screen.dart';
import '../interceptors/custom_interceptor.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  SharedPreferences? sharedPreferences;
  Dio DIO = Dio();

  Future<void> initSharedPreferences() async => sharedPreferences = await SharedPreferences.getInstance();

  void setTokenSharedPreferences(String token) async => await sharedPreferences!.setString('token', token);

  Future<void> auth() async {
    try {
      String userName = controllerUsername.text;
      String password = controllerPassword.text;

      DIO.interceptors.add(CustomInterceptor());

      Response response = await DIO.post(URL.token.value, data: User(userName: userName, password: password));
      setTokenSharedPreferences(response.data['data']['accessToken']);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserScreen()));
    } on DioError {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный логин или пароль', textAlign: TextAlign.center)));
    }
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 103, 189),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
              child: Center(
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerUsername,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 63, 57, 102))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Логин",
                      ),
                    ),
                      const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 20)),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 63, 57, 102))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Пароль",
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom( 
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 63, 57, 102),
                    ),
                    onPressed: () async => auth(), child: 
                    const Text("Войти")),
                    const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 5)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom( 
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 63, 57, 102),
                    ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                      child: const Text("Зарегистрироваться"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
