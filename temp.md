## 🧭 Flutter Project Structure & Standards



## Interaction Guidelines

**Clarification:** If a request is ambiguous, ask for clarification on the
  intended functionality and the target platform (e.g., command-line, web,
  server).
  **Dependencies:** When suggesting new dependencies from `pub.dev`, explain
  their benefits.
  **Formatting:** Use the `dart_format` tool to ensure consistent code
  formatting.
  **Fixes:** Use the `dart_fix` tool to automatically fix many common errors,
  and to help code conform to configured analysis options.
  **Linting:** Use the Dart linter with a recommended set of rules to catch
  common issues. Use the `analyze_files` tool to run the linter.
## Flutter style guide
**SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code.
  Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex
  widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially
  `StatelessWidget`) should be immutable.
* **State Management:** Separate ephemeral state and app state. Use a state
  management solution for app state to handle the separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose
  complex UIs from smaller, reusable widgets.


  ## Package Management
**Pub Tool:** To manage packages, use the `pub` tool, if available.
* **External Packages:** If a new feature requires an external package, use the
  `pub_dev_search` tool, if it is available. Otherwise, identify the most
  suitable and stable package from pub.dev.
* **Adding Dependencies:** To add a regular dependency, use the `pub` tool, if
  it is available. Otherwise, run `flutter pub add <package_name>`.
* **Adding Dev Dependencies:** To add a development dependency, use the `pub`
  tool, if it is available, with `dev:<package name>`. Otherwise, run `flutter
  pub add dev:<package_name>`.
* **Dependency Overrides:** To add a dependency override, use the `pub` tool, if
  it is available, with `override:<package name>:1.0.0`. Otherwise, run `flutter
  pub add override:<package_name>:1.0.0`.
* **Removing Dependencies:** To remove a dependency, use the `pub` tool, if it
  is available. Otherwise, run `dart pub remove <package_name>`.
## Code Quality
* **Code structure:** Adhere to maintainable code structure and separation of
  concerns (e.g., UI logic separate from business logic).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent,
  descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining
  clear.
* **Simplicity:** Write straightforward code. Code that is clever or
  obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your
  code fail silently.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for
      members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Functions short and with a single purpose (strive for less than 20 lines).
## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines
  (https://dart.dev/effective-dart)
* **Class Organization:** Define related classes within the same library file.
  For large libraries, export smaller, private libraries from a single top-level
  library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs,
  including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid
  over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous
  operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null
  safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the
  code.
* **Records:** Use records to return multiple types in situations where defining
  an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or
  expressions, which don't require `break` statements.
* **Exception Handling:** Use `try-catch` blocks for handling exceptions, and
  use exceptions appropriate for the type of exception. Use custom exceptions
  for situations specific to your code.
* **Arrow Functions:** Use arrow syntax for simple one-line functions.
## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when
  the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing
  ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private
  helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable
  private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to
  create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` to run expensive calculations in a separate
  isolate to avoid blocking the UI thread, such as JSON parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()`
  methods whenever possible to reduce rebuilds.
## API Design Principles
When building reusable APIs, such as a library, follow these principles.

* **Consider the User:** Design APIs from the perspective of the person who will
  be using them. The API should be intuitive and easy to use correctly.
* **Documentation is Essential:** Good documentation is a part of good API
  design. It should be clear, concise, and provide examples.

## Application Architecture
* **Separation of Concerns:** Aim for separation of concerns similar to MVC/MVVM, with defined Model,
  View, and ViewModel/Controller roles.


  ## Lint Rules

Include the package in the `analysis_options.yaml` file. Use the following
analysis_options.yaml file as a starting point:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Add additional lint rules here:
    # avoid_print: false
    # prefer_single_quotes: true
```
## Visual Design & Theming
* **UI Design:** Build beautiful and intuitive user interfaces that follow
  modern design guidelines.
* **Responsiveness:** Ensure the app is mobile responsive and adapts to
  different screen sizes, working perfectly on mobile and web.
* **Navigation:** If there are multiple pages for the user to interact with,
  provide an intuitive and easy navigation bar or controls.
* **Typography:** Stress and emphasize font sizes to ease understanding, e.g.,
  hero text, section headlines, list headlines, keywords in paragraphs.
* **Background:** Apply subtle noise texture to the main background to add a
  premium, tactile feel.
* **Shadows:** Multi-layered drop shadows create a strong sense of depth; cards
  have a soft, deep shadow to look "lifted."
* **Icons:** Incorporate icons to enhance the user’s understanding and the
  logical navigation of the app.
* **Interactive Elements:** Buttons, checkboxes, sliders, lists, charts, graphs,
  and other interactive elements have a shadow with elegant use of color to
  create a "glow" effect.

### Theming
* **Centralized Theme:** Define a centralized `ThemeData` object to ensure a
  consistent application-wide style.
* **Light and Dark Themes:** Implement support for both light and dark themes,
  ideal for a user-facing theme toggle (`ThemeMode.light`, `ThemeMode.dark`,
  `ThemeMode.system`).
* **Color Scheme Generation:** Generate harmonious color palettes from a single
  color using `ColorScheme.fromSeed`.

  ```dart
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    // ... other theme properties
  );
  ```
* **Color Palette:** Include a wide range of color concentrations and hues in
  the palette to create a vibrant and energetic look and feel.
* **Component Themes:** Use specific theme properties (e.g., `appBarTheme`,
  `elevatedButtonTheme`) to customize the appearance of individual Material
  components.
* **Custom Fonts:** For custom fonts, use the `google_fonts` package. Define a
  `TextTheme` to apply fonts consistently.

  ```dart
  // 1. Add the dependency
  // flutter pub add google_fonts

  // 2. Define a TextTheme with a custom font
  final TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.openSans(fontSize: 14),
  );
  ```
  ### Assets and Images
* **Image Guidelines:** If images are needed, make them relevant and meaningful,
  with appropriate size, layout, and licensing (e.g., freely available). Provide
  placeholder images if real ones are not available.
* **Asset Declaration:** Declare all asset paths in your `pubspec.yaml` file.

    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/images/
    ```

* **Local Images:** Use `Image.asset` for local images from your asset
  bundle.

    ```dart
    Image.asset('assets/images/placeholder.png')
    ```
* **Network images:** Use NetworkImage for images loaded from the network.
* **Cached images:** For cached images, use NetworkImage a package like
  `cached_network_image`.
* **Custom Icons:** Use `ImageIcon` to display an icon from an `ImageProvider`,
  useful for custom icons not in the `Icons` class.
* **Network Images:** Use `Image.network` to display images from a URL, and
  always include `loadingBuilder` and `errorBuilder` for a better user
  experience.

    ```dart
    Image.network(
      'https://picsum.photos/200/300',
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    )
    ```
## UI Theming and Styling Code

* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
* **Text Fields:** Configure `textCapitalization`, `keyboardType`, and
* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
  remote images.

```dart
// When using network images, always provide an errorBuilder.
Image.network(
  'https://example.com/image.png',
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error); // Show an error icon
  },
);
```

## Material Theming Best Practices

### Embrace `ThemeData` and Material 3

* **Use `ColorScheme.fromSeed()`:** Use this to generate a complete, harmonious
  color palette for both light and dark modes from a single seed color.
* **Define Light and Dark Themes:** Provide both `theme` and `darkTheme` to your
  `MaterialApp` to support system brightness settings seamlessly.
* **Centralize Component Styles:** Customize specific component themes (e.g.,
  `elevatedButtonTheme`, `cardTheme`, `appBarTheme`) within `ThemeData` to
  ensure consistency.
* **Dark/Light Mode and Theme Toggle:** Implement support for both light and
  dark themes using `theme` and `darkTheme` properties of `MaterialApp`. The
  `themeMode` property can be dynamically controlled (e.g., via a
  `ChangeNotifierProvider`) to allow for toggling between `ThemeMode.light`,
  `ThemeMode.dark`, or `ThemeMode.system`.

```dart
// main.dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  home: const MyHomePage(),
);
```

### Implement Design Tokens with `ThemeExtension`

For custom styles that aren't part of the standard `ThemeData`, use
`ThemeExtension` to define reusable design tokens.

* **Create a Custom Theme Extension:** Define a class that extends
  `ThemeExtension<T>` and include your custom properties.
* **Implement `copyWith` and `lerp`:** These methods are required for the
  extension to work correctly with theme transitions.
* **Register in `ThemeData`:** Add your custom extension to the `extensions`
  list in your `ThemeData`.
* **Access Tokens in Widgets:** Use `Theme.of(context).extension<MyColors>()!`
  to access your custom tokens.

```dart
// 1. Define the extension
@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({required this.success, required this.danger});

  final Color? success;
  final Color? danger;

  @override
  ThemeExtension<MyColors> copyWith({Color? success, Color? danger}) {
    return MyColors(success: success ?? this.success, danger: danger ?? this.danger);
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      success: Color.lerp(success, other.success, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }
}

// 2. Register it in ThemeData
theme: ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    MyColors(success: Colors.green, danger: Colors.red),
  ],
),

// 3. Use it in a widget
Container(
  color: Theme.of(context).extension<MyColors>()!.success,
)
```

### Styling with `WidgetStateProperty`

* **`WidgetStateProperty.resolveWith`:** Provide a function that receives a
  `Set<WidgetState>` and returns the appropriate value for the current state.
* **`WidgetStateProperty.all`:** A shorthand for when the value is the same for
  all states.

```dart
// Example: Creating a button style that changes color when pressed.
final ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.green; // Color when pressed
      }
      return Colors.red; // Default color
    },
  ),
);
```

## Layout Best Practices

### Building Flexible and Overflow-Safe Layouts

#### For Rows and Columns

* **`Expanded`:** Use to make a child widget fill the remaining available space
  along the main axis.
* **`Flexible`:** Use when you want a widget to shrink to fit, but not
  necessarily grow. Don't combine `Flexible` and `Expanded` in the same `Row` or
  `Column`.
* **`Wrap`:** Use when you have a series of widgets that would overflow a `Row`
  or `Column`, and you want them to move to the next line.

#### For General Content

* **`SingleChildScrollView`:** Use when your content is intrinsically larger
  than the viewport, but is a fixed size.
* **`ListView` / `GridView`:** For long lists or grids of content, always use a
  builder constructor (`.builder`).
* **`FittedBox`:** Use to scale or fit a single child widget within its parent.
* **`LayoutBuilder`:** Use for complex, responsive layouts to make decisions
  based on the available space.

### Layering Widgets with Stack

* **`Positioned`:** Use to precisely place a child within a `Stack` by anchoring it to the edges.
* **`Align`:** Use to position a child within a `Stack` using alignments like `Alignment.center`.

### Advanced Layout with Overlays

* **`OverlayPortal`:** Use this widget to show UI elements (like custom
  dropdowns or tooltips) "on top" of everything else. It manages the
  `OverlayEntry` for you.

  ```dart
  class MyDropdown extends StatefulWidget {
    const MyDropdown({super.key});

    @override
    State<MyDropdown> createState() => _MyDropdownState();
  }

  class _MyDropdownState extends State<MyDropdown> {
    final _controller = OverlayPortalController();

    @override
    Widget build(BuildContext context) {
      return OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (BuildContext context) {
          return const Positioned(
            top: 50,
            left: 10,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('I am an overlay!'),
              ),
            ),
          );
        },
        child: ElevatedButton(
          onPressed: _controller.toggle,
          child: const Text('Toggle Overlay'),
        ),
      );
    }
  }
  ```

## Color Scheme Best Practices

### Contrast Ratios

* **WCAG Guidelines:** Aim to meet the Web Content Accessibility Guidelines
  (WCAG) 2.1 standards.
* **Minimum Contrast:**
    * **Normal Text:** A contrast ratio of at least **4.5:1**.
    * **Large Text:** (18pt or 14pt bold) A contrast ratio of at least **3:1**.

### Palette Selection

* **Primary, Secondary, and Accent:** Define a clear color hierarchy.
* **The 60-30-10 Rule:** A classic design rule for creating a balanced color scheme.
    * **60%** Primary/Neutral Color (Dominant)
    * **30%** Secondary Color
    * **10%** Accent Color

### Complementary Colors

* **Use with Caution:** They can be visually jarring if overused.
* **Best Use Cases:** They are excellent for accent colors to make specific
  elements pop, but generally poor for text and background pairings as they can
  cause eye strain.

### Example Palette

* **Primary:** #0D47A1 (Dark Blue)
* **Secondary:** #1976D2 (Medium Blue)
* **Accent:** #FFC107 (Amber)
* **Neutral/Text:** #212121 (Almost Black)
* **Background:** #FEFEFE (Almost White)

## Font Best Practices

### Font Selection

* **Limit Font Families:** Stick to one or two font families for the entire
  application.
* **Prioritize Legibility:** Choose fonts that are easy to read on screens of
  all sizes. Sans-serif fonts are generally preferred for UI body text.
* **System Fonts:** Consider using platform-native system fonts.
* **Google Fonts:** For a wide selection of open-source fonts, use the
  `google_fonts` package.

### Hierarchy and Scale

* **Establish a Scale:** Define a set of font sizes for different text elements
  (e.g., headlines, titles, body text, captions).
* **Use Font Weight:** Differentiate text effectively using font weights.
* **Color and Opacity:** Use color and opacity to de-emphasize less important
  text.

### Readability

* **Line Height (Leading):** Set an appropriate line height, typically **1.4x to
  1.6x** the font size.
* **Line Length:** For body text, aim for a line length of **45-75 characters**.
* **Avoid All Caps:** Do not use all caps for long-form text.

### Example Typographic Scale

```dart
// In your ThemeData
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
  bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
  labelSmall: TextStyle(fontSize: 11.0, color: Colors.grey),
),
```

## Documentation

* **`dartdoc`:** Write `dartdoc`-style comments for all public APIs.


### Documentation Philosophy

* **Comment wisely:** Use comments to explain why the code is written a certain
  way, not what the code does. The code itself should be self-explanatory.
* **Document for the user:** Write documentation with the reader in mind. If you
  had a question and found the answer, add it to the documentation where you
  first looked. This ensures the documentation answers real-world questions.
* **No useless documentation:** If the documentation only restates the obvious
  from the code's name, it's not helpful. Good documentation provides context
  and explains what isn't immediately apparent.
* **Consistency is key:** Use consistent terminology throughout your
  documentation.

### Commenting Style

* **Use `///` for doc comments:** This allows documentation generation tools to
  pick them up.
* **Start with a single-sentence summary:** The first sentence should be a
  concise, user-centric summary ending with a period.
* **Separate the summary:** Add a blank line after the first sentence to create
  a separate paragraph. This helps tools create better summaries.
* **Avoid redundancy:** Don't repeat information that's obvious from the code's
  context, like the class name or signature.
* **Don't document both getter and setter:** For properties with both, only
  document one. The documentation tool will treat them as a single field.

### Writing Style

* **Be brief:** Write concisely.
* **Avoid jargon and acronyms:** Don't use abbreviations unless they are widely
  understood.
* **Use Markdown sparingly:** Avoid excessive markdown and never use HTML for
  formatting.
* **Use backticks for code:** Enclose code blocks in backtick fences, and
  specify the language.

### What to Document

* **Public APIs are a priority:** Always document public APIs.
* **Consider private APIs:** It's a good idea to document private APIs as well.
* **Library-level comments are helpful:** Consider adding a doc comment at the
  library level to provide a general overview.
* **Include code samples:** Where appropriate, add code samples to illustrate usage.
* **Explain parameters, return values, and exceptions:** Use prose to describe
  what a function expects, what it returns, and what errors it might throw.
* **Place doc comments before annotations:** Documentation should come before
  any metadata annotations.

## Accessibility (A11Y)
Implement accessibility features to empower all users, assuming a wide variety
of users with different physical abilities, mental abilities, age groups,
education levels, and learning styles.

* **Color Contrast:** Ensure text has a contrast ratio of at least **4.5:1**
  against its background.
* **Dynamic Text Scaling:** Test your UI to ensure it remains usable when users
  increase the system font size.
* **Semantic Labels:** Use the `Semantics` widget to provide clear, descriptive
  labels for UI elements.

### 📁 Folder Layout (Clean Architecture + Feature-First)

- `assets/` — Images, fonts, icons, and other static assets

  - `images/` — App images, backgrounds, logos
  - `fonts/` — Custom fonts
  - `icons/` — SVGs, PNGs, etc.

- `test/` — All test files (unit, widget, integration)

  - `widget/` — Widget tests
  - `integration/` — Integration tests
  - `unit/` — Unit tests

- `docs/` — Project documentation and architecture notes

  - `gen/` — Generated docs for new features/components

- `setup/` — Scripts for setup, dependencies, and folder creation

  - `add_dependencies.sh` — Dependency install script
  - `create_folder_structure.sh` — Folder structure setup

- `lib/`

  - `AutoGen/` — All auto-generated code (never edit manually)

    - `api/` — API code generated from Swagger/OpenAPI specs

  - `core/` — App-wide setup: themes, routes, localization, logging, networking

    - `routes/` — Navigation setup (AutoRoute config)
    - `theme/` — Main theme definitions and extensions
    - `network/` — API client setup, interceptors, config
    - `localization/` — Localization and language files
    - `logging/` — Logging and error tracking setup
    - `Constants/` — App-wide constants and enums
    - `Helpers/` — Utility functions (no business logic)

  - `features/<feature>/`

    - `data/` — Data sources, API calls, repository implementations
    - `domain/` — Entities, use cases, abstract repositories
    - `presentation/` — UI, screens, state, widgets
      - `widgets/` — Atomic Design components (Atoms, Molecules, Organisms) specific to this feature.
        - `atoms/` - The smallest reusable widgets (e.g., custom buttons, text fields).
        - `molecules/` - Simple compositions of atoms (e.g., a search bar).
        - `organisms/` - Complex components made of atoms and molecules (e.g., a user profile card).
      - `<Sub Section>/` — The main pages/screens for the feature.

  - `shared/` — Cross-feature UI components, constants, helpers (no business logic)

    - `Style/` — Common UI styles (text, spacing, theme extensions)
    - `Widgets/` — **Globally-reusable** Atomic Design components (Atoms, Molecules, Organisms) used across multiple features.
        - `atoms/` - The smallest reusable widgets (e.g., custom buttons, text fields).
        - `molecules/` - Simple compositions of atoms (e.g., a search bar).
        - `organisms/` - Complex components made of atoms and molecules (e.g., a user profile card).
   
- Platform folders:
  - `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` — Platform-specific code and configs

---

### 🧱 Key Rules

- **Feature-First:** Each feature is isolated in its own folder
- **Clean Architecture:** Strict separation of data, domain, and presentation layers
- **No Shared Logic:** Only UI components in `shared/`, never business logic
- **AutoRoute for Navigation:** Always use AutoRoute, follow the workflow below

---

#### 🧱 Rules

- **Feature-First**: Each feature has its own folder.
- **Clean Architecture**: Follow the separation of concerns.
- **No Shared Logic**: Keep logic out of `shared/`—use it only for UI components.
- **Use AutoRoute for navigation**: Follow this exact workflow for navigation setup and usage.

## AutoRoute Implementation Workflow

### Step 1: Add @RoutePage() Annotation

- Add `@RoutePage()` annotation before EVERY page class
- Keep each page in its original folder structure
- DO NOT move pages to routes folder

```dart
@RoutePage()
class LoginPage extends StatefulWidget {
  // Your page implementation
}
```

### Step 2: Run Build Runner

- After adding @RoutePage() annotations, run:

```bash
flutter pub run build_runner build
```

- This generates route classes in `lib/core/routes/app_router.gr.dart`

### Step 3: Register Routes in AppRouter

- Add generated routes to the routes list in `lib/core/routes/app_router.dart`:

```dart
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: HomeRoute.page, path: '/home', initial: true),
    // Add your routes here
  ];
}
```

### Step 4: Import Missing Types

- If you get "type not found" errors, import the page files in `app_router.dart`:

```dart
import '../../features/auth/presentation/login_page.dart';
import '../../features/home/presentation/home_page.dart';
```

### Step 5: Use Navigation

- Navigate using the router context:

```dart
// Push new route
context.router.push(LoginRoute());

// Replace current route
context.router.replace(HomeRoute());

// Go back
context.router.maybePop();

// Clear stack and push (instead of pushAndClearStack)
context.router.pushAndPopUntil(
  LoginRoute(),
  predicate: (route) => false,
);
```

### Critical Navigation Rules:

- **NEVER use** `pushAndClearStack` - it doesn't exist in AutoRoute
- **USE** `pushAndPopUntil` with `predicate: (route) => false` for clearing stack
- **ALWAYS** import route files in `app_router.dart` if you get type errors
- **ALWAYS** run build_runner after adding new @RoutePage() annotations

### Advanced AutoRoute Usage

#### Nested Routes Example:

```dart
AutoRoute(
  path: '/dashboard',
  page: DashboardRoute.page,
  children: [
    AutoRoute(path: '/users', page: UsersRoute.page),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
  ],
);
```

#### Tab Navigation Example:

```dart
AutoTabsRouter(
  routes: const [
    UsersRoute(),
    SettingsRoute(),
  ],
  builder: (context, child) {
    final tabsRouter = AutoTabsRouter.of(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: const [
          BottomNavigationBarItem(label: 'Users', icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
        ],
      ),
    );
  },
);
```

#### Deep Linking Configuration:

```dart
MaterialApp.router(
  routerConfig: appRouter.config(
    deepLinkBuilder: (deepLink) {
      if (deepLink.path.startsWith('/products')) {
        return deepLink;
      } else {
        return DeepLink.defaultPath;
      }
    },
  ),
);
```

### Architecture Rules:

- No logic in UI/shared.
- Always follow `data/`, `domain/`, `presentation/` under each feature.
- Keep layers decoupled—no circular deps.
- Maintain existing functionality when editing.
- Use Apple Human Interface Guidelines for UI. Keep it modern, sleek, minimal. Use spring animations. Consider all screen sizes.

---

## 📱 Mandatory ScreenUtil Usage for Responsive Design

### 🎯 Critical Rule: ALWAYS Use ScreenUtil for All Sizing

**MANDATORY**: This project uses `flutter_screenutil` for responsive design. You MUST use responsive units for ALL sizing in any code you write or modify.

### 📏 Required Responsive Units

#### **Text Sizes** - ALWAYS use `.sp`

```dart
// ✅ CORRECT - Responsive text
Text('Hello', style: TextStyle(fontSize: 16.sp))
Text('Title', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold))

// ❌ WRONG - Fixed pixels
Text('Hello', style: TextStyle(fontSize: 16))
```

#### **Width/Height** - ALWAYS use `.w` and `.h`

```dart
// ✅ CORRECT - Responsive dimensions
Container(
  width: 200.w,
  height: 100.h,
  child: ...
)

// ❌ WRONG - Fixed pixels
Container(
  width: 200,
  height: 100,
  child: ...
)
```

#### **Padding/Margin/Spacing** - ALWAYS use `.r`

```dart
// ✅ CORRECT - Responsive spacing
EdgeInsets.all(16.r)
EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h)
SizedBox(height: 20.h)
Padding(padding: EdgeInsets.only(top: 12.h))

// ❌ WRONG - Fixed spacing
EdgeInsets.all(16)
SizedBox(height: 20)
```

#### **Border Radius** - ALWAYS use `.r`

```dart
// ✅ CORRECT - Responsive radius
BorderRadius.circular(12.r)
RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r))

// ❌ WRONG - Fixed radius
BorderRadius.circular(12)
```

### 🎨 Pre-defined Responsive Values

**ALWAYS USE** these predefined values from `ResponsiveValues` class when appropriate:

#### **Text Sizes**

```dart
fontSize: ResponsiveValues.smallText    // 12.sp
fontSize: ResponsiveValues.normalText   // 14.sp
fontSize: ResponsiveValues.mediumText   // 16.sp
fontSize: ResponsiveValues.largeText    // 18.sp
fontSize: ResponsiveValues.titleText    // 20.sp
fontSize: ResponsiveValues.headingText  // 24.sp
```

#### **Spacing**

```dart
padding: EdgeInsets.all(ResponsiveValues.smallSpacing)      // 8.r
padding: EdgeInsets.all(ResponsiveValues.normalSpacing)     // 16.r
padding: EdgeInsets.all(ResponsiveValues.largeSpacing)      // 24.r
padding: EdgeInsets.all(ResponsiveValues.extraLargeSpacing) // 32.r
```

#### **Border Radius**

```dart
borderRadius: BorderRadius.circular(ResponsiveValues.smallRadius)   // 8.r
borderRadius: BorderRadius.circular(ResponsiveValues.normalRadius)  // 12.r
borderRadius: BorderRadius.circular(ResponsiveValues.largeRadius)   // 16.r
borderRadius: BorderRadius.circular(ResponsiveValues.cardRadius)    // 20.r
```

#### **Button Heights**

```dart
height: ResponsiveValues.smallButtonHeight  // 36.h
height: ResponsiveValues.buttonHeight       // 48.h
height: ResponsiveValues.largeButtonHeight  // 56.h
```

### ⚡ Import Requirements

**ALWAYS** add this import when using ScreenUtil:

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

For helper values, also import:

```dart
import '../../core/extensions/screen_util_extensions.dart';
```

### 🚫 Prohibited Practices

#### **NEVER do these:**

- Use hardcoded pixel values: `fontSize: 16`, `width: 200`
- Mix responsive and fixed units in the same widget
- Use `.w` for text sizes (use `.sp` instead)
- Ignore responsive design for "small" components
- Copy code from other projects without converting to responsive units

### 🎯 Theme Usage

**The theme already uses responsive units**, so when using theme text styles, they're automatically responsive:

```dart
// ✅ CORRECT - Theme styles are already responsive
Text('Title', style: Theme.of(context).textTheme.titleMedium)
Text('Body', style: Theme.of(context).textTheme.bodyMedium)
```

#

### ⚠️ This is Non-Negotiable

**Every single pixel value in this codebase must be responsive. No exceptions.**

---

---

### 📦 Packages

- To install any package, run:

 use the mcp  tools

---


### ⚙️ Coding Practices

- Prioritize clarity and modularity.
- Don’t invent names or paths—check the codebase first.
- Ask if context is missing.
- Comment generously (every 3–6 lines, and before any logic block).
- Avoid AI-sounding comments—write like a seasoned dev.

---

### 🐛 Debugging

- Think critically, step-by-step.
- Check all relevant files.
- If stuck, add debug prints and share logs.
- Don’t repeat failed fixes—adapt based on what's been tried.

---

### 🛠 Refactoring

- OK to rewrite large blocks if needed.
- **Never break or remove existing behavior** unless asked.
- Check functionality before/after edits.
- Use `theme.dart` for main styles, `shared/Style/` for common UI rules.

# API Integration Workflow

## Overview

This document provides a strict and authoritative workflow for integrating APIs into your Flutter project using the HDM Open API Wrapper. Follow these instructions step-by-step to ensure proper implementation and consistency.

## Model Usage Rule

**Always use the models generated from the OpenAPI/Swagger document itself (found in `lib/api/models/`).**

- If you need extra features, extend these generated models—do not create duplicate or unrelated models unless absolutely necessary.
- Only create a new model if the OpenAPI spec does not provide one for your use case.
- This keeps your code DRY, consistent, and aligned with the API contract.

Refer to the OpenAPI JSON for all model definitions before creating anything custom.


## Workflow

### Step 1: Check API Documentation

- Locate the API documentation or OpenAPI/Swagger specification. it will be in .dev\Api\openapi.json
- Ensure the API supports the required functionality (e.g., pagination).

### Step 2: Verify API Code in `lib/api`

- Check the `lib/api` folder for existing generated API code.
- If the code is missing, generate it using Swagger/OpenAPI tools.
- **Note:** Each API request will return an `HttpResponse<T>` object from the Dio library. Ensure that your code handles this response appropriately.

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

Use the service in a widget:

```dart
ApiInfiniteList<PaginatedUserResponse, User>(
  requestFunction: (page, size) => RestClient.fetchUsers(page, size),
  fakeData: PaginatedUserResponse.fake(), // Optional: Provide fake data for skeleton loading
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
  fakeData: PaginatedUserResponse.fake(), // Optional: Provide fake data for skeleton loading
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

#### Skeleton Loading with Fake Data

The package supports skeleton loading using the "Fake Data" pattern. Instead of creating a separate loading widget, you provide a `fakeData` object that mimics the structure of your real data. The package will then render your success widget using this fake data, wrapped in a `Skeletonizer` to create a shimmer effect.

To use this, ensure your models have a `fake()` factory or method that returns an instance with dummy data.

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
    //note when using the color here add the disabledBackgroundColor as the widget is disabled
    child: Text('Create User'),
  ),
)
```

#### Example 2: Using Generated API with ApiSinglePage

```dart
// Assuming you have a generated method: restClient.getUserById(int id)
ApiSinglePage<UserDetails>(
  requestFunction: () => restClient.getUserById(userId),
  fakeData: UserDetails.fake(), // Optional: Provide fake data for skeleton loading
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
  fakeData: PaginatedUserResponse.fake(), // Optional: Provide fake data for skeleton loading
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


Don't use print statements for logging; use TalkerService instead. there are mulablt function and u can use the TalkerService.info debug warning error etc

```

All these methods return `HttpResponse<T>` objects that work seamlessly with the HDM Open API Wrapper widgets and utilities.

## FlutterGen Asset Management

### Using Type-Safe Assets

**NEVER use string paths for assets.** Always use FlutterGen's generated asset classes for type safety.

#### Asset Structure:

```dart
Assets.images     // Background images
              // JSON data files
```

#### Finding Assets:

1. **Check available assets**: Look in `lib/gen/assets.gen.dart` for all generated assets

#### Usage Examples:

```dart
// ❌ NEVER do this:
Image.asset('assets/images/backgrounds/Back_1.png')

// ✅ ALWAYS do this:
Assets.images.backgrounds.back1.image()

// With parameters:
Assets.images.backgrounds.back1.image(
  width: 200,
  height: 100,
  fit: BoxFit.cover,
)



#### Regenerating Assets:
- **After adding new assets**: Run `fluttergen` command or use VS Code task "Generate Assets (FlutterGen)"
- **During development**: Use VS Code task "FlutterGen: Watch Mode" for auto-regeneration
- **Complete rebuild**: Use VS Code task "Generate All (Swagger + FlutterGen + Build Runner)"
```

if you ever gonna add a defualt value , add //todo next to it
dont use print every , alwaese user talker service
