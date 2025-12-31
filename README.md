# Flutter Isolation Demo

This project demonstrates the impact of heavy computations on the Flutter UI thread and how to mitigate it using Isolates. It specifically compares parsing a large JSON dataset on the main thread versus doing it in a background isolate.

## Project Overview

The application fetches a large JSON file (approx. 5MB) from a remote server.
- **Without Isolation:** The JSON parsing happens on the main UI thread. This causes the app to freeze, visible by the stopped animation of the circular progress indicator.
- **With Isolation:** The JSON parsing is offloaded to a separate Isolate. The main UI thread remains free, and the animation continues smoothly.

## About Isolation in Flutter

Dart is single-threaded by default. This means that if you execute a heavy task (like parsing a large JSON file, image processing, or heavy loops) on the main thread, the UI will be blocked until the task completes.

Isolates allow you to run code in a separate execution context with its own memory heap. This enables true parallelism on multi-core devices, keeping your UI responsive.

## Best Practices: `Isolate.run()` vs `compute()`

When choosing between methods to offload work:

> **If you are building a Mobile-only app, use `Isolate.run()`. It is faster and more modern.**
>
> **If you are building a Web/Multi-platform app, use `compute()` to keep your code safe across all devices.**

## Getting Started

To run this project:
1.  Ensure you have Flutter installed.
2.  Clone this repository.
3.  Run `flutter pub get`.
4.  Run `flutter run`.
