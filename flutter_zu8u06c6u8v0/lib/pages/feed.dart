import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/video_provider.dart'; // Adjust this import as necessary
import 'package:flutter_app/providers/video.dart'; // Adjust this import as necessary
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_app/pages/ViewProf.dart';
import 'package:flutter_app/pages/search.dart';
import 'package:flutter_app/widgets/botnav.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedPage> {
  final TextEditingController _searchController = TextEditingController();
  final String hintText = 'Search...';

  @override
  void initState() {
    super.initState();
    // Load video data when the page initializes
    Future.microtask(() =>
        Provider.of<VideoProvider>(context, listen: false).loadJsonData());
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideoProvider>(context).videoData;
    

    return Scaffold(
      body: videoData == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(color: Color.fromRGBO(51, 51, 51, 1)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.8,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: _buildUserInfo(videoData.data.uploader),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: _buildStats(videoData.data),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: BottomNav(),
                  ),
                  Positioned(
                    top: 3,
                    left: 0,
                    right: 0,
                    child: _buildSearchBar(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildUserInfo(String username) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildUserProfile(username),
        SizedBox(height: 10),
        _buildOriginalSoundText(),
      ],
    );
  }

  Widget _buildUserProfile(String username) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildUsername(username),
        SizedBox(width: 15),
        _buildFollowButton(),
      ],
    );
  }

  Widget _buildUsername(String username) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewProfPage()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          SizedBox(width: 5),
          Text(
            username,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: 10,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFollowButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Center(
        child: Text(
          'Follow',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 8,
            height: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildOriginalSoundText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Boxicons.bx_music, color: Colors.white, size: 16),
        SizedBox(width: 10),
        Text(
          'Original Sound',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String formatCount(int count) {
  if (count >= 1000) {
    return (count / 1000).toStringAsFixed(1) + 'K'; // 1 decimal place
  }
  return count.toString();
}

  Widget _buildStats(VideoData videoData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatIcon(Boxicons.bx_heart, formatCount(videoData.likeCount)),
        SizedBox(height: 20),
        _buildStatIcon(Boxicons.bx_message_rounded_dots, formatCount(videoData.commentCount)),
        SizedBox(height: 20),
        _buildStatIcon(Boxicons.bx_bookmark, formatCount(videoData.bookmarkCount)),
        SizedBox(height: 20),
        _buildStatIcon(Boxicons.bx_share, formatCount(videoData.shareCount)),
      ],
    );
  }

  Widget _buildStatIcon(IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white),
        SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _navigateToSearchResults(value);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSearchResults(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(query: query),
      ),
    );
  }
}
