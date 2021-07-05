// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_archive_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostArchiveStore on _PostArchiveStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostArchiveStore.loading')).value;
  Computed<ObservableList<PostArchive>> _$postArchivesComputed;

  @override
  ObservableList<PostArchive> get postArchives => (_$postArchivesComputed ??=
          Computed<ObservableList<PostArchive>>(() => super.postArchives, name: '_PostArchiveStore.postArchives'))
      .value;

  final _$fetchPostArchivesFutureAtom = Atom(name: '_PostArchiveStore.fetchPostArchivesFuture');

  @override
  ObservableFuture<List<PostArchive>> get fetchPostArchivesFuture {
    _$fetchPostArchivesFutureAtom.reportRead();
    return super.fetchPostArchivesFuture;
  }

  @override
  set fetchPostArchivesFuture(ObservableFuture<List<PostArchive>> value) {
    _$fetchPostArchivesFutureAtom.reportWrite(value, super.fetchPostArchivesFuture, () {
      super.fetchPostArchivesFuture = value;
    });
  }

  final _$_postArchivesAtom = Atom(name: '_PostArchiveStore._postArchives');

  @override
  ObservableList<PostArchive> get _postArchives {
    _$_postArchivesAtom.reportRead();
    return super._postArchives;
  }

  @override
  set _postArchives(ObservableList<PostArchive> value) {
    _$_postArchivesAtom.reportWrite(value, super._postArchives, () {
      super._postArchives = value;
    });
  }

  final _$successAtom = Atom(name: '_PostArchiveStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_PostArchiveStore._loading');

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  final _$getPostArchivesAsyncAction = AsyncAction('_PostArchiveStore.getPostArchives');

  @override
  Future<void> getPostArchives() {
    return _$getPostArchivesAsyncAction.run(() => super.getPostArchives());
  }

  final _$_PostArchiveStoreActionController = ActionController(name: '_PostArchiveStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostArchiveStoreActionController.startAction(name: '_PostArchiveStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostArchiveStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostArchivesFuture: ${fetchPostArchivesFuture},
success: ${success},
loading: ${loading},
postArchives: ${postArchives}
    ''';
  }
}
