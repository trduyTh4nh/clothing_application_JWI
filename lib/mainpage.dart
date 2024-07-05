import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tuan08/app/model/user.dart';
import 'package:tuan08/app/page/detail.dart';
import 'package:tuan08/app/route/page1.dart';
import 'package:tuan08/app/route/page2.dart';
import 'package:tuan08/app/route/page3.dart';
import 'package:tuan08/components/cart.dart';
import 'package:tuan08/components/favorite.dart';
import 'package:tuan08/components/hisotry.dart';
import 'package:tuan08/components/home.dart';
import 'app/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
    print(user.imageURL);
  }

  List<Widget> _pages = [HomePage(), HisotryPage(), CartPage(), Detail()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Image.asset('assets/images/just-wear-it-favicon-black.png'),
          actions: [
            Badge(
              label: Text("1"),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritePage()));
                },
                icon: const Icon(Icons.favorite))
          ]),
      drawer: Drawer(
        child: IconTheme(
          data: const IconThemeData(color: Colors.black),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                curve: Curves.bounceInOut,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user.imageURL!.length < 5
                        ? const SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  user.imageURL!,
                                )),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(user.fullName!),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('History'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 1;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Cart'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 2;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.pages),
                title: const Text('Page1'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page1()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.pages),
                title: const Text('Page2'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page2()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.pages),
                title: const Text('Page3'),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page3()));
                },
              ),
              const Divider(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              user.accountId == ''
                  ? const SizedBox()
                  : ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Logout'),
                      onTap: () {
                        logOut(context);
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 4, 4, 4),
        unselectedItemColor: Color.fromARGB(255, 193, 193, 193),
        onTap: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
