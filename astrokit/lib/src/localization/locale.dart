import 'package:flutter/widgets.dart';

dynamic getLocale(context) => Localizations.maybeLocaleOf(context)?.toLanguageTag();