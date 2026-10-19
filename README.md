# 🎬 Flick — Movie App Demo


**Flick** is a modular Swift demo project built to demonstrate **Unidirectional Data Flow (UDF)** in a multi-module iOS app.

The project showcases a modern approach to scalable architecture, modularization, dependency management, and clean UI design: every module is a local **Swift package**, and the Xcode project is only a thin app shell that composes them.

---

## 🧠 Architecture: [Unidirectional Data Flow (UDF)](https://github.com/Maks-Jago/SwiftUI-UDF)

Flick implements a UDF approach to ensure:
- Predictable state management
- Clear separation of concerns
- Easier debugging and testing

---

## 🔑 TMDB API Key Setup

This project integrates with [The Movie Database (TMDB)](https://www.themoviedb.org/) API to fetch movie data.

### 🔧 To run the app properly, you need to:

1. **Open the project** — Xcode resolves every Swift package on its own:

	```bash
	open Flick.xcodeproj
	```

	The first build asks you to trust the R.swift build plugin used by `Localizations`.

2. **Running Snapshot tests**

	```bash
	xcodebuild test -project Flick.xcodeproj -scheme Flick -destination "platform=iOS Simulator,name=iPhone 18 Pro,OS=27.0" -skipPackagePluginValidation
	```

3. **Create a TMDB account** and generate an API key:  
   [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

4. **Add your API key** in the appropriate configuration file or environment.  
   For this project, issert you API key in kTMDBApiKey property in [`BaseAPI.swift`](./Core/API/Sources/API/BaseAPI.swift)

   ```swift
   public let kTMDBApiKey = "YOUR_API_KEY_HERE"
   ```

> 🛑 Without a TMDB key, the app will immediately produce fatal error.

---

## 🗂️ Modules

Modularity is at the heart of Flick. Every module is a local Swift package with its own `Package.swift`:

- **`Core/`** — shared building blocks: `API`, `Models`, `Common`, `DesignSystem`, `CustomViews`, `Localizations`.
- **`Features/`** — one package per flow (`AuthModule`, `OnboardingModule`, `RootModule`, `HomeModule`, `ItemDetailsModule`, `ReviewsModule`, `SearchModule`, `MyFavoritesModule`, `SettingsModule`), plus the shared `ImageModule` and `NetworkConnectivityModule` features. A flow owns all of its screens, state, middleware and internal navigation.
- **`DataLayer/`** — builds every flow's live environment on top of `API`. Features never import `API`; the data layer knows the features, not the other way around.
- **`Flick/`** — the app: it mounts each flow's `FeatureState` in `AppState`, supplies `Environments`, and resolves the routes that lead from one flow to another.

Feature modules never depend on each other. Middleware registers itself when its `FeatureState` is mounted, and snapshot tests live next to the module they cover.

## 🔍 Typical Module Structure

Most feature app feature modules follow a consistent structure:

```
📁 ModuleName
├── 📁 State
│   ├── ModuleNameFlow.swift (e.g. SearchFlow.swift)
│   └── ModuleNameForm.swift (e.g. SearchForm.swift)
├── 📁 View
│   ├── ModuleNameRouting.swift (e.g. SearchRouting.swift)
│   └── ModuleNameContainer.swift (e.g. SearchContainer.swift)
├── Middleware.swift (optional side effects, e.g. SearchMiddleware.swift)
```

Framework module follow a consistent structure:

```
📁 ModuleName
├── 📁 Sources
│   ├── ModuleNameComponent.swift (e.g. SearchComponent.swift)
│   ├── ModuleNameContent.swift (e.g. SearchContent.swift)
│   ├── ModuleNameRoute.swift (e.g. SearchRoute.swift)
├── 📁 Snapshots
│   ├── 📁 __Snapshots__
│   ├── ModuleComponentTests.swift (e.g. SearchComponentTests.swift)
```

This ensures:

- Clear separation of concerns (UI, logic, effects)
- Easy testability
- Scalable modular design
- Modular architecture built on Swift packages: independent feature modules with explicit dependencies

📦 Example: [`SearchModule`](./Features/SearchModule)

---

## 🔗 BindableReducer and BindableContainer

Flick introduces dynamic reducer composition through the concept of `@BindableReducer`.

### `@BindableReducer`

You can mark any reducer with `@BindableReducer` to bind it to a `BindableContainer`. This allows:

- 🔁 Dynamic creation/destruction of reducers
- 🔀 Recursive transitions between containers
- 📦 Multiple simultaneous container instances (e.g. opening multiple detail views)

### `BindableContainer`

A `BindableContainer` manages the lifecycle of dynamic views. UDF will instantiate a separate reducer for each active instance of such a container, maintaining full separation of state and transitions.

#### Example Use Case:
Opening several modals or search overlays that can independently manage their own state and close without interfering with each other.

> ⚠️ Each instance of a `BindableContainer` is fully isolated, ensuring clean recursion and reuse.

---

## 📄 License

Licensed under the terms of the [LICENSE](./LICENSE).

---

