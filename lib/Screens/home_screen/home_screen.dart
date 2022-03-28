// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/About/edit_about.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/edit_home.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/event_screen.dart';
import 'package:nemycraft_admin/Screens/notifications_screen.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        height: size.height * 0.08,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: FontAwesomeIcons.pencilAlt, title: 'About'),
          TabItem(icon: Icons.folder, title: 'Events'),
          TabItem(icon: Icons.contact_page, title: 'Notifications'),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 600),
            curve: Curves.fastLinearToSlowEaseIn,
          );
        },
      ),
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            EditHomePage(),
            EditAboutPage(),
            EventScreen(),
            NotificationsScreen()
          ],
        ),
        // child: PersistentTabView(
        //   context,

        //   // controller: _controller,
        //   screens: _buildScreens(),
        //   items: _navBarsItems(),
        //   confineInSafeArea: true,
        //   backgroundColor: Colors.brown,
        //   handleAndroidBackButtonPress: true,
        //   resizeToAvoidBottomInset: true,
        //   stateManagement: true,

        //   navBarHeight: size.height * 0.09,
        //   hideNavigationBarWhenKeyboardShows: true,
        //   margin: EdgeInsets.all(0.0),
        //   popActionScreens: PopActionScreensType.all,
        //   bottomScreenMargin: 0.0,
        //   onWillPop: (context) async {
        //     await showDialog(
        //       context: context!,
        //       useSafeArea: true,
        //       builder: (context) => Container(
        //         height: 150.0,
        //         width: 50.0,
        //         color: Colors.green,
        //         child: ElevatedButton(
        //           child: Text("Close"),
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //         ),
        //       ),
        //     );
        //     return false;
        //   },
        //   // selectedTabScreenContext: (context) {
        //   //   testContext = context;
        //   // },
        //   // hideNavigationBar: _hideNavBar,
        //   decoration: NavBarDecoration(
        //       colorBehindNavBar: Colors.indigo,
        //       borderRadius: BorderRadius.circular(5.0)),
        //   popAllScreensOnTapOfSelectedTab: true,
        //   itemAnimationProperties: ItemAnimationProperties(
        //     duration: Duration(milliseconds: 400),
        //     curve: Curves.ease,
        //   ),
        //   screenTransitionAnimation: ScreenTransitionAnimation(
        //     animateTabTransition: true,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 200),
        //   ),
        //   navBarStyle:
        //       NavBarStyle.style16, // Choose the nav bar style with this property
        // ),
      ),
    );
  }

  // List<Widget> _buildScreens() {
  //   return [
  //     //!GET ALL THE WRITINGS(ABOUT US, CONTACT US) ON THE WEBSITE HERE
  //     EditContents(),
  //     //  SignUpPage(),
  //     StartUp(),
  //     //?TODO: ADD FOLDER PAGE AS LAST PAGE HERE
  //     SignUpPage(),
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home),
  //       title: ("HOME"),
  //       activeColorPrimary: Colors.blue,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(
  //         FontAwesomeIcons.plus,
  //         color: Colors.white,
  //       ),
  //       title: ("POST"),
  //       activeColorPrimary: Colors.blue,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.folder),
  //       title: ("EVENTS"),
  //       activeColorPrimary: Colors.blue,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //   ];
  // }
}
