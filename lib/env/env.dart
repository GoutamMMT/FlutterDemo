// ignore_for_file: constant_identifier_names

import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'AndroidFirebaseAPIKEY')
  static const String AndroidFirebaseAPIKEY = _Env.AndroidFirebaseAPIKEY;
  @EnviedField(varName: 'IOSFirebaseAPIKEY')
  static const String IOSFirebaseAPIKEY = _Env.IOSFirebaseAPIKEY;
}
