# Help Page

A help page widget for Flutter.

For internal use.

Add the following to `android/app/src/main/AndroidManifest.xml`,
inside the `<manifest>` tag:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```
