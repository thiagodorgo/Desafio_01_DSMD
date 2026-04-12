import 'package:mobx/mobx.dart';
  import '../../home/model/address_model.dart';
  import '../../home/repositories/address_local_repository.dart';

  part 'history_controller.g.dart';

  class HistoryController = _HistoryControllerBase with _$HistoryController;

  abstract class _HistoryControllerBase with Store {
    final AddressLocalRepository _repository = AddressLocalRepository();

    @observable
    ObservableList<AddressModel> addresses = ObservableList<AddressModel>();

    @observable
    bool isLoading = false;

    @action
    void loadHistory() {
      isLoading = true;
      addresses = ObservableList.of(_repository.getAll());
      isLoading = false;
    }

    @action
    Future<void> clearHistory() async {
      await _repository.clear();
      addresses.clear();
    }
  }
  