
# Network Caching Flutter App

This project demonstrates a robust caching architecture in Flutter using Clean Architecture, Bloc, Dio, Sqflite, and dartz. It efficiently loads data from memory, disk, and network, with modern UI and error handling.

---

## Features
- Multi-layer caching: memory, disk, network
- RxJava-inspired flow (see [Dan Lew's blog](https://blog.danlew.net/2015/06/22/loading-data-from-multiple-sources-with-rxjava/))
- Clean Architecture: domain, data, presentation layers
- Bloc for state management
- Dio for networking
- Sqflite for local database
- Modern UI with custom theme and error handling
- Friendly offline/first-time error screens

---

## Caching Flow

See [`CACHING_FLOW.md`](./CACHING_FLOW.md) for a detailed step-by-step explanation.

---

## Screenshots

| Post List Screen | Post Details Screen |
|------------------|--------------------|
| ![Post List](sample_image/post_screen.png) | ![Post Details](sample_image/post_details_screen.png) |

---

## Dependencies

- Flutter 3.8+
- dio
- sqflite
- path_provider
- flutter_bloc
- dartz
- freezed, json_serializable, json_annotation
- google_fonts

---

## Usage

1. Clone the repo:
   ```sh
   git clone https://github.com/jadhavrupesh/network_caching.git
   cd network_caching
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

---

## Project Structure

- `lib/core/theme/` - Colors, text styles
- `lib/data/` - Data sources, models, mappers, repositories
- `lib/domain/` - Entities, use cases, repository interfaces
- `lib/presentation/` - UI screens, Bloc, widgets

---

## Error Handling

- Network errors (DioException) are mapped to user-friendly messages and shown in the UI.
- Offline/first-time scenarios display a clear error card with retry option.

---

## License

MIT
