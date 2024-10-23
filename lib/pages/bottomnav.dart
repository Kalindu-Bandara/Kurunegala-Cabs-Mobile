import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sofrwere_project/pages/Order.dart';
import 'package:sofrwere_project/pages/home.dart';
import 'package:sofrwere_project/pages/profile.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;

  late Home Homepage;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    //first function
    Homepage = Home();
    order = Order();
    profile = Profile();
    pages = [Homepage, order, profile];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(microseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items: [
        Icon(
          Icons.home_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.person_outlined,
          color: Colors.white,
        )
      ]),
      body: pages[currentTabIndex],
    );
  }
}
