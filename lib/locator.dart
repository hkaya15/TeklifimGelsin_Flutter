import 'package:get_it/get_it.dart';
import 'package:teklifimgelsin/ui/GetOffer/repository/getofferrepo.dart';
import 'package:teklifimgelsin/ui/GetOffer/service/postapi.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => API());
  locator.registerLazySingleton(() => GetOfferRepo());
}