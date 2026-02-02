import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/provider/auth_provider.dart';
import '../features/home/data/datasources/home_remote_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_leads_usecase.dart';
import '../features/home/presentation/provider/home_provider.dart';
import '../features/ocr/data/datasources/ocr_mlkit_datasource.dart';
import '../features/ocr/data/repositories/ocr_repository_impl.dart';
import '../features/ocr/domain/repositories/ocr_repository.dart';
import '../features/ocr/domain/usecases/process_image_usecase.dart';
import '../features/ocr/presentation/provider/ocr_provider.dart';
import 'network/api_service.dart';
import 'network/dio_client.dart';
import 'services/shared_preferences_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Provider
  sl.registerFactory(
    () => AuthProvider(loginUseCase: sl(), sharedPreferencesService: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  //! Features - Home
  // Provider
  sl.registerFactory(() => HomeProvider(getLeadsUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetLeadsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      dioClient: sl<DioClient>(),
      sharedPreferencesService: sl(),
    ),
  );

  //! Features - OCR
  // Provider
  sl.registerFactory(() => OcrProvider(processImageUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => ProcessImageUseCase(sl()));

  // Repository
  sl.registerLazySingleton<OcrRepository>(
    () => OcrRepositoryImpl(ocrMlkitDatasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OcrMlkitDatasource>(() => OcrMlkitDatasourceImpl());

  //! Core
  sl.registerLazySingleton(() => ApiService(sl()));
  sl.registerLazySingleton(() => DioClient());

  // Services
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  sl.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
