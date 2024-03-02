import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoice/src/common/util/app_zone.dart';
import 'package:invoice/src/common/util/error_util.dart';
import 'package:invoice/src/common/widget/app.dart';
import 'package:invoice/src/common/widget/app_error.dart';
import 'package:invoice/src/feature/initialization/data/initialization.dart';
import 'package:invoice/src/feature/initialization/widget/inherited_dependencies.dart';

void main() => appZone(
      () async {
        // Splash screen
        final initializationProgress = ValueNotifier<({int progress, String message})>((progress: 0, message: ''));
        /* runApp(SplashScreen(progress: initializationProgress)); */
        $initializeApp(
          onProgress: (progress, message) => initializationProgress.value = (progress: progress, message: message),
          onSuccess: (dependencies) => runApp(
            InheritedDependencies(
              dependencies: dependencies,
              child: const App(),
            ),
          ),
          onError: (error, stackTrace) {
            runApp(AppError(error: error));
            ErrorUtil.logError(error, stackTrace).ignore();
          },
        ).ignore();
      },
    );
