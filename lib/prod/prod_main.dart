import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../main.dart';

void main() {
  dotenv.load(fileName: '.env.prod').then((value) => mainDelegate());
}
