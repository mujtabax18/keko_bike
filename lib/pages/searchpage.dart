import 'package:flutter/material.dart';
import 'package:keko_bike/utili/widgets/CatagoriesDropDown.dart';
import 'package:keko_bike/utili/widgets/CustomBottomNavigationBar.dart';
import 'package:keko_bike/pages/home_page.dart';

class SearchPage extends StatefulWidget {
  static String id = 'SearchPage';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _navSelectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: SizedBox(
            height: 80,
            child: Image.asset('assets/logo/logo.png'),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _navSelectedIndex,
        onTap: (a) {
          _navSelectedIndex = a;
          if (_navSelectedIndex == 0) {
            Navigator.pushNamed(context, HomePage.id);
          }
        },
      ),
      body: Container(),
    ));
  }
}
