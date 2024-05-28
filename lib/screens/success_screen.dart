import 'package:aplazo_app/l10n/app_localizations.dart';
import 'package:aplazo_app/screens/dp.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('title_success')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!
              .translate('label_purchase_register_success'),
          style: TextStyle(fontSize: Dp.SPACER_3),
        ),
      ),
    );
  }
}
