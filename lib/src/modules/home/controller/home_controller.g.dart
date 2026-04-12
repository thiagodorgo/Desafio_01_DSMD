// GENERATED CODE - DO NOT MODIFY BY HAND

  part of 'home_controller.dart';

  // **************************************************************************
  // StoreGenerator
  // **************************************************************************

  // ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

  mixin _$HomeController on _HomeControllerBase, Store {
    late final _$addressAtom =
        Atom(name: '_HomeControllerBase.address', context: context);

    @override
    AddressModel? get address {
      _$addressAtom.reportRead();
      return super.address;
    }

    @override
    set address(AddressModel? value) {
      _$addressAtom.reportWrite(value, super.address, () {
        super.address = value;
      });
    }

    late final _$isLoadingAtom =
        Atom(name: '_HomeControllerBase.isLoading', context: context);

    @override
    bool get isLoading {
      _$isLoadingAtom.reportRead();
      return super.isLoading;
    }

    @override
    set isLoading(bool value) {
      _$isLoadingAtom.reportWrite(value, super.isLoading, () {
        super.isLoading = value;
      });
    }

    late final _$errorMessageAtom =
        Atom(name: '_HomeControllerBase.errorMessage', context: context);

    @override
    String? get errorMessage {
      _$errorMessageAtom.reportRead();
      return super.errorMessage;
    }

    @override
    set errorMessage(String? value) {
      _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
        super.errorMessage = value;
      });
    }

    late final _$isEmptyAtom =
        Atom(name: '_HomeControllerBase.isEmpty', context: context);

    @override
    bool get isEmpty {
      _$isEmptyAtom.reportRead();
      return super.isEmpty;
    }

    @override
    set isEmpty(bool value) {
      _$isEmptyAtom.reportWrite(value, super.isEmpty, () {
        super.isEmpty = value;
      });
    }

    late final _$searchByCepAsyncAction =
        AsyncAction('_HomeControllerBase.searchByCep', context: context);

    @override
    Future<void> searchByCep(String cep) {
      return _$searchByCepAsyncAction.run(() => super.searchByCep(cep));
    }

    late final _$_HomeControllerBaseActionController =
        ActionController(name: '_HomeControllerBase', context: context);

    @override
    void reset() {
      final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
          name: '_HomeControllerBase.reset');
      try {
        return super.reset();
      } finally {
        _$_HomeControllerBaseActionController.endAction(_$actionInfo);
      }
    }

    @override
    String toString() {
      return 'HomeController(address: ${address}, isLoading: ${isLoading}, errorMessage: ${errorMessage}, isEmpty: ${isEmpty})';
    }
  }
  