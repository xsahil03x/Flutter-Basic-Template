import 'package:flutter_template/modules/base/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends BaseBloc {
  final _subjectDataLoadingMessage =
      BehaviorSubject<String>.seeded('Requesting Data From Server...');

  @override
  void dispose() {
    _subjectDataLoadingMessage?.close();
  }
}
