# AlabTechnology Plugin

A simple Flutter plugin to display beautifully styled social media icons (Facebook, Instagram, YouTube) with clickable links.

---

## ✨ Features

- 📱 Ready-to-use social media UI  
- 🎨 Custom styled icons with shadows  
- 🔗 Opens links in external browser  
- ⚡ Lightweight and easy integration  

---

## 🚀 Getting Started

### 1. Add Dependency

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  alabtechnology: ^latest_version
```
### Then run: 
flutter pub get

### 📲 Android Configuration
To enable opening external links, update your AndroidManifest.xml:

``` yaml

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.alabtechnology">

    <!-- Internet Permission -->
    <uses-permission android:name="android.permission.INTERNET" />

    <!-- Required for URL launcher -->
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="https" />
        </intent>
    </queries>

</manifest>
```

### 🧑‍💻 Usage
Import the package:

```
import 'package:alabtechnology/social_media_view.dart';
```

Then use the widget:
```
SocialMediaView()
```


### Example

```
import 'package:flutter/material.dart';
import 'package:alabtechnology/social_media_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SocialMediaView(),
        ),
      ),
    );
  }
}
```

## 🖼️ Assets
All images (Facebook, Instagram, YouTube) are bundled within the plugin.
⚠️ No need to manually add assets in your app.

## ⚙️ Customization
You can extend or modify the social items using your own list:

```
SocialMediaView(
  socailItems: [
    // Add your custom SocialItemEntities here
  ],
)
```

## 📦 Dependencies
This plugin uses:
 - url_launcher → To open external links

 

# Author
Saravanan V 

# Version
- Dart = 3.10.1
- flutter = 3.38.3
