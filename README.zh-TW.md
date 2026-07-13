<div align="center">

# Termdock

**程式碼交給 AI 寫，畫面由你作主。**

*macOS 與 Windows 的 AI 原生終端機 — 工作交給 Claude Code、Codex、Gemini 或 GitLab Duo，在一個 GPU 加速的工作區裡監工一切，而背景的每個像素都是你的。*

[![Product Hunt](https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=1033858&theme=light)](https://www.producthunt.com/products/termdock)

**語言**: [English](README.md) | 繁體中文 | [日本語](README.ja.md)

[下載](https://github.com/termdock/termdock-issues/releases/latest) • [文件](https://termdock.com/docs) • [回報問題](https://github.com/termdock/termdock-issues/issues) • [討論區](https://github.com/termdock/termdock-issues/discussions)

</div>

---

## 展示影片

![Termdock 展示 — AI agent 在多終端工作區寫程式，搭配自訂背景與主題](demo.gif)

**[▶ 在 YouTube 觀看完整影片](https://www.youtube.com/watch?v=rjkPY-c4eMM)**

> **注意**: 此 repository 用於**下載 Termdock 安裝檔**與**回報問題**。主要開發在私有 repository 進行。

---

## 什麼是 Termdock？

寫軟體的方式變了：agent 動手，你下指令。Termdock 是為這個現實打造的**終端機優先開發環境**（支援 macOS 與 Windows）— 一個快速、GPU 加速的終端模擬器，**Claude Code、Codex、Gemini CLI、GitLab Duo** 以一等 session 執行，權限請求進到專屬審核面板，而不是淹沒在捲動的輸出裡，寫出來的東西用程式碼智慧與視覺化 Git review 驗收。至於你一整天盯著的畫面，完全歸你：自訂背景圖、主題、字型、半透明外框。

### 為什麼選擇 Termdock？

- **AI agent 原生支援** — Claude Code、Codex、Gemini CLI、GitLab Duo 皆為一等 session；agent 預設在背景工作，不會搶走你的 pane
- **主導權在你手上** — 權限請求、問題、計畫審查變成卡片，在專屬面板核准或拒絕，人不在電腦前用手機也行
- **驗收 AI 寫的程式碼** — 認得 web framework 的 code graph、diff 影響分析、含 blame 與 Twin Focus 反白的三欄式視覺化 Git review
- **畫面由你作主** — 自訂背景圖、深淺色主題、自訂字型、半透明玻璃外框
- **快速又省電** — WebGL（GPU）渲染讓大量輸出下的 renderer CPU 降約 90%，電池模式自動節能

---

## ✨ v1.16 新功能

- **Git Review 全面翻新** — 三欄式視覺化 diff 審查含 blame、Twin Focus token 對應反白、唯讀 merge / conflict review
- **Dock 停放** — 終端 session 拖進碼頭：隱藏但活著，通知照常累積
- **資料夾拖進來就是 workspace** — 拖放即建，不用手動設定
- **認得你 framework 的 code graph** — Express / Fastify / Koa / FastAPI / Flask 路由成為一等節點，任何改動都能做 diff 影響分析
- **Rust 原生索引管線** — 大型專案索引明顯更快
- **GitLab Duo 加入 agent 陣容** — 與 Claude Code、Codex、Gemini 並列

[完整 release notes →](https://github.com/termdock/termdock-issues/releases/latest)

---

## 螢幕截圖

<div align="center">

### 視覺化 Git Review — v1.16 新功能
*三欄式 diff 審查含 blame、跨檔導航與 Twin Focus token 對應反白*

![Termdock 視覺化 Git review — 三欄式 diff 審查含 blame 與 Twin Focus 反白](termdock-git-review.png)

### 程式碼智慧
*13+ 種語言的符號搜尋、呼叫圖與相依性視覺化*

![Termdock 程式碼分析 — AST 符號搜尋與相依圖](termdock-code-analysis.png)

### 多終端工作區
*終端機、檔案預覽、repository 與 AI agent 在同一個 grid*

![Termdock 多終端工作區 — 分割視窗與分頁](termdock-multi-terminal.png)

### 主題自訂
*深色、淺色、自訂背景與字型 — 你的終端機、你的畫面*

![Termdock 終端機主題自訂 — 自訂背景圖與半透明外框](termdock-theme.png)

</div>

---

## 功能特色

### 把工作交出去

別再盯著終端機的捲動輸出當保母。在 Termdock 裡，**Claude Code、Codex、Gemini CLI、GitLab Duo** 以受管理的 agent session 執行 — 預設在背景，它們埋頭苦幹，你的 pane 還是你的。

- **Agent Workstream** — 權限請求、問題、計畫審查被攔截成結構化卡片，在專屬面板核准、拒絕或回覆；`termdock hooks setup` 一鍵接好全部 hook
- **Terminal API** — 給 agent 與腳本的本地 HTTP API：建立、操控、讀取終端 session（含 headless）、SSE 即時串流輸出、service token 認證與速率限制。[API 文件](https://termdock.com/docs/terminal-api)
- **`termdock` CLI** — 從任何 shell script 建立、attach、follow session，或查詢目前 focused workspace
- **語音輸入**（Whisper）、**AI 生成 commit 訊息**（BYOK）、可安裝的 **Claude Code Skills** 教 Claude Code 操作 Termdock 的 AST 與 Terminal API

### 畫面由你作主

程式碼可以讓 agent 寫，但你一天盯八小時的畫面是你的。**把你想放的圖放到終端機背後** — Termdock 會從圖片本身的色調生成可讀性遮罩，文字清晰、圖也看得見。

- **動態主題系統** — 深色、淺色模式與各主題強調色貫穿整個應用程式
- **自訂終端字型** — 包含系統位置以外的自訂字型搜尋路徑
- **半透明玻璃外框** — 終端 pane 與 pane 內檔案檢視器視覺統一
- **Discord Rich Presence** — 在 Discord 狀態顯示 Termdock 活動

### 快到底、省到底的終端機

Agent 的輸出像水庫洩洪。Termdock 用 **WebGL（GPU）渲染**取代 DOM 逐格排版 — 大量輸出下 renderer CPU 降約 90% — 搭配**自動節能模式**：用電池時收斂省電，插電時火力全開。

- **Session 還原** — 關掉應用程式再回來，每個終端機都在你離開的地方
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

### 監工，裝進口袋

你離開座位，agent 不會停 — 你的監工也不用停。用 **Telegram 或 Discord** 遠端操控終端機：送輸入、讀輸出、背景終端有輸出時推播通知（/watch）、隨手截圖（/snap）。[設定指南](https://termdock.com/docs/remote-control)

---

## 即將推出

### v1.17 — Agent 生態系（進行中）

- **OpenCode 整合** — OpenCode 加入 Claude Code、Codex、Gemini 行列，成為第四個 agent session provider，含 HTTP + SSE daemon client 與互動式終端 session
- **ACP / AI API provider 選項** — provider 設定擴展

### 之後（v1.18+）

- **Remote / 瀏覽器存取** — 在桌面應用之外操作你的終端機
- **多 Git 倉庫工作區** — 單一 workspace 掛載多個 repo
- **Windows 原生 Rust PTY**
- **Linux 支援**

[查看完整路線圖](https://termdock.com/roadmap) • [功能建議](https://github.com/termdock/termdock-issues/discussions)

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
| Windows | `Termdock.Setup.x.x.x.exe` |
| Linux | 即將推出 |

**macOS 系統需求**：macOS 10.14 以上，Intel 或 Apple Silicon（建議 M1/M2/M3/M4）

**macOS 安裝步驟**
1. 下載對應你 Mac 的 DMG 檔案
2. 開啟 DMG 並將 Termdock 拖曳至應用程式資料夾
3. 首次啟動可能需要在 `系統偏好設定` → `安全性與隱私權` 允許應用程式

> **Intel Mac 使用者**：若終端機無法啟動，請更新至 1.3.2 以上版本（修復 ARM64 PTY 載入問題）。若錯誤持續，點擊錯誤對話框的「確定」複製日誌並[貼到 GitHub issue](https://github.com/termdock/termdock-issues/issues)。

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
