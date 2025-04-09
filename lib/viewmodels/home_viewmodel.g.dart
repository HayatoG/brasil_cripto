// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  Computed<List<CoinListModel>>? _$filteredCoinsComputed;

  @override
  List<CoinListModel> get filteredCoins => (_$filteredCoinsComputed ??=
          Computed<List<CoinListModel>>(() => super.filteredCoins,
              name: '_HomeViewModelBase.filteredCoins'))
      .value;

  late final _$allCoinsAtom =
      Atom(name: '_HomeViewModelBase.allCoins', context: context);

  @override
  ObservableList<CoinListModel> get allCoins {
    _$allCoinsAtom.reportRead();
    return super.allCoins;
  }

  @override
  set allCoins(ObservableList<CoinListModel> value) {
    _$allCoinsAtom.reportWrite(value, super.allCoins, () {
      super.allCoins = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_HomeViewModelBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeViewModelBase.errorMessage', context: context);

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

  late final _$loadAllCoinsAsyncAction =
      AsyncAction('_HomeViewModelBase.loadAllCoins', context: context);

  @override
  Future<void> loadAllCoins() {
    return _$loadAllCoinsAsyncAction.run(() => super.loadAllCoins());
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.setSearchQuery');
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allCoins: ${allCoins},
searchQuery: ${searchQuery},
errorMessage: ${errorMessage},
filteredCoins: ${filteredCoins}
    ''';
  }
}
