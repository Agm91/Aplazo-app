import 'package:aplazo_app/domain/models/purchase.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';
import 'package:aplazo_app/domain/usecase/register_purchase_usecase.dart';
import 'package:aplazo_app/l10n/app_localizations.dart';
import 'package:aplazo_app/screens/dp.dart';
import 'package:aplazo_app/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:aplazo_app/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class RegisterPurchaseScreen extends StatefulWidget {
  final RegisterCustomerResponse registerCustomerResponse;
  final registerPurchaseUsecase = GetIt.instance
      .get<RegisterPurchaseUsecase>(instanceName: 'RegisterPurchaseUsecase');

  RegisterPurchaseScreen({required this.registerCustomerResponse});

  @override
  _RegisterPurchaseScreenState createState() => _RegisterPurchaseScreenState();
}

class _RegisterPurchaseScreenState extends State<RegisterPurchaseScreen> {
  final TextEditingController _purchaseAmountController =
      TextEditingController();

  void _registerPurchase() async {
    final purchaseAmount = _purchaseAmountController.text;

    if (purchaseAmount.isEmpty) {
      Utils.showErrorDialog(
        context,
        AppLocalizations.of(context)!.translate('error'),
        AppLocalizations.of(context)!.translate('error_empty'),
      );
      return;
    }

    final Purchase purchase = Purchase(
        customerId: widget.registerCustomerResponse.customerId.toString(),
        purchaseAmount: purchaseAmount);

    final result = await widget.registerPurchaseUsecase
        .call(RegisterPurchaseUsecaseParams(purchase: purchase));

    result.fold(
      onError: (error) => Utils.showErrorDialog(
        context,
        AppLocalizations.of(context)!.translate('error'),
        error.message,
      ),
      onSuccess: (registerCustomerResponse) {
        Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(name: "/success"),
              builder: (context) => SuccessScreen(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.translate('title_register_purchase')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _purchaseAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!
                    .translate('field_purchase_amount'),
              ),
            ),
            SizedBox(height: Dp.SPACER_3),
            ElevatedButton(
              onPressed: _registerPurchase,
              child: Text(AppLocalizations.of(context)!
                  .translate('button_register_purchase')),
            ),
          ],
        ),
      ),
    );
  }
}
