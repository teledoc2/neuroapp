import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _items = List.generate(50, (index) => 'Item $index');
  List<String> _filteredItems = [];
  String _sortOrder = 'Ascending';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items);
  }

  void _filterItems(String query) {
    try {
      setState(() {
        _errorMessage = '';
        _filteredItems = _items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (_sortOrder == 'Ascending') {
          _filteredItems.sort();
        } else {
          _filteredItems.sort((a, b) => b.compareTo(a));
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while filtering items.';
      });
    }
  }

  void _sortItems(String order) {
    setState(() {
      _sortOrder = order;
      if (order == 'Ascending') {
        _filteredItems.sort();
      } else {
        _filteredItems.sort((a, b) => b.compareTo(a));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search & Filter'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortItems,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Ascending', child: Text('Sort Ascending')),
              PopupMenuItem(value: 'Descending', child: Text('Sort Descending')),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _filterItems('');
                      },
                    ),
                  ),
                  onChanged: _filterItems,
                ),
                SizedBox(height: 16),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                Expanded(
                  child: _filteredItems.isEmpty
                      ? Center(child: Text('No items found'))
                      : ListView.builder(
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_filteredItems[index]),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
