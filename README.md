# homebrew-browseruse

Homebrew tap for [1craft BrowserUse](https://github.com/chavisnguyen/1craft-browseruse) — an ultra-lightweight (~12MB RAM) Model Context Protocol (MCP) server written in Golang that lets AI agents (Claude Code, AGY, Cursor, OpenCode) control your real Chrome sessions without macOS Full Disk Access.

## Installation

```bash
brew tap chavisnguyen/browseruse
brew install browseruse
```

## Quickstart

1. **Start the background daemon (via macOS launchd):**
   ```bash
   brew services start browseruse
   ```

2. **Check your extension auth token:**
   ```bash
   1craft-browseruse -token
   ```

3. **Load the Chrome Extension:**
   - Open Chrome and navigate to `chrome://extensions`
   - Turn ON **Developer mode** (top-right switch)
   - Click **Load unpacked** and select:
     ```
     $(brew --prefix)/share/browseruse/extension
     ```
   - In extension Options, paste your token and click Save.

4. **Connect your AI Agent:**
   Point your MCP client (Claude Code, AGY, Cursor, OpenCode) to:
   ```
   http://localhost:3025/mcp
   ```

## Upgrade

```bash
brew update && brew upgrade browseruse
brew services restart browseruse
```

## License

[MIT](https://github.com/chavisnguyen/1craft-browseruse/blob/master/LICENSE)
