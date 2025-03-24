// Abstract Repository Interface
abstract class FormRepository {
  Future<void> submitNewsletterSignupForm({
    required bool newsletter,
    required String email,
  });
}

// Domain Exceptions
class FormValidationException implements Exception {
  final String message;
  FormValidationException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}

// Concrete Implementation
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormRepositoryImpl implements FormRepository {
  final http.Client apiClient;

  FormRepositoryImpl(this.apiClient);

  @override
  Future<void> submitNewsletterSignupForm({
    required bool newsletter,
    required String email,
  }) async {
    // Validation
    if (!newsletter) {
      throw FormValidationException("Newsletter checkbox is required.");
    }
    if (email.isEmpty || !_isValidEmail(email)) {
      throw FormValidationException("A valid email is required.");
    }

    // API Request
    final url = Uri.parse("https://neureveal.ai/");
    final body = {
      "form_fields[field_eb37685]": newsletter ? "on" : "",
      "form_fields[email]": email,
    };

    try {
      final response = await apiClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode != 200) {
        throw NetworkException(
            "Failed to submit form. Status code: ${response.statusCode}");
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw NetworkException("Network error occurred: ${e.message}");
      } else {
        throw UnknownException("An unknown error occurred.");
      }
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }
}

// Usage Example
void main() async {
  final apiClient = http.Client();
  final formRepository = FormRepositoryImpl(apiClient);

  try {
    await formRepository.submitNewsletterSignupForm(
      newsletter: true,
      email: "test@example.com",
    );
    print("Form submitted successfully!");
  } catch (e) {
    if (e is FormValidationException) {
      print("Validation error: ${e.message}");
    } else if (e is NetworkException) {
      print("Network error: ${e.message}");
    } else if (e is UnknownException) {
      print("Unknown error: ${e.message}");
    }
  } finally {
    apiClient.close();
  }
}
