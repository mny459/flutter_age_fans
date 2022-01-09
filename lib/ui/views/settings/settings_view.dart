import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/ui/shared/themes.dart';
import 'package:flutter_age_fans/ui/views/settings/settings_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class SettingsView extends ViewModelWidget<ThemeProvider> {
  @override
  Widget build(BuildContext context, ThemeProvider themeModel) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        automaticallyImplyLeading: true,
      ),
      body: Material(
        child: ViewModelBuilder<SettingsViewModel>.reactive(
          viewModelBuilder: () => SettingsViewModel(),
          onModelReady: (model) => model.init(),
          builder: (context, model, child) {
            return ListView(
              children: [
                SwitchListTile(
                    title: Text('跟随系统暗色模式'),
                    value: context.select<ThemeProvider, bool>(
                        (model) => model.followSystemDarkModel),
                    onChanged: (selected) {
                      themeModel.setFollowSystemDarkModel(selected);
                    }),
                SwitchListTile(
                  title: Text('暗色模式'),
                  value: context
                      .select<ThemeProvider, bool>((model) => model.isDarkMode),
                  onChanged: (selected) {
                    if (selected) {
                      themeModel.setDarkTheme();
                    } else {
                      themeModel.setLightTheme();
                    }
                  },
                ),
                ExpansionTile(
                  title: Text('主题色'),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            crossAxisCount: 6),
                        itemBuilder: (_, index) => GestureDetector(
                            onTap: () => context
                                .read<ThemeProvider>()
                                .changeThemeColor(Colors.primaries[index]),
                            child: ColoredBox(color: Colors.primaries[index])),
                        itemCount: Colors.primaries.length,
                      ),
                    )
                  ],
                ),
                ListTile(
                  onTap: () => model.clearCache(),
                  title: Text('清除缓存'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.select<SettingsViewModel, String>(
                            (model) => model.cacheSize),
                        style: theme.textTheme.caption!
                            .copyWith(height: 1, fontSize: 14),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 15,
                        color: theme.textTheme.caption!.color,
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text('手动触发一个 Dart 错误'),
                  onTap: () {
                    throw Exception('测试 Flutter 的全局异常捕获');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
