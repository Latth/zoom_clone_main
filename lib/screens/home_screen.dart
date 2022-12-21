import 'package:flutter/material.dart';
import 'package:zoom_clone_main/resources/auth_methods.dart';
import 'package:zoom_clone_main/screens/history_meeting_screen.dart';
import 'package:zoom_clone_main/screens/meetings_screen.dart';
import 'package:zoom_clone_main/utils/colors.dart';
import 'package:zoom_clone_main/widgets/custom_login_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  onPageChanged(int newPage) {
    setState(() {
      _page = newPage;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    const Text("Contact"),
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomLoginButton(
            text: 'Sign Out', function: () => AuthMethods().signOut()),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: pages[_page],
      bottomNavigationBar: customBottomNavBar(),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: const Text("Meet & Chat"),
      centerTitle: true,
    );
  }

  BottomNavigationBar customBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: footerColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: onPageChanged,
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.comment_bank), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.lock_clock), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ""),
      ],
    );
  }
}
