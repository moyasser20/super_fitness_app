# 🏋️ Super Fitness App

**Super Fitness** is a cross‑platform fitness app built with Flutter. It's your pocket personal trainer. It builds a fitness profile from your body data and goals, recommends muscles and workouts, guides you through exercises by difficulty level, suggests healthy meals, and includes an **AI Smart Coach** chatbot (powered by Google Gemini) that answers training and nutrition questions.

The app supports **English and Arabic** (with RTL), uses **Clean Architecture** with a **feature-first** structure, and is covered by **unit, bloc and widget tests**.

---

## 📑 Table of Contents

- [The Idea](#-the-idea)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [APIs](#-apis)
- [Getting Started](#-getting-started)
- [Code Generation](#-code-generation)
- [Localization](#-localization)
- [Testing](#-testing)
- [CI/CD & Git Workflow](#-cicd--git-workflow)
- [Contributing](#-contributing)

---

## 💡 The Idea

Many people want to get fit but don't know **where to start**, **which muscles to train**, **which exercises suit their level**, or **what to eat**. Super Fitness puts all of that in one app:

1. **Know the user.** At sign-up the user enters gender, age, weight, height, goal and activity level, so the experience is personalized from day one.
2. **Train smart.** Browse muscle groups, get recommended muscles, and pick exercises filtered by **muscle and difficulty level**.
3. **Eat right.** Explore meal categories and recipes with full details (ingredients, instructions and video).
4. **Ask a coach anytime.** A built-in AI Smart Coach answers fitness and nutrition questions in English or Arabic. Chat history is saved locally.

---

## ✨ Features

| Area | What it does |
|------|--------------|
| 🚀 **Splash & Onboarding** | Animated splash and a multi-page onboarding with page indicators |
| 🔐 **Authentication** | Register, login, logout, secure token storage |
| 🧾 **Complete Registration** | 6-step wizard: gender → age → weight → height → goal → activity level |
| 🔑 **Forget Password** | Email → OTP verification → reset password |
| 🔒 **Change Password** | Change the password from the profile |
| 🏠 **Home / Explore** | Recommended (random) muscles, muscle groups, meal categories |
| 💪 **Workouts** | Browse muscle groups and the muscles in each group |
| 🏃 **Exercises** | Difficulty levels by prime mover, exercises by muscle + difficulty, video playback |
| 🥗 **Food** | Meals by category (TheMealDB) |
| 🍽️ **Food Details** | Meal details: ingredients, instructions, video |
| 🤖 **Smart Coach (AI)** | Gemini-powered chatbot with multiple chat sessions stored in **Hive** |
| 👤 **Profile** | View profile, language toggle, security, privacy policy, help, logout |
| ✏️ **Edit Profile** | Update personal data, weight, goal, activity level and profile photo |
| 🌍 **Localization** | English 🇬🇧 / Arabic 🇪🇬 with full RTL support |

**Bottom navigation (Dashboard):** Explore · Chat (Smart Coach) · Workouts · Profile

---

## 🛠 Tech Stack

| Category | Packages |
|----------|----------|
| **State management** | `flutter_bloc` (Cubit), `equatable` |
| **Dependency injection** | `get_it` + `injectable` |
| **Networking** | `dio` + `retrofit`, `http` |
| **Serialization** | `json_annotation` + `json_serializable` |
| **Functional error handling** | `dartz` (`Either<Failure, T>`) |
| **Local storage** | `flutter_secure_storage` (tokens), `shared_preferences` (prefs), `hive` (chat history) |
| **AI** | Google Gemini REST API (`gemini-2.5-pro`), `flutter_chat_ui` |
| **UI** | `google_fonts`, `flutter_svg`, `shimmer`, `loading_indicator`, `percent_indicator`, `step_progress_indicator`, `smooth_page_indicator`, `another_flushbar`, `fluttertoast` |
| **Media & files** | `image_picker`, `file_picker`, `webview_flutter`, `url_launcher` |
| **Localization** | `flutter_localizations`, `intl` (ARB files) |
| **Testing** | `flutter_test`, `mockito`, `bloc_test` |
| **Tooling** | `build_runner`, `flutter_lints`, `flutter_launcher_icons` |

---

## 🧱 Architecture

The project follows **Clean Architecture** with an **MVVM** presentation layer. Each feature is split into layers:

```
┌──────────────────────────────────────────────────────────┐
│  Presentation   View (Widgets)  ◄──►  ViewModel (Cubit)  │
├──────────────────────────────────────────────────────────┤
│  Domain         UseCases  ──►  Repository (abstract)     │
├──────────────────────────────────────────────────────────┤
│  Data           RepositoryImpl ──► DataSource (abstract) │
├──────────────────────────────────────────────────────────┤
│  API            DataSourceImpl ──► ApiClient (Retrofit)  │
└──────────────────────────────────────────────────────────┘
```

- **View**: Flutter widgets. They only render state and dispatch user actions.
- **ViewModel (Cubit)**: holds UI state (`Initial / Loading / Success / Error`) and calls use cases.
- **UseCase**: one business action per class (e.g. `GetRandomMusclesUseCase`).
- **Repository**: the abstract contract lives in `domain`, the implementation in `data`.
- **DataSource**: the remote implementation in `api` calls the Retrofit `ApiClient`.
- **Error handling**: errors are caught in the data layer and turned into `Failure` objects (often wrapped in `Either<Failure, T>` from `dartz`), and cubits turn them into `Error` states for the UI.
- **DI**: every class is registered with `@injectable` / `@lazySingleton` and resolved through `getIt<T>()` (`lib/core/config/di.dart`).

---

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry: DI, storage init, MultiBlocProvider, MaterialApp
├── core/
│   ├── api/
│   │   ├── api_constants/        # Base URL & endpoints
│   │   └── client/               # Retrofit ApiClient (+ generated .g.dart)
│   ├── common/widgets/           # Shared widgets (snackbars, ...)
│   ├── config/                   # get_it/injectable setup, Dio module
│   ├── contants/                 # App icons/images, SecureStorage, Prefs
│   ├── errors/  utils/error/     # Failure classes & error handling
│   ├── extensions/               # Dart/Flutter extensions
│   ├── l10n/                     # app_en.arb, app_ar.arb + generated translations
│   ├── routes/                   # Route names & onGenerateRoute
│   ├── theme/                    # Colors & theme
│   ├── utils/                    # Styles, dimensions, enums
│   └── widgets/                  # Reusable UI components & messages
└── features/
    ├── splash/                   # Splash screen
    ├── onboarding/               # Onboarding pages
    ├── auth/                     # Register, complete registration, login,
    │                             # forget/reset password, change password, logout
    ├── app_sections/             # Dashboard + bottom navigation
    ├── home/                     # Explore: muscles, muscle groups, meal categories
    ├── workouts/                 # Muscle groups & muscles
    ├── exercise/                 # Difficulty levels & exercises
    ├── food/                     # Meals by category
    ├── food-details/             # Meal details
    ├── bot/                      # AI Smart Coach (Gemini + Hive chat sessions)
    ├── profile/                  # Profile, help, privacy, security, language
    ├── edit-profile/             # Edit profile & upload photo
    └── localization/             # Language cubit & persisted preference
```

Each data-driven feature follows the same layout:

```
feature_name/
├── api/            datasource_impl/        → remote data source implementation
├── data/           datasource/ models/ repo_impl/
├── domain/         repo/ usecases/ (entities/)
└── presentation/   view/ viewmodel/
```

---

## 🌐 APIs

| API | Usage | Base URL |
|-----|-------|----------|
| **Elevate Fitness API** | Auth, profile, muscles, muscle groups, levels, exercises | `https://fitness.elevateegy.com/api/v1/` |
| **TheMealDB** | Meal categories, meals by category, meal details | `https://www.themealdb.com/api/json/v1/1/` |
| **Google Gemini** | Smart Coach chatbot | `generativelanguage.googleapis.com` |

<details>
<summary>Main endpoints</summary>

| Endpoint | Description |
|----------|-------------|
| `auth/signup` · `auth/signin` · `auth/logout` | Authentication |
| `auth/forgotPassword` · `auth/verifyResetCode` · `auth/resetPassword` | Password recovery |
| `auth/change-password` | Change password |
| `auth/profile-data` · `auth/editProfile` · `auth/upload-photo` | Profile |
| `muscles` · `muscles/random` · `musclesGroup/{groupId}` | Muscles & groups |
| `levels/difficulty-levels/by-prime-mover` | Difficulty levels |
| `exercises/by-muscle-difficulty` | Exercises |

</details>

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK **3.29.x** (stable). This is the version CI uses.
- Dart SDK **≥ 3.7.0**
- Android Studio / Xcode / VS Code
- A Google Gemini API key (for the Smart Coach)

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/moyasser20/super_fitness_app.git
cd super_fitness_app

# 2. Install dependencies
flutter pub get

# 3. Generate code (DI, Retrofit, JSON, Hive, mocks)
dart run build_runner build --delete-conflicting-outputs

# 4. Generate localization files
flutter gen-l10n

# 5. Run the app
flutter run
```

### App icons

```bash
dart run flutter_launcher_icons
```

---

## ⚙️ Code Generation

The project relies on `build_runner` for:

| Generator | Output |
|-----------|--------|
| `injectable_generator` | `lib/core/config/di.config.dart` |
| `retrofit_generator` | `api_client.g.dart` |
| `json_serializable` | `*.g.dart` for models |
| `hive_generator` | `chat_session.g.dart` (Hive TypeAdapter) |
| `mockito` | `*_test.mocks.dart` in `test/` |

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode while developing
dart run build_runner watch --delete-conflicting-outputs
```

---

## 🌍 Localization

- ARB files: `lib/core/l10n/app_en.arb` (template) and `app_ar.arb`
- Generated output: `lib/core/l10n/translation/` (configured in `l10n.yaml`)
- `LocalizationCubit` switches the language at runtime. The choice is saved with `LocalizationPreference`, and Arabic switches the layout to **RTL**.

To add a string, add the key to both ARB files and run:

```bash
flutter gen-l10n
```

Then use it with `AppLocalizations.of(context)!.yourKey`.

---

## 🧪 Testing

The project has **31 test files and about 129 test cases**. They cover all layers of the architecture: data sources, repositories, use cases, cubits and screens.

### Testing strategy

| Layer | Type | Tools | What is verified |
|-------|------|-------|------------------|
| **API / DataSource** | Unit | `mockito` | Calls the `ApiClient` correctly and maps responses and errors |
| **Repository** | Unit | `mockito` | Returns `Right(data)` on success and `Left(Failure)` on errors |
| **UseCase** | Unit | `mockito` | Delegates to the repository with the correct parameters |
| **Models** | Unit | `flutter_test` | `toJson` / `fromJson` serialization |
| **ViewModel (Cubit)** | Bloc | `bloc_test` + `mockito` | Emits states in the right order (`Loading → Success / Error`) |
| **Views / Screens** | Widget | `flutter_test` + `mockito` | Rendering, user interaction, navigation and state-driven UI |

### Test coverage by feature

| Feature | DataSource | Repository | UseCases | ViewModel | Widget |
|---------|:---:|:---:|:---:|:---:|:---:|
| Auth (login, register, change password) | ✅ | ✅ | ✅ | — | ✅ Login, Register |
| Home | ✅ | ✅ | ✅ (3 use cases) | ✅ | ✅ |
| Exercise | ✅ | ✅ | ✅ (2 use cases) | ✅ | — |
| Food | ✅ | ✅ | ✅ | ✅ | — |
| Profile | ✅ | ✅ | ✅ | ✅ | ✅ |
| Workouts | ✅ | — | — | ✅ | — |
| Smart Coach (bot) | — | — | — | — | ✅ |
| Dashboard | — | — | — | — | ✅ |
| Splash / Onboarding | — | — | — | — | ✅ |

### Test structure

The `test/` folder mirrors `lib/`:

```
test/features/
├── auth/        api/ data/ domain/ login/ presentation/
├── home/        api/ data/ domain/ presentation/
├── exercise/    api/ data/ domain/ presentation/
├── food/        data/ domain/ presentation/
├── profile/     api/ data/ domain/ presentation/
├── workouts/    api/ presentation/
├── bot/         view/
├── app_sections/presentation/view/
├── onboarding/
└── splash/
```

### Example: Cubit test with `bloc_test`

```dart
@GenerateMocks([GetRandomMusclesUseCase, GetMuscleGroupsUseCase])
void main() {
  late MockGetRandomMusclesUseCase mockUseCase;
  late HomeCubit cubit;

  setUp(() {
    mockUseCase = MockGetRandomMusclesUseCase();
    cubit = HomeCubit(/* injected mocks */);
  });

  blocTest<HomeCubit, HomeState>(
    'emits [HomeLoading, HomeLoaded] when home data loads successfully',
    build: () {
      when(mockUseCase()).thenAnswer((_) async => fakeMusclesResponse);
      return cubit;
    },
    act: (cubit) => cubit.loadHomeData(),
    expect: () => [isA<HomeLoading>(), isA<HomeLoaded>()],
  );
}
```

### Running the tests

```bash
# Generate the mocks first (needed after changing @GenerateMocks)
dart run build_runner build --delete-conflicting-outputs

# Run all tests
flutter test

# Run one feature
flutter test test/features/home

# Run one file
flutter test test/features/home/presentation/viewmodel/home_cubit_test.dart

# Coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html   # requires lcov
```

### Writing a new test

1. Create the file in `test/` at the same path as the source file, with a `_test.dart` suffix.
2. Annotate with `@GenerateMocks([YourDependency])` and import `your_file_test.mocks.dart`.
3. Run `build_runner` to generate the mocks.
4. Use the **Arrange → Act → Assert** pattern. Use `blocTest` for cubits and `testWidgets` for screens.

---

## 🔄 CI/CD & Git Workflow

GitHub Actions workflows in `.github/workflows/`:

| Workflow | Purpose |
|----------|---------|
| `lint.yaml` | Runs `flutter pub get`, checks formatting with `dart format`, and fails on **unused imports** (`dart analyze`) |
| `validate_branch_name_action.yaml` | Checks the branch name format |
| `validate_pr_title_action.yaml` | Checks the PR title and branch name format |

### Branch naming

```
<type>/<TICKET-ID>-<task-name>
```

- Allowed types: `feature`, `bugfix`, `fix`, `hotfix`, `release`, `build`, `test`
- Example: `feature/SP-18-smart-coach-test`

### PR title

```
<type>(optional-scope): <TICKET-ID>-<task name>
```

- Allowed types: `feat`, `fix`, `hotfix`, `release`, `build`, `test`
- Example: `feat(auth): SP-17-Change-password`

### Branches

- `master`: stable / production
- `development`: integration branch. Feature branches are merged here through PRs.

---

## 🤝 Contributing

1. Create a branch from `development` that follows the naming rules above.
2. Follow the existing Clean Architecture layout for new features.
3. Add tests for every new data source, repository, use case and cubit.
4. Before pushing, run:
   ```bash
   dart format .
   flutter analyze
   flutter test
   ```
5. Open a PR to `development` with a valid title.

---

<p align="center">Made with ❤️ using Flutter</p>
