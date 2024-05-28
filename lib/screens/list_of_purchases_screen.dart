import 'package:aplazo_app/domain/entities/purchase_entity.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';
import 'package:aplazo_app/l10n/app_localizations.dart';
import 'package:aplazo_app/screens/register_purchase_screen.dart';
import 'package:flutter/material.dart';
import '../data/local/purchase_database_service.dart';

class ListOfPurchasesScreen extends StatefulWidget {
  final RegisterCustomerResponse registerCustomerResponse;

  ListOfPurchasesScreen({required this.registerCustomerResponse});

  @override
  _ListOfPurchasesScreenState createState() => _ListOfPurchasesScreenState();
}

class _ListOfPurchasesScreenState extends State<ListOfPurchasesScreen> {
  List<PurchaseEntity> _purchases = [];

  @override
  void initState() {
    super.initState();
    _fetchPurchases();
  }

  Future<void> _fetchPurchases() async {
    final purchases = await PurchaseDatabaseService().getPurchases();
    setState(() {
      _purchases = purchases;
    });
  }

  void _navigateToRegisterPurchase() async {
    final _ = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: "/purchase"),
        builder: (context) => RegisterPurchaseScreen(
            registerCustomerResponse: widget.registerCustomerResponse),
      ),
    );
    _fetchPurchases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.translate('title_list_purchases')),
      ),
      body: ListView.builder(
        itemCount: _purchases.length,
        itemBuilder: (ctx, index) {
          final purchase = _purchases[index];
          return ListTile(
            title: Text(AppLocalizations.of(context)!.translate(
                'label_purchase_amount',
                params: {'amount': purchase.amount.toString()})),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegisterPurchase,
        child: Icon(Icons.add),
      ),
    );
  }
}
