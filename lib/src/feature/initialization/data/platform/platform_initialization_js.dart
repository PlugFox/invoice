// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:web/web.dart' as web;

//import 'package:flutter_web_plugins/url_strategy.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> $platformInitialization() async {
  //setUrlStrategy(const HashUrlStrategy());

  // Remove splash screen
  Future<void>.delayed(
    const Duration(seconds: 1),
    () {
      // Before running your app:
      //setUrlStrategy(null); // const HashUrlStrategy();
      //setUrlStrategy(NoHistoryUrlStrategy());

      web.document.getElementById('splash')?.remove();
      web.document.getElementById('splash-branding')?.remove();
      web.document.body?.style.background = 'transparent';
      web.document.querySelector('.splash-loading')?.remove();
    },
  );
}

/* class NoHistoryUrlStrategy extends PathUrlStrategy {
  @override
  void pushState(Object? state, String title, String url) =>
      replaceState(state, title, url);
}
*/
