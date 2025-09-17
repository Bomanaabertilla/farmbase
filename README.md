# farmbase

A Flutter project designed to help farmers track crops, manage planting & harvesting dates, and monitor progress with a clean, nature-inspired interface.

## Getting Started

Install dependencies
flutter pub get

Run the app
flutter run
In the output, you'll find options to run the app on:

i.   Android emulator
ii.  iOS simulator
iii. A physical device (via USB or WiFi)


## Crop Management

List crops with planting/harvest dates and status
Add/Edit/Delete crops
Update crop status (Growing, Ready, Harvested)
Simple search by crop name

## Persistence

Local storage using shared_preferences
Preloaded with 5 mock crops

## UI & Theming

Green & brown nature-inspired theme
Material Design principles
Responsive across screen sizes

## State Management Choice

This project uses Provider for state management:
It is endorsed and maintained by the flutter team.
it works across multiple screens.

## Assumptions & Limitations
It is local only, data is stored using shared_preferences and not synced across devices.
Planting date must be before harvest date.

## Testing
Includes a unit test.

flutter test

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
