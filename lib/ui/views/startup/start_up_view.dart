import 'package:flutter/material.dart';
import 'package:flutter_age_fans/ui/views/startup/start_up_view_model.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) async {
        await model.init();
      },
      builder: (context, model, child) => const Scaffold(
        body: CenterLoadingAnimation(),
      ),
    );
  }
}
