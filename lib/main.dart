// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mtg_stream_bloc/initialization.dart';
import 'package:mtg_stream_bloc/ui/components/app.dart';

void main() {
  initializeServices();

  runApp(
    const App(),
  );
}
