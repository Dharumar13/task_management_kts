plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.fortigrid.apps.concept.concept"
    compileSdk = 36

    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.fortigrid.pact.task"
        minSdk = 26
        targetSdk = 36
        versionCode = 9
        versionName = "1.1.2"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        allWarningsAsErrors = false
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    lint {
        abortOnError = false
        disable += setOf("PropertyEscape")
    }
}

dependencies {
    // ✅ REQUIRED when coreLibraryDesugaring is enabled
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

flutter {
    source = "../.."
}
