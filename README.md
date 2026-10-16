
::: {align="center"}
# QR STUDIO

### Flutter QR Code Generator

**A clean, responsive QR generation experience built with Flutter.**

[![Flutter](https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-Language-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![QR](https://img.shields.io/badge/QR%20Generation-qr__flutter-2563EB)](https://pub.dev/packages/qr_flutter)
[![Internship](https://img.shields.io/badge/Auspify%20Technologies-Task%2001-0F766E)](https://github.com/)
:::

------------------------------------------------------------------------

## Overview

QR Studio is a Flutter application created for **Task 1 of the Auspify
Technologies Flutter Development Internship**. It allows users to enter
text or a website URL, generate a QR code, and view it in a clean,
responsive interface.

The project uses a modular structure to separate screen composition,
reusable widgets, image operations, and theme styling. This makes the
code easier to read, maintain, test, and extend.

## Features

  -----------------------------------------------------------------------
Feature                             Description
  ----------------------------------- -----------------------------------
**Text and URL input**              Enter a website address or other
text to encode.

**QR generation**                   Generate a QR code from the
supplied content.

**Live preview area**               View the generated QR code inside
the application.

**Input validation**                Prevent generation when the input
field is empty.

**Clear action**                    Clear the input and reset the
preview.

**Save as PNG**                     Save the generated QR image using
the app's save action.

**Share QR image**                  Invoke the platform's image-sharing
action.

**Responsive layout**               Arrange the input and preview
side-by-side on wider screens and
vertically on narrower screens.

**Consistent UI theme**             Centralise colours and common
styling for a cohesive interface.
  -----------------------------------------------------------------------

> **Platform note:** Save and Share behaviour can differ between
> browsers and devices. These actions should be tested on the exact
> platform used for the demonstration before reporting them as verified.

## Interface

The app presents two primary panels:

-   **Create your QR code** --- input field with Generate and Clear
    actions.
-   **QR Code Preview** --- QR display area with Save and Share actions.

The layout adapts to available width to keep the interface usable on
both narrow and wide screens.

## Technology Stack

-   **Flutter** --- cross-platform application framework
-   **Dart** --- application programming language
-   **`qr_flutter`** --- QR code generation and rendering
-   **`file_saver`** --- saving the generated image
-   **`share_plus`** --- sharing the generated image
-   **Material 3** --- application theme and UI components

The dependency versions used by the project are defined in
`pubspec.yaml`.

## Project Architecture

```text
lib/
├── main.dart
├── screens/
│   └── qr_generator_screen.dart
├── widgets/
│   ├── qr_input_card.dart
│   └── qr_preview_card.dart
├── services/
│   └── qr_code_service.dart
└── theme/
    └── app_theme.dart

test/
└── widget_test.dart

pubspec.yaml
pubspec.lock
```

### Separation of concerns

  ------------------------------------------------------------------------
File                                 Responsibility
  ------------------------------------ -----------------------------------
`main.dart`                          Initialises the Flutter application
and loads the main screen and
theme.

`screens/qr_generator_screen.dart`   Coordinates input state,
validation, and responsive layout.

`widgets/qr_input_card.dart`         Provides the text/URL field and
Generate/Clear controls.

`widgets/qr_preview_card.dart`       Displays the QR code and exposes
Save/Share actions.

`services/qr_code_service.dart`      Captures the QR image and delegates
saving and sharing operations.

`theme/app_theme.dart`               Defines shared colours and Material
styling.

`test/widget_test.dart`              Holds widget tests for the
application.
  ------------------------------------------------------------------------

This is a **modular Flutter structure using separation of concerns**. It
is intentionally lightweight and avoids adding architectural layers that
are not necessary for this task.

## Getting Started

### Prerequisites

Install the following:

-   Flutter SDK
-   Dart SDK (included with Flutter)
-   Android Studio or another Flutter-compatible IDE
-   A supported browser, emulator, or physical device

Verify your environment:

```bash
flutter --version
flutter doctor
```

### Installation

1.  Clone this repository from GitHub or download it as a ZIP.
2.  Open a terminal in the project root---the directory containing
    `pubspec.yaml`.
3.  Fetch dependencies:

```bash
flutter pub get
```

### Run the application

To list available devices:

```bash
flutter devices
```

Run on the selected device:

```bash
flutter run
```

To run in Chrome, when Chrome is available as a Flutter target:

```bash
flutter run -d chrome
```

### Static analysis and tests

Run static analysis:

```bash
flutter analyze
```

Run widget tests:

```bash
flutter test
```

Review the output and resolve project errors before treating the project
as ready for submission. A command completing is not a substitute for
manually testing the app's interactive features.

## How to Use

1.  Launch QR Studio.
2.  Enter a URL or text in the input field.
3.  Select **Generate QR Code**.
4.  Confirm that the QR code appears in the preview panel.
5.  Scan it with a phone camera or decode it using a QR decoder.
6.  Compare the decoded content with the original input.
7.  Select **Save QR Code** and verify that a PNG image was saved or
    downloaded.
8.  Select **Share QR Code** and verify the sharing action on the target
    platform.
9.  Resize the browser or app window to verify the responsive layout.

**Tip:** A QR decoder may display the decoded URL as text rather than
opening the destination automatically. If necessary, copy the decoded
URL into the browser's address bar.

## Quality Checklist

Use this checklist before submitting or demonstrating the project:

-   [ ] A QR code can be generated from a valid website URL.
-   [ ] A QR code can be generated from ordinary text.
-   [ ] The decoded content matches the original input.
-   [ ] Empty input displays a validation message.
-   [ ] The Clear action resets the input and preview.
-   [ ] The Save action produces a valid PNG file.
-   [ ] The Share action works on the demonstration platform.
-   [ ] The layout is usable at narrow and wide widths.
-   [ ] `flutter analyze` has been reviewed and relevant errors are
    resolved.
-   [ ] `flutter test` has been run and test failures are addressed.

## Project Context

**Organisation:** Auspify Technologies\
**Programme:** Flutter Development Internship\
**Task:** Task 1 --- QR Code Generator App\
**Application name:** QR Studio

This project demonstrates Flutter UI composition, package integration,
input validation, QR rendering, image operations, and responsive layout.

## Submission Notes

For the official internship submission, follow the instructions provided
by Auspify Technologies. The supplied instructions specify that
completed project files and relevant supporting evidence should be
organised and compressed into **one ZIP archive**. This GitHub
repository serves as a source-code and documentation reference; it
should not be treated as a replacement for the ZIP unless the official
submission form explicitly permits that.

Only describe features as complete after testing them on the intended
platform. Keep private credentials and unrelated files out of the
repository.

------------------------------------------------------------------------

::: {align="center"}
**QR STUDIO**\
*Built with Flutter · Task 1 · Auspify Technologies*
:::
