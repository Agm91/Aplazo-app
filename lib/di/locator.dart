import 'package:aplazo_app/data/local/purchase_database_service.dart';
import 'package:aplazo_app/data/network/register_customer_service.dart';
import 'package:aplazo_app/data/network/register_purchase_service.dart';
import 'package:aplazo_app/domain/repositories/register_customer_repository.dart';
import 'package:aplazo_app/domain/repositories/register_purchase_repository.dart';
import 'package:aplazo_app/domain/usecase/register_customer_usecase.dart';
import 'package:aplazo_app/domain/usecase/register_purchase_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void _dataRegister() {
  // Services
  getIt.registerSingleton<RegisterCustomerService>(RegisterCustomerServiceImp(),
      instanceName: 'RegisterCustomerService');
  getIt.registerSingleton<RegisterPurchaseService>(
      RegisterPurchaseServiceImpl(),
      instanceName: 'RegisterPurchaseService');

  // DB
  getIt.registerSingleton<PurchaseDatabaseService>(PurchaseDatabaseService(),
      instanceName: 'PurchaseDatabaseService');

  // Repo
  getIt.registerSingleton<RegisterPurchaseRepository>(
      RegisterPurchaseRepositoryImpl(
        registerPurchaseService: getIt.get<RegisterPurchaseService>(
            instanceName: 'RegisterPurchaseService'),
        databaseService: getIt.get<PurchaseDatabaseService>(
            instanceName: 'PurchaseDatabaseService'),
      ),
      instanceName: 'RegisterPurchaseRepository');
  getIt.registerSingleton<RegisterCustomerRepository>(
      RegisterCustomerRepositoryImpl(
          registerCustomerService: getIt.get<RegisterCustomerService>(
              instanceName: 'RegisterCustomerService')),
      instanceName: 'RegisterCustomerRepository');

  // UseCases
  getIt.registerSingleton<RegisterCustomerUsecase>(
      RegisterCustomerUsecase(
          repository: getIt.get<RegisterCustomerRepository>(
              instanceName: 'RegisterCustomerRepository')),
      instanceName: 'RegisterCustomerUsecase');
  getIt.registerSingleton<RegisterPurchaseUsecase>(
      RegisterPurchaseUsecase(
        repository: getIt.get<RegisterPurchaseRepository>(
            instanceName: 'RegisterPurchaseRepository'),
      ),
      instanceName: 'RegisterPurchaseUsecase');
}

void setupDI() {
  _dataRegister();
}
