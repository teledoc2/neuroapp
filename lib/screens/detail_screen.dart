import 'package:flutter/material.dart';

class DetailViewScreen extends StatefulWidget {
  final String contentId;

  const DetailViewScreen({Key? key, required this.contentId}) : super(key: key);

  @override
  _DetailViewScreenState createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  Map<String, dynamic>? _contentDetails;

  @override
  void initState() {
    super.initState();
    _fetchContentDetails();
  }

  Future<void> _fetchContentDetails() async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _contentDetails = {
          'title': 'Sample Content Title',
          'description': 'This is a detailed description of the content.',
          'author': 'Author Name',
          'date': 'October 10, 2023',
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Failed to load content.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchContentDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (_contentDetails == null) {
            return const Center(
              child: Text('No content available.'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contentDetails!['title'],
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                Text(
                  'By ${_contentDetails!['author']} - ${_contentDetails!['date']}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 16),
                Text(
                  _contentDetails!['description'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
