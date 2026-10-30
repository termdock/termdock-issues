<div align="center">

# Termdock

**為 Claude Code、Codex、Gemini CLI 等 AI 程式工具打造的終端機。**

在桌面工作區並排執行 AI，連接多台電腦、檢查 Git 修改，也能用手機操作終端機。Termdock 支援 macOS 與 Windows。

[![Product Hunt](https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=1033858&theme=light)](https://www.producthunt.com/products/termdock)

**語言**: [English](README.md) | 繁體中文 | [日本語](README.ja.md)

[下載](https://github.com/termdock/termdock-issues/releases/latest) • [文件](https://termdock.com/docs) • [回報問題](https://github.com/termdock/termdock-issues/issues) • [討論區](https://github.com/termdock/termdock-issues/discussions)

</div>

---

> **這個儲存庫的用途**：下載發行版本、回報問題及參與討論。Termdock 應用程式的主要開發在私有儲存庫進行。

## 展示

[查看動態展示（92 MB）](demo.gif) · [在 YouTube 觀看影片](https://www.youtube.com/watch?v=rjkPY-c4eMM)

---

## 什麼是 Termdock？

Termdock 把終端機、AI 工作階段、遠端工作區和 Git 審查放進同一個桌面應用程式。你可以使用自己安裝的 AI 工具與帳號，模型服務的訂閱費用另計；工作區的背景、主題與字型也能自訂。

### 為什麼選擇 Termdock？

- **同時使用 AI 程式工具**：在終端工作階段執行 Claude Code、Codex、Gemini CLI、OpenCode 與 GitLab Duo。
- **連接多台電腦**：配對 Termdock 裝置，使用對方分享的工作區；也能透過 Beta 版 SSH 整合連線到伺服器。
- **讓工作繼續執行**：本機與 peer 終端機可在 App 重啟時繼續運作，但主機須保持開機與登入。SSH 終端會隨 App 結束。
- **檢查 AI 的修改**：查看 Git 差異，並用程式碼圖探索受影響的呼叫端。
- **用手機瀏覽器操作**：在可信任網路配對後查看終端輸出並送出輸入。桌面 Workstream 面板不在瀏覽器中提供。
- **自訂終端畫面**：選擇主題、字型與背景圖片。

---

## 開始使用

1. [下載最新發行版本](https://github.com/termdock/termdock-issues/releases/latest)，安裝 macOS 或 Windows 版本。
2. 安裝並登入想使用的 AI CLI 工具。Termdock 不包含這些工具的帳號或訂閱。
3. 開啟專案資料夾作為工作區，建立終端機後啟動 AI。詳見[入門指南](https://termdock.com/docs/getting-started/zh)。

各版本的變更請查看[最新發行說明](https://github.com/termdock/termdock-issues/releases/latest)。

---

## 螢幕截圖

<div align="center">

### 視覺化 Git Review
*三欄式 diff 審查含 blame、跨檔導航與 Twin Focus token 對應反白*

![Termdock 視覺化 Git review — 三欄式 diff 審查含 blame 與 Twin Focus 反白](termdock-git-review.png)

### 工作區歡迎畫面
*建立工作區或開啟終端機。*

![Termdock 歡迎畫面，提供建立工作區與開啟終端機的選項](termdock-code-analysis.png)

### 多終端工作區
*終端機、檔案預覽、repository 與 AI agent 在同一個 grid*

![Termdock 多終端工作區 — 分割視窗與分頁](termdock-multi-terminal.png)

### 主題自訂
*深色、淺色、自訂背景與字型 — 你的終端機、你的畫面*

![Termdock 終端機主題自訂 — 自訂背景圖與半透明外框](termdock-theme.png)

</div>

---

## 功能特色

### 執行 Claude Code、Codex 等 AI 工具

在受管理的終端工作階段執行 **Claude Code、Codex、Gemini CLI、OpenCode 與 GitLab Duo**。其他命令列工具也能在終端機執行；各 AI 的專屬整合功能可能不同。

- **Agent Workstream**：設定支援的 AI 工具 hooks 後，可在桌面面板處理權限請求、問題與計畫。設定方式見 [CLI 指南](https://termdock.com/docs/cli/zh)。
- **Terminal API** — 給 agent 與腳本的本地 HTTP API：建立、操控、讀取終端 session（含 headless）、SSE 即時串流輸出、service token 認證與速率限制。[API 文件](https://termdock.com/docs/terminal-api)
- **`termdock` CLI**：macOS 可安裝命令列工具，從 shell 腳本建立、接上及追蹤工作階段。Windows 可使用桌面 App 與本地 HTTP Terminal API；CLI 一鍵安裝目前限 macOS。
- **語音輸入**（Whisper）、**AI 生成 commit 訊息**（BYOK）、可安裝的 **Claude Code Skills** 教 Claude Code 操作 Termdock 的 AST 與 Terminal API

### 畫面由你作主

程式碼可以讓 agent 寫，但你一天盯八小時的畫面是你的。**把你想放的圖放到終端機背後** — Termdock 會從圖片本身的色調生成可讀性遮罩，文字清晰、圖也看得見。

- **動態主題系統** — 深色、淺色模式與各主題強調色貫穿整個應用程式
- **自訂終端字型** — 包含系統位置以外的自訂字型搜尋路徑
- **半透明玻璃外框** — 終端 pane 與 pane 內檔案檢視器視覺統一
- **Discord Rich Presence** — 在 Discord 狀態顯示 Termdock 活動

### 快到底、省到底的終端機

Agent 的輸出像水庫洩洪。Termdock 用 **WebGL（GPU）渲染**取代 DOM 逐格排版 — 大量輸出下 renderer CPU 降約 90% — 搭配**自動節能模式**：用電池時收斂省電，插電時火力全開。

- **工作階段持續執行**：主機保持開機與登入時，本機及 peer 終端可在 App 退出、當機或更新後繼續執行；SSH 終端會隨 App 結束。
- **分割視窗與分頁** — 水平分割（Cmd+D）、垂直分割（Cmd+Shift+D）、拖放排序、快速切換（Cmd+1–9）、子母畫面模式
- **Dock 停放** — 暫時不看的終端機拖進碼頭：不佔 pane、不進分頁列、通知照常累積，隨時撿回來
- **背景與 headless 終端機** — 長時間執行的 shell 保留完整畫面狀態，不需要可見 pane

### 輸出裡的路徑，每一條都點得到

Shell 整合（OSC 133）記錄每條指令的輸出範圍與工作目錄，輸出裡的檔案路徑直接可用：git diff 前綴自動清理、折行的長路徑正確重組、相對路徑依指令實際執行的目錄解析。

- **監聽 port 標籤** — workspace 內服務開了哪些 port，側邊欄即時顯示，不用再跑 `lsof`
- **環境偵測** — Termdock 知道每個 session 另一端是本機、SSH 還是容器

### 驗收 AI 寫的程式碼

Agent 說「做完了！」— Termdock 幫你查證。**Rust 原生索引管線**建出的 code graph 不只認得函數與 class，還認得你的 web framework，任何 diff 都能回推影響範圍。

- **Diff 影響分析** — git diff 映射到 code graph 回推受影響的呼叫端，agent 的改動實際碰到什麼，收下之前就知道
- **Framework 路由節點** — Express、Fastify、Koa、FastAPI、Flask 的路由成為 code graph 一等節點，route → handler → middleware 一路可追
- **Tree-sitter + LSP** 支援 **13+ 種語言** — JavaScript、TypeScript、Python、Rust、Go、C、C++、Java、Ruby、PHP、Swift 等
- **Code Graph MCP server** — 把程式碼結構開放給 Claude Code、Codex、Cursor 等任何相容 MCP 的工具

### 在工作的地方 Review Git

出貨 agent 的成果前的最後一關 — 不用跳去瀏覽器。Termdock 內建**視覺化 Git review 介面**：三欄式版面含 blame、跨檔導航、大檔案流暢處理。

- **Twin Focus** — 左右兩側對應 token 同步反白，改名改了哪些一眼對上
- **唯讀 merge / conflict review**、視覺化分支管理、配色跟著你的主題走

### 工作區，拖進來就開工

資料夾拖進 Termdock 就是一個 workspace。加上 tag，側邊欄與快速切換（Cmd+P）自動分組。

- **檔案在 pane 內預覽** — Markdown、程式碼、JSON/YAML/XML、PDF、圖片跟終端機共用同一個 grid、同一套分頁與拖放規則
- 功能完整的檔案總管、支援 `*`/`?` 萬用字元的模糊搜尋、Markdown 匯出 standalone HTML

### 跨機器工作

專案不會都在同一台電腦上。Termdock 把遠端工作區掛在本機工作區旁邊 — 同一個格線、同樣的分頁、同樣的快捷鍵。

- **區網配對遠端** — 同網段裝置自動互相發現；配對一次成為信任裝置，掛載共享工作區走端到端加密通道，不經任何雲端
- **SSH 遠端工作區（Beta）**：連線到可透過 SSH 存取的伺服器，在 Termdock 開啟遠端終端。SSH 終端會在 App 關閉時結束。
- **重新連線**：短暫斷線後可重新接上。背景終端要持續執行，主機須保持開機與登入。
- **Host 完全掌控** — 分享預設關閉，不安全的根目錄直接擋下，連入的 session 看得到、可個別終止

### 用手機或瀏覽器操作

在可信任的網路上配對手機或桌面瀏覽器後，可以查看本機終端輸出並送出輸入。瀏覽器連線使用 HTTP，請使用可信任網路；從外部連線時，需自行設定 Tailscale 等 VPN。瀏覽器不包含桌面的 Workstream 權限審核面板。[瀏覽器連線指南](https://termdock.com/docs/browser-access/zh)

也可以透過 **Telegram 或 Discord** 傳送終端輸入、讀取輸出、接收通知及取得截圖。[遠端控制指南](https://termdock.com/docs/remote-control/zh)

---

## 路線圖與發行版本

[路線圖](https://termdock.com/roadmap)記錄長期規劃，內容可能落後於最新發行版本。已推出的功能請以[發行說明](https://github.com/termdock/termdock-issues/releases)為準；想法與建議可到[討論區](https://github.com/termdock/termdock-issues/discussions)提出。

---

## 下載與安裝

### macOS — Homebrew（推薦）

```bash
brew tap termdock/termdock-issues https://github.com/termdock/termdock-issues
brew install --cask termdock
```

### 手動下載

**最新版本**: [點此下載](https://github.com/termdock/termdock-issues/releases/latest)

| 平台 | 檔案 |
|---|---|
| macOS（Apple Silicon，推薦） | `Termdock-x.x.x-arm64.dmg` |
| macOS（Intel） | `Termdock-x.x.x.dmg` |
| Windows | 最新發行版本中的 `.exe` 安裝檔 |
| Linux | 目前沒有公開安裝檔 |

**macOS 最低版本**：macOS 12.0 以上，支援 Intel 與 Apple Silicon。

**macOS 安裝步驟**
1. 下載對應你 Mac 的 DMG 檔案
2. 開啟 DMG 並將 Termdock 拖曳至應用程式資料夾
3. 如果 macOS 阻擋首次啟動，請先查看安全性訊息，確認下載來源後再決定是否允許。

**Windows 安裝步驟**：下載最新發行版本中的 `.exe` 安裝檔，執行並依照畫面提示完成安裝。

如果應用程式或終端機無法啟動，請在[回報問題](https://github.com/termdock/termdock-issues/issues)時提供 Termdock 版本、作業系統與錯誤資訊。

---

## 問題回報與功能建議

發現 bug 或有想法？我們很樂意聽到你的意見！

[**建立 Issue**](https://github.com/termdock/termdock-issues/issues) | [**開始討論**](https://github.com/termdock/termdock-issues/discussions)

### 回報前請確認

- 檢查問題是否已存在
- 嘗試最新版本
- 包含以下資訊：
  - 作業系統與版本（macOS / Windows）
  - Termdock 版本
  - 重現步驟
  - 錯誤日誌（若適用）

---

## 社群與支援

- **問題回報**: [GitHub Issues](https://github.com/termdock/termdock-issues/issues)
- **討論區**: [GitHub Discussions](https://github.com/termdock/termdock-issues/discussions)
- **文件**: [termdock.com/docs](https://termdock.com/docs)
- **官網**: [termdock.com](https://termdock.com)

---

## 接收更新通知

關注此 repository 以接收新版本通知：
1. 點擊上方 **Watch**
2. 選擇 **Custom** → **Releases**

---

<div align="center">

**Termdock — 程式碼讓 AI 寫，畫面永遠是你的**

給把工作交出去、品味留下來的開發者

[官網](https://termdock.com) • [下載](https://github.com/termdock/termdock-issues/releases/latest) • [文件](https://termdock.com/docs)

</div>
