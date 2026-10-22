# 🎬 Flick — Movie App Demo


**Flick** is a modular Swift demo project built to demonstrate **Unidirectional Data Flow (UDF)** and **Tuist**-driven project generation principles in iOS development.

The project showcases a modern approach to scalable architecture, modularization, dependency management, and clean UI design using a fully modular setup powered by **Tuist**.

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

1. **Install Tuist** (if not already installed)

	```bash
	brew install tuist
	```
	
2. **Then install project dependencies:**

	```bash
	tuist install
	```
	
3. **Generate the Xcode project**

	```bash
	tuist generate
	```

4. **Running Snapshot tests**

	```bash
	tuist test
	```

5. **Create a TMDB account** and generate an API key:  
   [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

6. **Add your API key** in the appropriate configuration file or environment.  
   For this project, issert you API key in kTMDBApiKey property in [`BaseAPI.swift`](./API/Sources/API/BaseAPI.swift)

   ```swift
   public let kTMDBApiKey = "YOUR_API_KEY_HERE"
   ```

> 🛑 Without a TMDB key, the app will immediately produce fatal error.

---

## 🗂️ Modules

Modularity is at the heart of Flick. Each feature is encapsulated in its own folder under `Modules/`, while each reusable UI component is further encapsulated in its own Tuist framework under `UI/FrameworkName`. This structure follows a clean separation of UI, logic, and state, ensuring strong isolation between features, improved reusability, **selective testing with Tuist** and scalable architecture across the project.

---

## Tuist Dependency Graph

The project structure is visualized through a generated dependency graph:
![Tuist Dependency Graph](./graph.png)

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
- Modular architecture powered by Tuist: enabling independent feature frameworks; explicit dependency management, and reproducible Xcode project generation across the entire codebase

📦 Example: [`Search`](./Flick/Code/Modules/Search)

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

