import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'FutureButton.dart';
import 'NewFutButton.dart';

/// Example usage of both FutureButton and ApiButton
class ButtonUsageExample extends StatelessWidget {
  const ButtonUsageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('FutureButton Example (Generic)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Example 1: FutureButton with String response
            FutureButton<String>(
              requestFunction: () async {
                await Future.delayed(const Duration(seconds: 2));
                return "Hello from Future!";
              },
              onSuccess: (response) {
                print('String response: $response');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success: $response')));
              },
              idleWidget: (buttonStyle) => ElevatedButton(style: buttonStyle, onPressed: null, child: const Text('Call String Future')),
              buttonStyle: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            // Example 2: FutureButton with int response
            FutureButton<int>(
              requestFunction: () async {
                await Future.delayed(const Duration(seconds: 1));
                return 42;
              },
              onSuccess: (response) {
                print('Int response: $response');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success: $response')));
              },
              responseValidator: (response) => response > 0, // Custom validation
              idleWidget: (buttonStyle) => ElevatedButton(
                style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: null,
                child: const Text('Call Int Future', style: TextStyle(color: Colors.white)),
              ),
              buttonStyle: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 40),

            const Text('ApiButton Example (HTTP Response)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Example 3: ApiButton (specialized for HTTP responses)
            ApiButton<Map<String, dynamic>>(
              requestFunction: () async {
                // Simulate an HTTP response
                await Future.delayed(const Duration(seconds: 1));
                return HttpResponse<Map<String, dynamic>>({'message': 'API call successful', 'userId': 123}, Response(requestOptions: RequestOptions(path: '/test'), statusCode: 200));
              },
              onSuccess: (response) {
                print('API response: $response');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('API Success: ${response['message']}')));
              },
              idleWidget: (buttonStyle) => ElevatedButton(
                style: buttonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: null,
                child: const Text('Call API', style: TextStyle(color: Colors.white)),
              ),
              buttonStyle: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Key Differences:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text(
              '• FutureButton: Works with any Future<T> type (parent class)\n'
              '• ApiButton: Extends FutureButton, specialized for HttpResponse<T>\n'
              '• ApiButton inherits all FutureButton functionality + adds API validation\n'
              '• No code duplication - clean inheritance pattern',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of a custom data class for FutureButton
class UserData {
  final String name;
  final int age;

  UserData({required this.name, required this.age});

  @override
  String toString() => 'UserData(name: $name, age: $age)';
}

// Example with custom class
class CustomDataExample extends StatelessWidget {
  const CustomDataExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureButton<UserData>(
      requestFunction: () async {
        await Future.delayed(const Duration(seconds: 1));
        return UserData(name: 'Ahmed', age: 25);
      },
      onSuccess: (userData) {
        print('User data received: $userData');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User: ${userData.name}, Age: ${userData.age}')));
      },
      idleWidget: (buttonStyle) => ElevatedButton(style: buttonStyle, onPressed: null, child: const Text('Load User Data')),
      buttonStyle: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
