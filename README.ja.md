<div align="center">

# Termdock

**Claude Code、Codex、Gemini CLI などのための AI ターミナル。**

デスクトップのワークスペースでエージェントを並行して実行し、複数のコンピューターを接続して Git の変更を確認できます。スマートフォンからターミナルを操作することもできます。Termdock は macOS と Windows に対応しています。

[![Product Hunt](https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=1033858&theme=light)](https://www.producthunt.com/products/termdock)

**言語**: [English](README.md) | [繁體中文](README.zh-TW.md) | 日本語

[ダウンロード](https://github.com/termdock/termdock-issues/releases/latest) • [ドキュメント](https://termdock.com/docs) • [問題を報告](https://github.com/termdock/termdock-issues/issues) • [ディスカッション](https://github.com/termdock/termdock-issues/discussions)

</div>

---

> **このリポジトリについて**：リリースのダウンロード、問題の報告、ディスカッションに利用できます。Termdock アプリの開発はプライベートリポジトリで行われています。

## デモ

[アニメーションを見る（92 MB）](demo.gif) · [YouTube でデモ動画を見る](https://www.youtube.com/watch?v=rjkPY-c4eMM)

---

## Termdock とは？

Termdock は、ターミナル、AI エージェントセッション、リモートワークスペース、Git レビューを一つにまとめたデスクトップアプリです。AI ツールは各自でインストールします。必要なアカウントやモデルの利用料金は各プロバイダーで別途用意します。背景、テーマ、フォントもカスタマイズできます。

### なぜ Termdock？

- **AI コーディングツールを並行して使う**：Claude Code、Codex、Gemini CLI、OpenCode、GitLab Duo をターミナルセッションで実行できます。
- **複数のコンピューターを接続**：Termdock 同士をペアリングして共有ワークスペースを使うか、ベータ版の SSH 接続でサーバーに接続できます。
- **作業を継続**：ホストが起動・ログイン中なら、ローカルと peer のターミナルはアプリの再起動中も動作を続けられます。SSH ターミナルはアプリとともに終了します。
- **AI の変更を確認**：Git の差分をレビューし、コードグラフで影響を受ける呼び出し元を調べられます。
- **スマートフォンのブラウザから操作**：信頼できるネットワークでペアリングすると、ターミナルの出力確認と入力ができます。デスクトップの Workstream パネルはブラウザにはありません。
- **画面をカスタマイズ**：テーマ、フォント、背景画像を選べます。

---

## はじめに

1. [最新リリース](https://github.com/termdock/termdock-issues/releases/latest)から macOS または Windows 版をダウンロードしてインストールします。
2. 使いたい AI CLI ツールをインストールし、それぞれにログインします。Termdock に各ツールのアカウントやサブスクリプションは含まれません。
3. プロジェクトフォルダをワークスペースとして開き、ターミナルを作成してエージェントを起動します。[入門ガイド](https://termdock.com/docs/getting-started)も参照してください。

バージョンごとの変更は[最新のリリースノート](https://github.com/termdock/termdock-issues/releases/latest)で確認できます。

---

## スクリーンショット

<div align="center">

### ビジュアル Git レビュー
*blame 付き 3 ペイン diff レビュー、ファイル横断ナビゲーション、Twin Focus トークンハイライト*

![Termdock ビジュアル Git レビュー — blame と Twin Focus ハイライト付き 3 ペイン diff レビュー](termdock-git-review.png)

### ワークスペースの開始画面
*ワークスペースを作成するか、ターミナルを開きます。*

![ワークスペースの作成とターミナルを開く選択肢がある Termdock の開始画面](termdock-code-analysis.png)

### マルチターミナルワークスペース
*ターミナル、ファイルプレビュー、リポジトリ、AI エージェントを一つのグリッドに*

![Termdock マルチターミナルワークスペース — 分割ペインとタブ](termdock-multi-terminal.png)

### テーマカスタマイズ
*ダークモード、ライトモード、カスタム背景とフォント — あなたのターミナル、あなたの画面*

![Termdock ターミナルテーマカスタマイズ — カスタム背景画像と半透明クローム](termdock-theme.png)

</div>

---

## 機能

### Claude Code、Codex などの AI エージェントを実行

**Claude Code、Codex、Gemini CLI、OpenCode、GitLab Duo** を管理対象のターミナルセッションで実行できます。ほかのコマンドラインツールもターミナルで利用できますが、エージェント固有の連携機能は提供元によって異なります。

- **Agent Workstream**：対応エージェントの hooks を設定すると、権限リクエスト、質問、プランをデスクトップパネルで確認できます。設定方法は [CLI ガイド](https://termdock.com/docs/cli)を参照してください。
- **Terminal API** — エージェントとスクリプトのためのローカル HTTP API：ターミナルセッション（ヘッドレス含む）の作成・制御・読み取り、SSE によるリアルタイム出力ストリーミング、サービストークン認証とレート制限。[API ドキュメント](https://termdock.com/docs/terminal-api)
- **`termdock` CLI**：macOS ではコマンドラインツールをインストールし、シェルスクリプトからセッションを作成・接続・追跡できます。Windows ではデスクトップアプリとローカル HTTP Terminal API を利用できます。CLI のワンクリックインストールは macOS のみです。
- **音声入力**（Whisper）、**AI 生成コミットメッセージ**（BYOK）、Termdock の AST・Terminal API の使い方を Claude Code に教える**インストール可能なスキル**

### 画面はあなたのもの

コードはエージェントに書かせても、一日 8 時間見つめる画面はあなたのものです。**好きな画像をターミナルの背景に** — Termdock は画像自身の色調から可読性スクリムを自動生成するので、文字はくっきり、絵はちゃんと見えます。

- **ダイナミックテーマシステム** — ダーク / ライトモードとテーマごとのアクセントカラーをアプリ全体に適用
- **カスタムターミナルフォント** — システム標準以外のカスタムフォント検索パスにも対応
- **半透明ガラスクローム** — ターミナルペインとペイン内ファイルビューアで統一されたデザイン
- **Discord Rich Presence** — Discord のステータスに Termdock のアクティビティを表示

### 速さが続くターミナル

エージェントの出力は滝のように流れてきます。Termdock は DOM のセル単位レイアウトではなく **WebGL（GPU）レンダリング**で処理し、大量出力時のレンダラー CPU を約 90% 削減。**自動省電力モード**がバッテリー時は消費を抑え、電源接続時は GPU をフル活用します。

- **セッションの継続**：ホストが起動・ログイン中なら、ローカルと peer のターミナルはアプリの終了、クラッシュ、更新後も動作を続けられます。SSH ターミナルはアプリとともに終了します。
- **分割ペインとタブ** — 水平分割（Cmd+D）、垂直分割（Cmd+Shift+D）、ドラッグ＆ドロップ並べ替え、クイック切り替え（Cmd+1–9）、ピクチャインピクチャモード
- **ドックパーキング** — 今は見ないターミナルをドックにドラッグ：ペインもタブも占有せず、通知は蓄積され、いつでも再開可能
- **バックグラウンド / ヘッドレスターミナル** — 長時間実行のシェルは可視ペインなしで完全な画面状態を保持

### クリックできる出力

シェル統合（OSC 133）が各コマンドの出力範囲と作業ディレクトリを追跡するため、出力内のファイルパスがそのまま使えます：git diff のプレフィックスは自動除去、折り返された長いパスも正しく再結合、相対パスはコマンドが実際に実行されたディレクトリを基準に解決。

- **リスニングポートバッジ** — ワークスペース内サービスのリスニングポートをサイドバーにリアルタイム表示。もう `lsof` は不要
- **ホスト検出** — 各セッションの接続先がローカル、SSH、コンテナのいずれかを Termdock が識別

### AI が書いたコードを検証する

「できました！」とエージェントは言います。本当にできているか、Termdock で確かめましょう。**ネイティブ Rust インデックスパイプライン**が構築するコードグラフは関数やクラスにとどまらず、Web フレームワークまで理解し、どんな diff も影響範囲まで遡れます。

- **Diff 影響分析** — git diff をコードグラフにマッピングし、影響を受ける呼び出し元まで遡って把握。エージェントの変更が実際に何に触れるのか、受け入れる前にわかります
- **フレームワークルートノード** — Express、Fastify、Koa、FastAPI、Flask のルートがグラフのファーストクラスノードに。route → handler → middleware を一気に追跡
- **Tree-sitter + LSP** で **13 以上の言語**に対応 — JavaScript、TypeScript、Python、Rust、Go、C、C++、Java、Ruby、PHP、Swift など
- **Code Graph MCP サーバー** — Claude Code、Codex、Cursor など MCP 対応ツールにコードベース構造を公開

### 作業する場所で Git レビュー

エージェントの成果を出荷する前の最終チェック — ブラウザに行き来せずに。Termdock は**ビジュアル Git レビュー画面**を内蔵：blame 付き 3 ペインレイアウト、ファイル横断ナビゲーション、大きなファイルもスムーズに処理。

- **Twin Focus** — 対応するトークンを両側で同時にハイライト。リネームの対応関係が一目瞭然
- **読み取り専用の merge / conflict レビュー**、ビジュアルブランチ管理、テーマに追従する配色

### 手間いらずのワークスペース

フォルダを Termdock にドロップすれば、それがワークスペース。タグを付ければ、サイドバーとクイック切り替え（Cmd+P）が自動でグループ化します。

- **ペイン内ファイルプレビュー** — Markdown、コード、JSON/YAML/XML、PDF、画像をターミナルと同じグリッド・タブ・ドラッグ＆ドロップルールで開けます
- フル機能のファイルエクスプローラー、`*`/`?` ワイルドカード対応のあいまい検索、Markdown のスタンドアロン HTML エクスポート

### マシンをまたいで働く

プロジェクトが 1 台のマシンに収まっているとは限りません。Termdock はリモートワークスペースをローカルの隣にマウントします — 同じグリッド、同じタブ、同じショートカット。

- **LAN ペアリモート** — 同一ネットワークの機器を自動発見。一度ペアリングすれば信頼関係を維持し、共有ワークスペースをエンドツーエンド暗号化チャネルでマウント。クラウド中継なし
- **SSH リモートワークスペース（ベータ）**：SSH で接続できるサーバーのターミナルを Termdock で開けます。SSH ターミナルはアプリ終了時に終了します。
- **再接続**：短時間の切断後に再接続できます。バックグラウンドターミナルの継続には、ホストが起動・ログイン中である必要があります。
- **ホストが主導権を持つ** — 共有は設定で有効にするまでオフ。危険なルートは拒否され、接続中のセッションは可視化され個別に終了できます

### スマートフォンやブラウザから操作

信頼できるネットワークでスマートフォンやデスクトップブラウザをペアリングすると、ローカルターミナルの出力を確認し、入力を送信できます。ブラウザ接続は HTTP を使用するため、信頼できるネットワークで使い、外部から接続する場合は Tailscale などの VPN を各自で設定してください。ブラウザにはデスクトップの Workstream 承認パネルはありません。[ブラウザ接続ガイド](https://termdock.com/docs/browser-access)

**Telegram や Discord** を使ったターミナルへの入力、出力の確認、通知、スクリーンショット取得にも対応しています。[リモート操作ガイド](https://termdock.com/docs/remote-control)

---

## ロードマップとリリース

[ロードマップ](https://termdock.com/roadmap)は長期的な計画を示しており、最新リリースより古い場合があります。提供済みの機能は[リリースノート](https://github.com/termdock/termdock-issues/releases)で確認できます。アイデアや要望は[ディスカッション](https://github.com/termdock/termdock-issues/discussions)にお寄せください。

---

## ダウンロードとインストール

### macOS — Homebrew（推奨）

```bash
brew tap termdock/termdock-issues https://github.com/termdock/termdock-issues
brew install --cask termdock
```

### 手動ダウンロード

**最新リリース**: [こちらからダウンロード](https://github.com/termdock/termdock-issues/releases/latest)

| プラットフォーム | ファイル |
|---|---|
| macOS（Apple Silicon、推奨） | `Termdock-x.x.x-arm64.dmg` |
| macOS（Intel） | `Termdock-x.x.x.dmg` |
| Windows | 最新リリースに含まれる `.exe` インストーラー |
| Linux | 公開インストーラーはまだありません |

**macOS の最低バージョン**：macOS 12.0 以降。Intel と Apple Silicon に対応しています。

**macOS インストール手順**
1. お使いの Mac に対応した DMG をダウンロード
2. DMG を開き、Termdock をアプリケーションフォルダにドラッグ
3. macOS が初回起動をブロックした場合は、セキュリティのメッセージとダウンロード元を確認してから許可してください。

**Windows のインストール**：最新リリースの `.exe` インストーラーをダウンロードして実行し、画面の案内に従ってください。

アプリやターミナルが起動しない場合は、[問題を報告](https://github.com/termdock/termdock-issues/issues)する際に Termdock のバージョン、OS、エラー情報を記載してください。

---

## バグ報告と機能リクエスト

バグを見つけた、アイデアがある — ぜひ聞かせてください！

[**Issue を作成**](https://github.com/termdock/termdock-issues/issues) | [**ディスカッションを開始**](https://github.com/termdock/termdock-issues/discussions)

### 報告の前に

- 同じ問題が既に報告されていないか確認
- 最新バージョンで試す
- 以下の情報を含めてください：
  - OS とバージョン（macOS / Windows）
  - Termdock のバージョン
  - 再現手順
  - エラーログ（該当する場合）

---

## コミュニティとサポート

- **Issue**: [GitHub Issues](https://github.com/termdock/termdock-issues/issues)
- **ディスカッション**: [GitHub Discussions](https://github.com/termdock/termdock-issues/discussions)
- **ドキュメント**: [termdock.com/docs](https://termdock.com/docs)
- **ウェブサイト**: [termdock.com](https://termdock.com)

---

## 更新情報を受け取る

新しいリリースの通知を受け取るには：
1. 上部の **Watch** をクリック
2. **Custom** → **Releases** を選択

---

<div align="center">

**Termdock — コードは AI に、画面は永遠にあなたのものに**

仕事は任せても、センスは任せない開発者のために

[ウェブサイト](https://termdock.com) • [ダウンロード](https://github.com/termdock/termdock-issues/releases/latest) • [ドキュメント](https://termdock.com/docs)

</div>
