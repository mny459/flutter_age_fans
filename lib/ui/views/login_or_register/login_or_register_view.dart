import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/views/mine/mine_view.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/shared/user_model.dart';
import 'package:flutter_age_fans/ui/views/login_or_register/login_or_register_view_model.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/primary_button.dart';
import 'package:logging/logging.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class LoginOrRegisterView extends StatelessWidget {
  final _logger = Logger('LoginOrRegisterView');

  LoginOrRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginOrRegisterViewModel>.reactive(
      viewModelBuilder: () => LoginOrRegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: AniColor.backgroundColor,
          leading: GestureDetector(
            onTap: () => NavigationHelper.pop(),
            child: const Icon(Icons.close),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            ExtendedImage.network(
              'https://p1.bdxiguaimg.com/origin/13843000115ffe11c0c01',
              width: 80,
              height: 80,
              shape: BoxShape.circle,
              border: Border.all(color: AniColor.textMainColor),
              loadStateChanged: (state) {
                return NetworkImageHelper.handleEmptyLoadState(state);
              },
            ),
            UIHelper.verticalSpace(40),
            Consumer<UserModel>(
              builder: (context, provider, child) {
                _logger.severe('${provider.hasLogin}');
                return provider.hasLogin ? const MineView() : child!;
              },
              child: const _LoginOrRegisterContainer(),
            )
          ],
        ),
      ),
    );
  }
}

class _LoginOrRegisterContainer extends StatefulWidget {
  const _LoginOrRegisterContainer({Key? key}) : super(key: key);

  @override
  _LoginOrRegisterContainerState createState() =>
      _LoginOrRegisterContainerState();
}

class _LoginOrRegisterContainerState extends State<_LoginOrRegisterContainer>
    with SingleTickerProviderStateMixin {
  final _logger = Logger('_LoginOrRegisterContainerState');
  final _tabs = <String>[];
  TabController? _tabController;
  var _index = 0;
  var _showContent = false;

  @override
  void initState() {
    super.initState();
    final tabController =
        TabController(initialIndex: _index, length: 2, vsync: this);
    tabController.addListener(() {
      if (_index != tabController.index) {
        setState(() {
          _index = tabController.index;
          _showContent = false;
        });
      }
    });
    _tabController = tabController;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.isEmpty) {
      _tabs.add(S.of(context).login);
      _tabs.add(S.of(context).register);
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: PhysicalModel(
        color: AniColor.surfaceColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        clipBehavior: Clip.hardEdge,
        child: Material(
          color: AniColor.surfaceColor,
          child: Column(
            children: [
              TabBar(
                labelStyle: const TextStyle(fontSize: 14),
                controller: _tabController,
                labelPadding: EdgeInsets.zero,
                tabs: List.generate(
                  _tabs.length,
                  (index) => Tab(
                    iconMargin: EdgeInsets.zero,
                    height: 44,
                    text: _tabs[index],
                  ),
                ),
              ),
              SizedBox(
                height: _index == 0 ? 184 : 228,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LoginView(),
                    RegisterView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginView extends ViewModelWidget<LoginOrRegisterViewModel> {
  final _userKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _userNameController = TextEditingController(text: 'lspfans');
  final _passwordController = TextEditingController(text: 'lspagefans');

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginOrRegisterViewModel viewModel) {
    final theme = Theme.of(context);
    final local = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: [
          UserNameForm(
            usernameKey: _userKey,
            controller: _userNameController,
          ),
          PasswordForm(
            usernameKey: _passwordKey,
            controller: _passwordController,
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {
              if (_userKey.currentState!.validate() &&
                  _passwordKey.currentState!.validate()) {
                viewModel
                    .login(_userNameController.text.trim(),
                        _passwordController.text.trim())
                    .then((value) {})
                    .catchError((error) {
                  showToast(error.toString());
                });
              }
            },
            content: local.loginNow,
          )
        ],
      ),
    );
  }
}

class RegisterView extends ViewModelWidget<LoginOrRegisterViewModel> {
  final _userKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _rePasswordKey = GlobalKey<FormFieldState>();
  final _userNameController = TextEditingController(text: 'lspfans');
  final _passwordController = TextEditingController(text: 'lspagefans');
  final _rePasswordController = TextEditingController(text: 'lspagefans');

  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginOrRegisterViewModel viewModel) {
    final theme = Theme.of(context);
    final local = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: [
          UserNameForm(
            usernameKey: _userKey,
            controller: _userNameController,
          ),
          PasswordForm(
            usernameKey: _passwordKey,
            controller: _passwordController,
          ),
          RePasswordForm(
            usernameKey: _rePasswordKey,
            controller: _rePasswordController,
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {
              if (_userKey.currentState!.validate() &&
                  _passwordKey.currentState!.validate()) {
                var password = _passwordController.text.trim();
                var rePassword = _rePasswordController.text.trim();
                if (password != rePassword) {
                  showToast(local.hintPasswordDifferent);
                  return;
                }
                viewModel
                    .register(_userNameController.text.trim(), password)
                    .then((value) {})
                    .catchError((error) {
                  showToast(error.toString());
                });
              }
            },
            content: local.registerNow,
          )
        ],
      ),
    );
  }
}

class UserNameForm extends StatelessWidget {
  final GlobalKey<FormFieldState> usernameKey;
  final TextEditingController controller;

  const UserNameForm(
      {Key? key, required this.usernameKey, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CommonForm(
      controller: controller,
      formKey: usernameKey,
      validator: (value) {
        if (value!.isEmpty) {
          return local.hintUsernameEmptyError;
        }
        return null;
      },
      hint: local.hintUsername,
      title: local.username,
      leadingIcon: CupertinoIcons.person,
    );
  }
}

class PasswordForm extends StatelessWidget {
  final GlobalKey<FormFieldState> usernameKey;
  final TextEditingController controller;

  const PasswordForm(
      {Key? key, required this.usernameKey, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CommonForm(
      controller: controller,
      formKey: usernameKey,
      validator: (value) {
        if (value!.isEmpty) {
          return local.hintPasswordEmptyError;
        }
        return null;
      },
      hint: local.hintPassword,
      title: local.password,
      leadingIcon: Icons.lock_outline,
    );
  }
}

class RePasswordForm extends StatelessWidget {
  final GlobalKey<FormFieldState> usernameKey;
  final TextEditingController controller;

  const RePasswordForm(
      {Key? key, required this.usernameKey, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CommonForm(
      controller: controller,
      formKey: usernameKey,
      validator: (value) {
        if (value!.isEmpty) {
          return local.hintPasswordEmptyError;
        }
        return null;
      },
      hint: local.hintPasswordMore,
      title: local.passwordVerify,
      leadingIcon: Icons.lock_outline,
    );
  }
}

class CommonForm extends StatelessWidget {
  final String title;
  final String hint;
  final IconData leadingIcon;
  final FormFieldValidator<String> validator;
  final GlobalKey<FormFieldState> formKey;
  final TextEditingController controller;

  const CommonForm(
      {Key? key,
      required this.formKey,
      required this.title,
      required this.hint,
      required this.leadingIcon,
      required this.validator,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            leadingIcon,
            color: AniColor.textFourthColor,
            size: 16,
          ),
          UIHelper.horizontalSpace(8),
          SizedBox(
            width: 60,
            child: Text(
              title,
              style: const TextStyle(
                color: AniColor.textFourthColor,
              ),
            ),
          ),
          UIHelper.horizontalSpace(10),
          Expanded(
            child: TextFormField(
              key: formKey,
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                    color: AniColor.textThirdColor, fontSize: 14),
                labelStyle: const TextStyle(
                    color: AniColor.textThirdColor, fontSize: 14),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 16,
                    color: AniColor.textFourthColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
