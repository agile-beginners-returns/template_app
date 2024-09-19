# kagb_template

ハッカソン用の Flutter アプリ作成時の流れ（必要であればガンガン更新しよー）

## 1. パッケージのインストール

### 利用するパッケージの一覧（必要に応じて書き換える）

### 状態管理関連

- flutter_riverpod
- riverpod_annotation
- riverpod_generator
- build_runner
- custom_lint
- riverpod_lint

#### pubspec.yaml に追加コマンド

```
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
```

追加後に実行するコマンド

```
flutter pub get
```

riverpod で作成する Provider は原則コードジェンレーターを用いて行うようにする？

コードジェネレーター実行コマンド

```
dart run build_runner build
```

### 2.通信関連＋モデルクラス作成

- http: データ通信用
- freezed: 変更できないモデルクラスを作成する用
- json_serializable:

pubspec.yaml に追加するコマンド

```
flutter pub add http
dart pub add freezed
dart pub add dev:json_serializable
```

#### 注意点

Android アプリで http を利用する際には、AndroidManifest.xml( android > app > src > main > res > AndroidManifest.xml )ファイルに以下の内容を追記する必要がある

```
<!-- Required to fetch data from the internet. -->
<uses-permission android:name="android.permission.INTERNET" />
```

## 2.フォルダ構成は Feature-first
