
import 'package:stacked/stacked.dart';

class AniPlayViewModel extends BaseViewModel {

  String get url => _url;

  late String _url;

  void init(String url) {
    _url = url;
  }
}
