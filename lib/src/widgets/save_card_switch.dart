import 'package:begateway_flutter_sdk/src/providers/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../localization/find_translation.dart';

class SaveCardSwitchRow extends StatelessWidget {
  const SaveCardSwitchRow({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Column(
      children: [
        Row(
          children: [
        CupertinoSwitch(
          value: appState.isSaveCard,
          trackColor: const Color(0xFF929DA9),
          activeColor: const Color(0xFF0065FF),
          onChanged: (value) {
            appState.setIsSaveCard(value);
          },
        ),
        const SizedBox(width: 10),
        Text(findTranslation(appState.language.toString(),"begateway_savecard")),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
