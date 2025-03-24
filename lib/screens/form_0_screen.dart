import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsletterSignupScreen extends StatefulWidget {
  @override
  _NewsletterSignupScreenState createState() =>
      _NewsletterSignupScreenState();
}

class _NewsletterSignupScreenState extends State<NewsletterSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSubscribed = false;
  bool _newsletterChecked = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://neureveal.ai/'),
        body: {
          'form_fields[field_eb37685]': _newsletterChecked ? 'true' : 'false',
          'form_fields[email]': _emailController.text,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _isSubscribed = true;
        });
      } else {
        _showErrorDialog('Failed to submit. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newsletter Signup'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CheckboxListTile(
                      title: Text('Newsletter'),
                      value: _newsletterChecked,
                      onChanged: (value) {
                        setState(() {
                          _newsletterChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    if (!_newsletterChecked)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'You must agree to subscribe to the newsletter.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required.';
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    if (_isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: _newsletterChecked ? _submitForm : null,
                        child: Text('Submit'),
                      ),
                    if (_isSubscribed)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'You have successfully subscribed to the newsletter!',
                          style: TextStyle(color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
