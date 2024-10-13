import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/botnav.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(initialQuery: query),
            SizedBox(height: 16.0), // Add space between the search bar and results
            Column(
              children: List.generate(
                20,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildResultCard(),
                    buildResultCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  Widget buildResultCard() {
    return Container(
      width: 120,
      height: 215.33,
      margin: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: Color(0xFFF2F0FD),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF270FBF)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final String initialQuery;

  const SearchBar({Key? key, required this.initialQuery}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String _searchText = '';
  List<String> _suggestions = [
    'Search suggestion 1',
    'Search suggestion 2',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _searchText = widget.initialQuery; // Set initial query here
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Adjust width
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFF2F0FD),
        border: Border.all(color: Color(0xFF270FBF)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: _focusNode,
            cursorColor: _isFocused ? Color(0xFF2810BF) : Color(0xFF333333),
            style: TextStyle(color: Color(0xFF333333)),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: _isFocused ? Color(0xFF2810BF) : Color(0xFFA99BFF),
              ),
              border: InputBorder.none,
              hintText: 'Search...',
              hintStyle: TextStyle(color: Color(0xFF333333)),
            ),
            onChanged: (text) {
              setState(() {
                _searchText = text;
              });
            },
            controller: TextEditingController(text: _searchText),
          ),
          if (_isFocused && _searchText.isNotEmpty)
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 8.0), // Add top margin for spacing
              child: Column(
                children: _suggestions.map((suggestion) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchText = suggestion;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        suggestion,
                        style: TextStyle(color: Color(0xFF333333)),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFF270FBF),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
