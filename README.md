﻿﻿:globe_with_meridians:  **<u>english</u>**  |   [český](README.cz.md)	|   [русский](README.ru.md)

# Plan-et-B (PWA Game) 🪐

## Table of content:
* [Description](#Description)
* [How To Section](#How-to-Section)
  * [How to play it online?](#How-to-play-it-online?)
  * [How to play it locally?](#How-to-play-it-locally?)
  * [How to build it?](#How-to-build-it?)
* [To-Do Section](#To-Do-Section)
* [Licenses](#Licenses)
* [Releases](#Releases)
* [Technical Data](#Technical-Data)

![Screenshot](preview.gif)

## Description

In this branch you will find **my original awarded submission** in **Official Flutter Community** hackathon, called "***#Hack20***". With more than 2665 attendees and 650 teams, with 266 projects submitted. You can read more about this hackathon and it's rules here: [flutterhackathon.com](https://flutterhackathon.com)

#### Official Flutter Community Hackathon 2020 Themes:

* 🌎 **Saving the Planet** (Eco / What we’ve learned during the pandemic)

* 👾 **Retro / Cyberpunk Future**

I decided to work on both topics and made a simple **Wing Commander (1990) like pseudo-3D game, with Cyberpunk / Iron Man like HUD and some themed Music/SFX. You can play it in your internet browser and install to the device for offline use because it's PWA**. The main core of this game was made with [Rive](https://rive.app) (ex Flare) tool.
> **Note:** design is screen size-independent because all the graphics are made in vectors (not bitmaps), but I have prepared it with 7-12' screen size in mind.

Your mission is to, **fly around the space, looking for so-called "Planet B" and determine this planet's suitability for life (by clicking). There are a dozen planets to check, but you are low on fuel** (you have about 1,5 minutes). At the end of the mission, you can see the number of planets scanned or you can play the game again.

> **Note:** The game was created within two days by one person. There are no complicated game mechanics, it's just a concept, a vision with a nice entourage, that may inspire someone.

You can watch a **preview video of it (with main functionality highlight) here:**

**[Gameplay on YouTube](https://youtu.be/_hoEp9jGoLc)**

<details>
  <summary>Spoiler about Gameplay</summary>

There is no planet B (suitable for life). And it's the main point of this game and philosophical part related to the topic of Ecology... **We need to take care of our Earth.**

</details>

## How To Section

### How to play it online?

---

:warning: **Important! BEFORE YOU START!** :warning:


This project in form of PWA **will only run on most recent browsers, with Chromium (Chrome, Edge, etc.) engine v83 or newer. Also, I've tested it on Firefox v77+**, so it might be OK too. Don't even try to run it on Safari, Internet Explorer and so on — they can't handle it!

---
Thanks to [Codemagic](https://codemagic.io), you can just follow this link and run it in your modern browser:

[https://hack20.codemagic.app](https://hack20.codemagic.app)

### How to play it locally?
Please follow this commands in your terminal:
````markdown
flutter channel master
flutter upgrade
git clone https://github.com/tsinis/plan_et_b.git
cd plan_et_b
flutter run -d chrome --release --dart-define=FLUTTER_WEB_USE_SKIA=true --dart-define=FLUTTER_WEB_USE_EXPERIMENTAL_CANVAS_TEXT=true
````

:exclamation: The last line is most important! **Please DO use this flags**, otherwise, Rive animations will not be displayed correctly.

### How to build it?

Please run this command from the project's folder, in your terminal:

* For web:
```
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true --dart-define=FLUTTER_WEB_USE_EXPERIMENTAL_CANVAS_TEXT=true
```

* For Android:
```
flutter build apk --split-per-abi
```

 *Sadly other devices (like iPhones, PCs, Macs will have no sound and music, because I didn't found any good plugin for it). You can build it for those platforms without any compile errors just after removing the audio player package from the code. I'm working on this Issue (see To-Do Section below).*

 Anyways this game was made to be a PWA, so there is no reason to have a native app, since you can install it from a browser, on almost any recent device.

## To-Do Section

- [x] Create Game Core.
- [x] Create Pseudo-3D HUD.
- [x] Add Sounds and Music.
- [ ] Fix Audio on platforms other than Web and Android.
- [ ] Add a Story and stylize the menus to Cyberpunk style.
- [ ] Add Splash Screen and Icons.

## Licenses
This project is released under the terms of the [MIT license](./LICENSE). All assets (as sounds, animations, and font) are OFL or CC licensed and are free for personal use. You can find **LICENSE** files in their folders.

## Releases

You can find binaries for Android and Web in [Releases](https://github.com/tsinis/plan_et_b/releases) section of this GitHub repository. I will add other platform binaries gradually, after the audio player fixes.

## Technical Data

| Name | Description |
| ---- | ----------- |
| **Framework name** | [Flutter](https://flutter.dev) |
| Framework version | [1.20.0-3.0.pre.78](https://github.com/flutter/flutter) |
| Framework channel | master |
| **Language name** | [Dart](https://dart.dev) |
| Language version | [2.9.0](https://github.com/dart-lang) |
| Language channel | beta |
| **IDE name** | [Visual Studio Code](https://code.visualstudio.com/insiders/) |
| IDE version | [1.47.0](https://github.com/microsoft/vscode) |
| IDE channel | insider |
| 3rd-party Dependency name | Auto Size Text|
| 3rd-party Dependency package | [auto_size_text](https://pub.dev/packages/auto_size_text) |
| 3rd-party Dependency version | [2.1.0](https://github.com/leisim/auto_size_text) |
| 3rd-party Dependency channel | stable |
| 3rd-party Dependency name | Assets Audio Player |
| 3rd-party Dependency package | [assets_audio_player](https://pub.dev/packages/assets_audio_player) |
| 3rd-party Dependency version | [2.0.6+4](https://github.com/florent37/Flutter-AssetsAudioPlayer) |
| 3rd-party Dependency channel | stable |
| 3rd-party Dependency name | [Rive](https://rive.app) (ex Flare) |
| 3rd-party Dependency package | [flare_flutter](https://pub.dev/packages/flare_flutter) |
| 3rd-party Dependency version | [2.0.3](https://github.com/2d-inc/Flare-Flutter) |
| 3rd-party Dependency channel | stable |
| Architecture | Vanilla |