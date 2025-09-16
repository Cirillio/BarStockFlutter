# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Supabase specific
-keep class io.supabase.** { *; }
-keep class com.google.gson.** { *; }

# Keep all annotations
-keepattributes *Annotation*

# Don't warn about missing classes
-dontwarn io.flutter.**
-dontwarn com.google.gson.**