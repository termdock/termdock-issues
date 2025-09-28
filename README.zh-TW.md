# Termdock

**AI 開發者終端整合平台**

*提升多 AI CLI 工具的效率與工作流整合*

**語言**: [English](README.md) | [繁體中文](#繁體中文)

---

> 這個 repository 用於 **下載 Termdock 安裝檔** 和 **回報問題**。主要開發在私有 repository 進行。

## 什麼是 Termdock？

Termdock 是一個強大的桌面應用程式，專為現代 AI 驅動的開發工作流設計。它整合了終端管理、程式碼分析、檔案處理和 AI 工具，讓開發者能更高效地使用各種 AI CLI 工具。

### 核心功能



**智能終端管理**
- 多標籤終端介面，快速切換工作區
- 支援大量貼上 context 並且壓縮紀錄
- 完整 git 管理
- 完整檔案總管
- cmd+p 快速切換工作區
- terminal 依照工作區群組化
- 多分割視窗，最多同時觀看 4 個 terminal，並且可以自由切換
- 支援彈出子母視窗
- 支援主題模式以及自訂背景圖片
- 自動生成 commit 訊息（ 暫時需要 BYOK ）

**進階檔案處理**
- 剪貼簿圖片自動處理
- 拖放檔案上傳與驗證
- 全文搜尋與檔名模糊搜尋

**開發者體驗**
- Git 整合工具列與分支管理
- 動態主題系統
- 全域快捷鍵支援

**AST 程式碼分析 （BETA）**
- Tree-sitter 整合，支援 13+ 程式語言
- 智能符號引用查找和依賴關係分析
- 函數呼叫圖視覺化

### NEXT （v2.0）
- AST API
- SDD 開發模式
- 自訂指令驅動 cli 工具操作更多事情


## 下載安裝

**最新版本**: [點此下載](https://github.com/termdock/Termdock-issues/releases/latest)

### 目前支援平台

**僅支援 macOS**
- **Intel Mac**: 下載 `Termdock-x.x.x.dmg`
- **Apple Silicon**: 下載 `Termdock-x.x.x-arm64.dmg`
- 開啟 DMG 檔案，將 Termdock 拖拽到應用程式資料夾
- 首次開啟可能需要在「系統偏好設定 > 安全性與隱私權」中允許

**即將推出**
- Windows 和 Linux 版本計劃在未來版本中發布

## 問題回報與功能建議

發現 bug 或有功能想法？請 [建立 issue](https://github.com/termdock/termdock-issues/issues)！

### 回報前請確認
- [ ] 檢查是否已有相同問題
- [ ] 嘗試最新版本
- [ ] 包含 macOS 版本和 Termdock 版本資訊

## 支援與協助

- **問題回報**: [GitHub Issues](https://github.com/termdock/Termdock-issues/issues)
- **功能討論**: [GitHub Discussions](https://github.com/termdock/Termdock-issues/discussions)

## 更新通知

關注此 repository 以獲得新版本通知：
- 點擊 **Watch** → **Custom** → **Releases**

## 版本資訊

- **穩定版本**: 定期發布穩定更新
- **開發版本**: 包含最新功能的預覽版本
- **系統需求**: macOS 10.14+ (建議 Monterey 或更新版本)
