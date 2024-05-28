import 'package:aplazo_app/domain/models/customer.dart';
import 'package:aplazo_app/domain/usecase/register_customer_usecase.dart';
import 'package:aplazo_app/l10n/app_localizations.dart';
import 'package:aplazo_app/screens/dp.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:aplazo_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:aplazo_app/widgets/custom_text_field.dart';
import 'list_of_purchases_screen.dart';

class RegisterCustomerScreen extends StatefulWidget {
  final registerCustomerUsecase = GetIt.instance
      .get<RegisterCustomerUsecase>(instanceName: 'RegisterCustomerUsecase');

  @override
  _RegisterCustomerScreenState createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    });
  }

  void _registerCustomer() async {
    final name = _nameController.text;
    final birthDateText = _dobController.text;

    if (name.isEmpty || birthDateText.isEmpty) {
      Utils.showErrorDialog(
          context,
          AppLocalizations.of(context)!.translate('error'),
          AppLocalizations.of(context)!.translate('error_empty'));
      return;
    }

    final DateTime birthDate = DateTime.parse(birthDateText);
    final DateTime now = DateTime.now();
    final int age = now.year -
        birthDate.year -
        ((now.month < birthDate.month) ||
                (now.month == birthDate.month && now.day < birthDate.day)
            ? 1
            : 0);

    if (age < 18 || age > 65) {
      Utils.showErrorDialog(
        context,
        AppLocalizations.of(context)!.translate('error'),
        AppLocalizations.of(context)!.translate('error_age'),
      );
      return;
    }

    final result = await widget.registerCustomerUsecase.call(
        RegisterCustomerUsecaseParams(
            customer: Customer(name: name, birthDate: birthDateText)));

    result.fold(
      onError: (error) => Utils.showErrorDialog(context,
          AppLocalizations.of(context)!.translate('error'), error.message),
      onSuccess: (registerCustomerResponse) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListOfPurchasesScreen(
                registerCustomerResponse: registerCustomerResponse),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.translate('title_register_customer')),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dp.SPACER_2),
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: _nameController,
              label: AppLocalizations.of(context)!.translate('field_name'),
            ),
            SizedBox(height: Dp.SPACER_2),
            CustomTextField(
              controller: _dobController,
              label: AppLocalizations.of(context)!
                  .translate('field_date_of_birth'),
              onTap: _presentDatePicker,
              readOnly: true,
            ),
            SizedBox(height: Dp.SPACER_3),
            ElevatedButton(
              onPressed: _registerCustomer,
              child: Text(AppLocalizations.of(context)!
                  .translate('button_register_customer')),
            ),
          ],
        ),
      ),
    );
  }
}
