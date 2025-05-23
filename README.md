# 🎬 Flick — Movie App Demo

**Flick** is a modular Swift demo project built to demonstrate **Unidirectional Data Flow (UDF)** and **Swift Package Manager (SPM)** principles in iOS development. This app is designed to be a modern example of scalable architecture, modularization, and clean UI design.

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

1. **Create a TMDB account** and generate an API key:  
   [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

2. **Add your API key** in the appropriate configuration file or environment.  
   For this project, issert you API key in kTMDBApiKey property in [`BaseAPI.swift`](./API/Sources/API/BaseAPI.swift)

   ```swift
   public let kTMDBApiKey = "YOUR_API_KEY_HERE"
   ```

> 🛑 Without a TMDB key, the app will immediately produce fatal error.

---

## 🗂️ Modules

Modularity is at the heart of Flick. Each feature is encapsulated in its own folder under `Modules/` and follows a clean separation of UI, logic, and state.

---

## 🔍 Typical Module Structure

Most feature modules follow a consistent structure:

```
📁 ModuleName
├── 📁 State
│   ├── ModuleNameFlow.swift (e.g. SearchFlow.swift)
│   └── ModuleNameForm.swift (e.g. SearchForm.swift)
├── 📁 View
│   ├── ModuleNameComponent.swift (e.g. SearchComponent.swift)
│   └── ModuleNameContainer.swift (e.g. SearchContainer.swift)
├── Middleware.swift (optional side effects, e.g. SearchMiddleware.swift)
```

This ensures:
- Clear separation of concerns (UI, logic, effects)
- Easy testability
- Scalable modular design

📦 Example: [`Search`](./Flick/Code/Modules/Search)

---

## 🧪 Snapshot Testing

UI consistency is maintained using snapshot testing.

📁 [`SnapshotTests/`](./SnapshotTests)  
- Tests like `SnapshotTestCase+Component.swift`  
- UI snapshots are stored under `Snapshots/`

---

## 🔩 SPM Modularization

Each logical unit (DesignSystem, API, Localization) is a Swift package:
- Improved compile times
- Better code reuse

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

