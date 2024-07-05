import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/mainpage.dart';
import '../register.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    //lấy token (lưu share_preference)
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("accountID", accountController.text);
    String token = await APIRepository()
        .login(accountController.text, passwordController.text);
    var user = await APIRepository().current(token);
    // save share
    saveUser(user, token);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/just-wear-it-favicon-black.png',
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: accountController,
                    decoration: const InputDecoration(
                      labelText: "Account",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.password),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the border radius to zero
                            ),
                          ),
                        ),
                        onPressed: login,
                        child: const Text("Login"),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: FilledButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the border radius to zero
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text("Register"),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
