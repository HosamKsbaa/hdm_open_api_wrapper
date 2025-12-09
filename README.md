# HDM Open API Wrapper

**A production-ready Flutter package for streamlined API integration, state management, and user feedback.**

This package wraps `Dio` networking with powerful UI components (`ApiButton`, `ApiInfiniteList`) that automatically handle loading, success, and error states. It also standardizes user feedback via Snackbars and simplifies infinite pagination.

---

## 🚀 Features

*   **Smart State Management**: Widgets that automatically switch between loading, success, and error UIs based on `Future` results.
*   **Infinite Pagination**: `ApiInfiniteList` handles page fetching, duplicate filtering, and "load more" scrolling logic out of the box.
*   **Standardized Feedback**: Global access to toast/snackbar notifications via `hdmMsg`.
*   **Robust Networking**: Built on top of `Dio`, with centralized error handling for standard HTTP codes (401, 500, etc.).
*   **Developer Friendly**: Type-safe generic components and comprehensive logging.

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  hdm_open_api_wrapper: ^0.1.7
```

Then import it:

```dart
import 'package:hdm_open_api_wrapper/hdm_open_api_wrapper.dart';
```

---

## 🛠 Usage Guide

### 1. Initialization
Call `HOAW.setLogger` early in your `main.dart` to route package logs to your preferred logging solution (or just print them). Initialize your `RestClient` (API wrapper) strategies here as well.

```dart
void main() {
  // Optional: Connect package logs to your Logger
  HOAW.setLogger((message, mode, trace) {
    print("[$mode] $message");
    if (trace != null) print(trace);
  });
  
  runApp(MyApp());
}
```

### 2. ApiButton (Async Actions)
Use `ApiButton` for any action that requires a network request (POST/PUT/DELETE). It handles the `isLoading` state, disables the button, and shows success/error feedback automatically.

```dart
ApiButton<UserResponse>(
  // 1. The async function to execute
  requestFunction: () => restClient.createUser(userRequest),
  
  // 2. Callback on success
  onSuccess: (response) {
    hdmMsg.showSnackBar(
      title: 'Success',
      message: 'User ${response.name} created!',
      contentType: ContentType.success,
    );
    // Optional: Navigate away
    Navigator.pop(context);
  },
  
  // 3. (Optional) Custom Validator
  responseValidator: (response) => response.id != null,
  
  // 4. Styling
  buttonStyle: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
  
  // 5. Idle Widget Builder
  idleWidget: (style) => ElevatedButton(
    onPressed: null, // ApiButton handles the tap
    style: style,
    child: Text('Create Account'),
  ),
)
```

### 3. ApiInfiniteList (Pagination)
Render paginated lists effortlessly.

```dart
ApiInfiniteList<PaginatedResponse, User>(
  // 1. Fetch function (page is 1-based)
  requestFunction: (page, size) => restClient.getUsers(page, size),
  
  // 2. Extract List<T> from ResponseObj
  extractTheLIst: (response) => response.data ?? [],
  
  // 3. Stop condition
  isFinished: (users) => users.length < 20,
  
  // 4. Item Builder
  listViewBuilder: (context, users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => UserTile(user: users[index]),
    );
  },
)
```

### 4. Direct Feedback (Snackbars)
Use `hdmMsg` anywhere in your app (no context needed if setup correctly, otherwise usage inside widgets is safe).

```dart
hdmMsg.showSnackBar(
  title: 'Alert',
  message: 'Something went wrong!',
  contentType: ContentType.failure, // success, warning, failure, help
);
```

---

## 🤖 Instructions for AI Assistants (ChatGPT/Copilot)

**Use these rules when generating code for this project:**

1.  **Always use `hdmMsg`**: Never use `ScaffoldMessenger.of(context)` directly. Use `hdmMsg.showSnackBar(...)`.
2.  **Input Sanitation**: Ensure `ApiButton`'s `requestFunction` returns a `Future`.
3.  **Pagination**: When asked for a list view, prefer `ApiInfiniteList` over standard `ListView.builder` if the data is paginated from an API.
4.  **Error Handling**: Do not manually wrap `ApiButton` calls in `try/catch`. The widget handles exceptions and logs them via `HdmLogger`.
5.  **Imports**: Always use the main barrel file: 
    `import 'package:hdm_open_api_wrapper/hdm_open_api_wrapper.dart';`
6.  **Naming**: Reference widgets by their correct class names:
    *   `ApiButton` (not `FutureButton`)
    *   `ApiInfiniteList` (not `PageWithMore`)
    *   `hdmMsg` (not `HdmMsg`)

---

## License

MIT License. See [LICENSE](LICENSE) for details.
