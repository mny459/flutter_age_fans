import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_age_fans/core/constant/routers.dart';
import 'package:flutter_age_fans/core/helper/platform_helper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/ani_collection/ani_collection_view.dart';
import 'package:flutter_age_fans/ui/views/ani_detail/ani_detail_view.dart';
import 'package:flutter_age_fans/ui/views/ani_play/ani_play_view.dart';
import 'package:flutter_age_fans/ui/views/login_or_register/login_or_register_view.dart';
import 'package:flutter_age_fans/ui/views/ani_search/search_view.dart';
import 'package:flutter_age_fans/ui/views/settings/settings_view.dart';
import 'package:flutter_age_fans/ui/views/web_view/web_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'navigation_service.dart';

class NavigationHelper {
  NavigationHelper._();

  static final NavigationService? _navigationService =
      locator<NavigationService>();

  static get context => _navigationService!.navigatorKey.currentContext;

  static Future navNoAnimPage(Widget widget, {String? pageName}) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            opacity: animation as Animation<double>,
            child: widget,
          );
        },
      ),
    );
  }

  static Future<T?> navPage<T extends Object?>(Widget widget,
      {String? pageName}) {
    return Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return widget;
        },
        settings: RouteSettings(name: pageName),
      ),
    );
  }

  static void popToPage(BuildContext context, String pageName) {
    Navigator.popUntil(context, (route) {
      return route.settings.name == pageName;
    });
  }

  static Future navWebView(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }
    if (PlatformHelper.isMobile()) {
      return navPage(WanWeb(url: url), pageName: RouterName.webView);
    }
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static Future navSystemBrowser(String url) async {
    await canLaunch(url) ? await launch(url) : showToast('Invalid url $url');
  }

  static Future navLoginView() {
    return navPage(LoginOrRegisterView(), pageName: RouterName.login);
  }

  static void navSettingsView() {
    showToast("TODO");
    // return navPage(SettingsView(), pageName: RouterName.settings);
  }

  static Future navDetailView(String aid) {
    return navPage(AniDetailView(aid), pageName: RouterName.aniDetail);
  }

  static Future navCollectionView() {
    return navPage(const AniCollectionView(),
        pageName: RouterName.aniCollection);
  }

  static Future navPlayView(String url) async {
    if (url.startsWith('!http')) {
      showToast(S.of(NavigationHelper.context).invalidPlayUrl);
      return;
    }
    final decodeUrl = Uri.decodeFull(url);
    if (PlatformHelper.isMobile()) {
      return navPage(AniPlayView(decodeUrl), pageName: RouterName.aniPlay);
    } else {
      await canLaunch(decodeUrl)
          ? await launch(decodeUrl)
          : throw 'Could not launch $url';
    }
  }

  static void pop([dynamic result]) {
    Navigator.of(context).pop(result);
  }

  static void maybePop([dynamic result]) {
    Navigator.of(context).maybePop(result);
  }

  static Future navSearch() {
    return navPage(SearchView(), pageName: RouterName.aniSearch);
  }

  static Future<void> share(String url) {
    return Share.share(url);
  }
}
