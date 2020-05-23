// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perpage.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerPage on _PerPage, Store {
  final _$perPageAtom = Atom(name: '_PerPage.perPage');

  @override
  int get perPage {
    _$perPageAtom.reportRead();
    return super.perPage;
  }

  @override
  set perPage(int value) {
    _$perPageAtom.reportWrite(value, super.perPage, () {
      super.perPage = value;
    });
  }

  final _$_PerPageActionController = ActionController(name: '_PerPage');

  @override
  void nextPages() {
    final _$actionInfo =
        _$_PerPageActionController.startAction(name: '_PerPage.nextPages');
    try {
      return super.nextPages();
    } finally {
      _$_PerPageActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
perPage: ${perPage}
    ''';
  }
}
