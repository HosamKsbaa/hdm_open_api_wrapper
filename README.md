
## Overview
This document provides a strict and authoritative workflow for integrating APIs into your Flutter project using the HDM Open API Wrapper. Follow these instructions step-by-step to ensure proper implementation and consistency.

## Workflow

### Step 1: Check API Documentation
- Locate the API documentation or OpenAPI/Swagger specification. it will be in .dev\Api\openapi.json
- Ensure the API supports the required functionality (e.g., pagination).

### Step 2: Verify API Code in `lib/api`
- Check the `lib/api` folder for existing generated API code.
- If the code is missing, generate it using Swagger/OpenAPI tools.

### Step 3: Inspect Models
- Review the request and response models in the generated code.
- Understand the structure of the data you will be working with.

### Step 4: Initialize RestClient
- Use the `RestClient` object located in `lib/core/network/api_config.dart`.
- Initialize it with the base URL:

```dart
void initRestClient(String? baseUrl) {
  print("Changed URL to $baseUrl");
  Dio dio = Dio();
  dio.options.headers['ngrok-skip-browser-warning'] = '1'; // Any value
  restClient = RestClient(dio, baseUrl: baseUrl);
}
```

### Step 5: Build UI Components
- Create UI components that interact with the API.
- Use HDM Open API Wrapper widgets like `ApiButton`, `ApiSinglePage`, and `ApiInfiniteList`.

### Step 6: Handle Pagination Responsibly
- **Use Infinite Pages**: Only if the API explicitly supports pagination.
- **Avoid Infinite Pages**: If the API does not support pagination.

## Example Workflow

### Scenario: Fetch User Data

1. **Check API Documentation**:
   - Verify the endpoint `/users` supports pagination.

2. **Verify API Code**:
   - Locate `rest_client.dart` in `lib/api`.
   - Ensure the method `getUsers(int page, int size)` exists.

3. **Inspect Models**:
   - Review `User` and `PaginatedUserResponse` models.

4. **Initialize RestClient**:
   - Call `initRestClient('https://api.example.com')` during app initialization.

5. **Build UI Components**:
   - Use `ApiInfiniteList` for paginated user data:

```dart
ApiInfiniteList<PaginatedUserResponse, User>(
  requestFunction: (page, size) => restClient.getUsers(page, size),
  extractTheLIst: (response) => response.users,
  isFinished: (users) => users.length < 20,
  listViewBuilder: (context, users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) => ListTile(
      title: Text(users[index].name),
      subtitle: Text(users[index].email),
    ),
  ),
)
```

6. **Handle Pagination Responsibly**:
   - Use `ApiInfiniteList` only if `/users` supports pagination.
   - If not, use `ApiSinglePage` or `ApiButton` for simpler data fetching.

## Important Notes

- **RestClient Location**: Always use the `RestClient` object from `lib/core/network/api_config.dart`.
- **Pagination Support**: Verify API support before using infinite scrolling.
- **Strict Order**: Follow the workflow step-by-step to ensure proper implementation.

## Error Handling

The package automatically handles common error scenarios:
- Network errors
- API response validation
- User-friendly error messages
- Automatic error notifications

When an error occurs, the package will:
1. Set the state to error
2. Display an appropriate error message
3. Allow the user to retry the operation

## Architecture Integration

This package fits into Clean Architecture by:
- **Presentation Layer**: Widgets and UI components
- **Domain Layer**: State management and business logic
- **Data Layer**: API error checking and response handling

Use it in your presentation layer to handle API interactions while keeping your domain and data layers clean.

## API Integration with Swagger/OpenAPI

This package is designed to work seamlessly with Swagger/OpenAPI generated code using Retrofit. Here's how the API integration works:

### API Setup and Configuration

The package uses a `RestClient` that is generated from OpenAPI/Swagger documentation:

```dart
late RestClient restClient;

void initRestClient(String? baseUrl) {
  print("Changed URL to $baseUrl");
  Dio dio = Dio();
  dio.options.headers['ngrok-skip-browser-warning'] = '1'; // Any value
  restClient = RestClient(dio, baseUrl: baseUrl);
}
```

### How It Works

1. **OpenAPI Document**: Start with an OpenAPI/Swagger specification document
2. **Code Generation**: Use swagger codegen/openapi-generator to create Retrofit-based Dart code
3. **Generated Code Location**: All generated API code is placed in the `api/` folder
4. **RestClient Access**: Access API endpoints through `restClient.methodName()`

### Generated API Structure

The generated code typically includes:
- **Models**: Data classes representing API request/response objects
- **RestClient**: Main API client with all endpoint methods
- **Endpoints**: Individual API calls as methods on the RestClient

### Using Generated API with HDM Wrapper

Here's how to integrate generated Swagger/OpenAPI code with HDM Open API Wrapper:

#### Example 1: Using Generated API with ApiButton
```dart
// Assuming you have a generated method: restClient.createUser(UserRequest request)
ApiButton<UserResponse>(
  requestFunction: () => restClient.createUser(userRequest),
  onSuccess: (response) {
    HDMMsg.showSnackBar(
      title: 'Success',
      message: 'User created successfully',
      contentType: ContentType.success,
    );
  },
  buttonStyle: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  idleWidget: (style) => ElevatedButton(
    onPressed: null,
    style: style,
    child: Text('Create User'),
  ),
)
```

#### Example 2: Using Generated API with ApiSinglePage
```dart
// Assuming you have a generated method: restClient.getUserById(int id)
ApiSinglePage<UserDetails>(
  requestFunction: () => restClient.getUserById(userId),
  child: (context, userDetails) => Column(
    children: [
      Text('Name: ${userDetails.name}'),
      Text('Email: ${userDetails.email}'),
      Text('Phone: ${userDetails.phone}'),
    ],
  ),
)
```

#### Example 3: Using Generated API with ApiInfiniteList
```dart
// Assuming you have a generated method: restClient.getUsers(int page, int size)
ApiInfiniteList<PaginatedUserResponse, User>(
  requestFunction: (pageNumber, pageSize) => 
    restClient.getUsers(pageNumber, pageSize),
  extractTheLIst: (response) => response.users, // Extract list from paginated response
  isFinished: (users) => users.length < 20, // Check if last page
  listViewBuilder: (context, users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) => UserListTile(user: users[index]),
  ),
)
```

### Best Practices for API Integration

1. **Initialize Once**: Call `initRestClient()` once in your app initialization
2. **Use Service Classes**: Wrap generated API calls in service classes for better organization
3. **Handle Base URL Changes**: The package supports dynamic base URL changes
4. **Error Handling**: The HDM wrapper automatically handles API errors through `ApiErrorChecker`
5. **Type Safety**: Use proper generic types with your generated models

### Generated Code Structure Example

```
api/
├── models/
│   ├── user.dart
│   ├── create_user_request.dart
│   ├── user_response.dart
│   └── paginated_user_response.dart
├── rest_client.dart
└── rest_client.g.dart (generated)
```

### Accessing Generated API Methods

After initialization, access any generated API method like this:
```dart
// GET /users/{id}
final userResponse = await restClient.getUserById(123);

// POST /users
final createResponse = await restClient.createUser(userRequest);

// GET /users?page=1&size=20
final usersResponse = await restClient.getUsers(1, 20);

// PUT /users/{id}
final updateResponse = await restClient.updateUser(123, updateRequest);

// DELETE /users/{id}
final deleteResponse = await restClient.deleteUser(123);
```

All these methods return `HttpResponse<T>` objects that work seamlessly with the HDM Open API Wrapper widgets and utilities.
