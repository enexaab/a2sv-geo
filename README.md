# 🌍 Country Explorer App

A Flutter application for exploring countries with search, favorites, and dark mode features.

---

## 🚀 Setting Up and Running Locally

Follow these steps to get the project running on your local machine.

### Prerequisites

* **Flutter SDK:** Ensure you have the stable channel version of Flutter (e.g., 3.x.x) installed.
* **Dart SDK:** Included with Flutter.
* **IDE:** Visual Studio Code or Android Studio are recommended.

### Installation Steps

1.  **Clone the Repository:**
    ```bash
    git clone <YOUR_REPOSITORY_URL_HERE>
    cd <YOUR_PROJECT_FOLDER>
    ```

2.  **Install Dependencies:**
    Run the following command in the project root to download all necessary packages:
    ```bash
    flutter pub get
    ```

3.  **Run the Application:**
    Ensure you have an active emulator or physical device connected, then run the app:
    ```bash
    flutter run
    ```

---

## 💻 Technology & Architectural Choices

### Technology Stack

| Component | Technology/Library | Justification |
| :--- | :--- | :--- |
| **Framework** | **Flutter / Dart** | Chosen for its **single codebase** across mobile platforms, enabling rapid development and a naturally compiled, high-performance UI. |
| **State Management** | **Riverpod** | Selected for its **compile-time safety**, flexibility, and powerful dependency injection features, making state predictable and tests easier to write. |
| **Networking** | **Dio** | Used for HTTP client operations due to its robust support for **interceptors**, request cancellation, and streamlined file downloads. |
| **Local Data** | **Hive** | Employed as a fast, lightweight, and non-relational **NoSQL database** for caching country data and storing user favorites locally. |

### Architecture

The project adheres to a **Clean Architecture** (often implemented in Flutter as a Layered Approach) to ensure separation of concerns and maintainability.

* **Presentation Layer (UI/Widgets):** Consumes data streams and methods exposed by Providers (Riverpod) to build the UI and capture user events.
* **Application Layer (Providers/Use Cases):** Contains the core business logic. It orchestrates data flow between the UI and the data layer without directly accessing the database or network.
* **Data Layer (Repositories/Services):** Responsible for fetching data from external sources (APIs) or local storage (Hive). It acts as the single source of truth for the application.# a2sv-geo
