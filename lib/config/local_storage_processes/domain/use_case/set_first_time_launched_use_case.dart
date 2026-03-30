import 'package:fitness_app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class SetFirstTimeLaunchedUseCase {
  final StorageDataSourceContract _storageDataSourceContract;
  SetFirstTimeLaunchedUseCase(this._storageDataSourceContract);

  void invokeSetFirstTimeLaunched(bool firstTimeLaunched) => _storageDataSourceContract.setFirstTimeLaunched(firstTimeLaunched);
}