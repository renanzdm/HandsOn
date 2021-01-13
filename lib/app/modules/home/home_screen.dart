import 'package:flutter/material.dart';
import 'package:handson/app/modules/loja/presenter/pages/menu_store/menu_screens/store_screen.dart';
import 'package:handson/app/shared/widgets/bottom_app_bar_custom.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageSelected = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloactingActionButton(),
        bottomNavigationBar: FABBottomAppBar(
          onTabSelected: (index) {
            setState(() {
              pageSelected = index;
            });
            _pageController.jumpToPage(pageSelected);

          },
          selectedColor: Colors.red.shade400,
          centerItemText: '',
          notchedShape: CircularNotchedRectangle(),
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.store, text: 'Loja'),
            FABBottomAppBarItem(
                iconData: Icons.list_alt_rounded, text: 'Pedidos'),
            FABBottomAppBarItem(
                iconData: Icons.fastfood_rounded, text: 'Receitas'),
          ],
        ),
        body: PageView(
          pageSnapping: false,
          physics: NeverScrollableScrollPhysics(),

          controller: _pageController,
          children: [
            Container(
              color: Colors.green,
            ),
            StoreScreen(),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFloactingActionButton() => FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.red.shade400,
      child: Transform.rotate(
        angle: 0.3,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/apple.png'),
        ),
      ),
    );
