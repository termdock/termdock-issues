<div align="center">

# Termdock

**コードは AI に。画面はあなたのものに。**

*macOS & Windows のための AI ネイティブターミナル — 仕事は Claude Code、Codex、Gemini、GitLab Duo に任せて、GPU アクセラレーションされたワークスペースからすべてを監督。そして背景の 1 ピクセルまで、あなたの自由に。*

[![Product Hunt](https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=1033858&theme=light)](https://www.producthunt.com/products/termdock)

**言語**: [English](README.md) | [繁體中文](README.zh-TW.md) | 日本語

[ダウンロード](https://github.com/termdock/termdock-issues/releases/latest) • [ドキュメント](https://termdock.com/docs) • [問題を報告](https://github.com/termdock/termdock-issues/issues) • [ディスカッション](https://github.com/termdock/termdock-issues/discussions)

</div>

---

## デモ

![Termdock デモ — カスタム背景とテーマのマルチターミナルワークスペースでコーディングする AI エージェント](demo.gif)

**[▶ YouTube でフルビデオを見る](https://www.youtube.com/watch?v=rjkPY-c4eMM)**

> **注意**: このリポジトリは **Termdock リリースのダウンロード**と**問題の報告**のためのものです。開発はプライベートリポジトリで行われています。

---

## Termdock とは？

ソフトウェア開発は変わりました：エージェントが書き、あなたが指揮する。Termdock はその現実のために作られた **macOS と Windows 対応のターミナルファースト開発環境**です。高速な GPU アクセラレーションターミナルの中で、**Claude Code、Codex、Gemini CLI、GitLab Duo** がファーストクラスのセッションとして動き、権限リクエストはスクロールに流されず承認パネルに届き、書かれたコードはコードインテリジェンスとビジュアル Git レビューで検証できます。そして一日中見つめる画面は、完全にあなたのもの：カスタム背景画像、テーマ、フォント、半透明クローム。

### なぜ Termdock？

- **AI エージェントネイティブ** — Claude Code、Codex、Gemini CLI、GitLab Duo をファーストクラスセッションとしてサポート。エージェントはデフォルトでバックグラウンド動作、あなたのペインを奪いません
- **主導権はあなたに** — 権限リクエスト、質問、プランレビューはカードになり、専用パネルで承認 / 拒否。席を外していてもスマートフォンから
- **AI が書いたコードを検証** — Web フレームワークを認識するコードグラフ、diff 影響分析、blame と Twin Focus ハイライト付きの 3 ペインビジュアル Git レビュー
- **画面はあなたのもの** — カスタム背景画像、ダーク / ライトテーマ、カスタムフォント、半透明ガラスクローム
- **高速で省電力** — WebGL（GPU）レンダリングで大量出力時のレンダラー CPU を約 90% 削減、バッテリー時は自動省電力

---

## ✨ v1.16 の新機能

- **Git レビュー、全面刷新** — blame 付き 3 ペインビジュアル diff レビュー、Twin Focus トークンハイライト、読み取り専用 merge / conflict レビュー
- **ドックパーキング** — ターミナルセッションをドックへドラッグ。非表示でもセッションは生きたまま、通知はたまり続けます
- **フォルダをドロップすればワークスペース** — ドラッグ＆ドロップで即作成
- **フレームワークを知るコードグラフ** — Express / Fastify / Koa / FastAPI / Flask のルートがファーストクラスノードに。あらゆる変更に diff 影響分析
- **ネイティブ Rust インデックスパイプライン** — 大規模プロジェクトで大幅に高速化
- **GitLab Duo がエージェントに仲間入り** — Claude Code、Codex、Gemini とともに

[リリースノート全文 →](https://github.com/termdock/termdock-issues/releases/latest)

---

## スクリーンショット

<div align="center">

### ビジュアル Git レビュー — v1.16 新機能
*blame 付き 3 ペイン diff レビュー、ファイル横断ナビゲーション、Twin Focus トークンハイライト*

![Termdock ビジュアル Git レビュー — blame と Twin Focus ハイライト付き 3 ペイン diff レビュー](termdock-git-review.png)

### コードインテリジェンス
*13 以上の言語に対応したシンボル検索、コールグラフ、依存関係の可視化*

![Termdock コード分析 — AST シンボル検索と依存グラフ](termdock-code-analysis.png)

### マルチターミナルワークスペース
*ターミナル、ファイルプレビュー、リポジトリ、AI エージェントを一つのグリッドに*

![Termdock マルチターミナルワークスペース — 分割ペインとタブ](termdock-multi-terminal.png)

### テーマカスタマイズ
*ダークモード、ライトモード、カスタム背景とフォント — あなたのターミナル、あなたの画面*

![Termdock ターミナルテーマカスタマイズ — カスタム背景画像と半透明クローム](termdock-theme.png)

</div>

---

## 機能

### 仕事を任せる

流れていくスクロールをずっと見張っている必要は、もうありません。Termdock では **Claude Code、Codex、Gemini CLI、GitLab Duo** が管理されたエージェントセッションとして動きます — デフォルトでバックグラウンド動作なので、エージェントが黙々と働いている間も、あなたのペインはあなたのものです。

- **Agent Workstream** — 権限リクエスト、質問、プランレビューを構造化カードとしてインターセプト。専用パネルから承認・拒否・返信。`termdock hooks setup` 一発でフックを自動設定
- **Terminal API** — エージェントとスクリプトのためのローカル HTTP API：ターミナルセッション（ヘッドレス含む）の作成・制御・読み取り、SSE によるリアルタイム出力ストリーミング、サービストークン認証とレート制限。[API ドキュメント](https://termdock.com/docs/terminal-api)
- **`termdock` CLI** — 任意のシェルスクリプトからセッションの作成・アタッチ・フォロー、フォーカス中ワークスペースの照会
- **音声入力**（Whisper）、**AI 生成コミットメッセージ**（BYOK）、Termdock の AST・Terminal API の使い方を Claude Code に教える**インストール可能なスキル**

### 画面はあなたのもの

コードはエージェントに書かせても、一日 8 時間見つめる画面はあなたのものです。**好きな画像をターミナルの背景に** — Termdock は画像自身の色調から可読性スクリムを自動生成するので、文字はくっきり、絵はちゃんと見えます。

- **ダイナミックテーマシステム** — ダーク / ライトモードとテーマごとのアクセントカラーをアプリ全体に適用
- **カスタムターミナルフォント** — システム標準以外のカスタムフォント検索パスにも対応
- **半透明ガラスクローム** — ターミナルペインとペイン内ファイルビューアで統一されたデザイン
- **Discord Rich Presence** — Discord のステータスに Termdock のアクティビティを表示

### 速さが続くターミナル

エージェントの出力は滝のように流れてきます。Termdock は DOM のセル単位レイアウトではなく **WebGL（GPU）レンダリング**で処理し、大量出力時のレンダラー CPU を約 90% 削減。**自動省電力モード**がバッテリー時は消費を抑え、電源接続時は GPU をフル活用します。

- **セッション復元** — アプリを終了して戻ってきても、すべてのターミナルが元の場所に
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

### 見守りはポケットの中で

席を離れてもエージェントは止まりません。あなたの見守りも、止める必要はありません。**Telegram や Discord** からターミナルをリモート操作：入力送信、出力読み取り、バックグラウンドターミナルの出力時にプッシュ通知（/watch）、スクリーンショット取得（/snap）。[セットアップガイド](https://termdock.com/docs/remote-control)

---

## 今後の予定

### v1.17 — エージェントエコシステム（開発中）

- **OpenCode 統合** — OpenCode が Claude Code、Codex、Gemini に続く 4 番目のエージェントセッションプロバイダに。HTTP + SSE デーモンクライアントとインタラクティブターミナルセッションを搭載
- **ACP / AI API プロバイダオプション** — プロバイダ設定の拡張

### その先（v1.18 以降）

- **リモート / ブラウザアクセス** — デスクトップアプリの外からターミナルへ
- **マルチ Git リポジトリワークスペース** — 単一ワークスペースに複数リポジトリをマウント
- **Windows ネイティブ Rust PTY**
- **Linux サポート**

[ロードマップ全体を見る](https://termdock.com/roadmap) • [機能リクエスト](https://github.com/termdock/termdock-issues/discussions)

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
| Windows | `Termdock.Setup.x.x.x.exe` |
| Linux | 近日対応予定 |

**macOS 動作要件**：macOS 10.14 以降、Intel または Apple Silicon（M1/M2/M3/M4 推奨）

**macOS インストール手順**
1. お使いの Mac に対応した DMG をダウンロード
2. DMG を開き、Termdock をアプリケーションフォルダにドラッグ
3. 初回起動時に `システム環境設定` → `セキュリティとプライバシー` での許可が必要な場合があります

> **Intel Mac をお使いの方へ**：ターミナルが起動しない場合は、バージョン 1.3.2 以降に更新してください（ARM64 PTY 読み込みの問題を修正済み）。エラーが続く場合は、エラーダイアログの「OK」をクリックしてログをコピーし、[GitHub issue に貼り付けて](https://github.com/termdock/termdock-issues/issues)ください。

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
