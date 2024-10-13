// Material
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/under_cons.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

//Pages
import 'package:flutter_app/pages/courses.dart';
import 'package:flutter_app/pages/feed.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildBottomNavigation(MediaQuery.of(context).size.width, context);
  }

  Widget _buildBottomNavigation(double width, BuildContext context) {
    return Container(
      height : 43,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(context, Boxicons.bx_home, 'Home', FeedPage()),
          _buildNavItem(context, Boxicons.bx_book, 'My Courses', CoursePage()),
          _buildNavItem(context, Boxicons.bx_message, 'Inbox', UnderCons()),
          _buildNavItem(context, Boxicons.bx_user, 'Profile', UnderCons()),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(icon, color: Color.fromRGBO(86, 63, 232, 1)),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}