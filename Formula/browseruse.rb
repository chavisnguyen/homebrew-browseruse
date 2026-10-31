class Browseruse < Formula
  desc "Control your browser with your AI - Ultra-lightweight (~12MB RAM) MCP server"
  homepage "https://github.com/chavisnguyen/1craft-browseruse"
  license "MIT"

  # NOTE: `url`/`sha256` below are rewritten on every published Release by
  # the "Release assets" workflow in chavisnguyen/1craft-browseruse. Do not edit
  # by hand. (`version` is inferred from the tag in the URL.)
  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.2/1craft-browseruse-darwin-arm64.tar.gz"
      sha256 "09f0265e6d9b0ab71abdd1ceb6f362ef109f67edd1743886b966d467b2d38485"
    end
    on_intel do
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.2/1craft-browseruse-darwin-amd64.tar.gz"
      sha256 "df486b79e080bcd703283e754f46dfc4ccaddba69864c94d7e9c3db936ba5f2b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.2/1craft-browseruse-linux-amd64.tar.gz"
      sha256 "cad4b06baf784aaaec35784563c467fd93b7565c670074cf919147a4eb8a1bb2"
    end
  end

  def install
    bin.install "1craft-browseruse"
    bin.install_symlink "1craft-browseruse" => "browseruse"
    pkgshare.install "extension"
  end

  service do
    run [opt_bin/"1craft-browseruse", "-sse", "-port", "3025"]
    keep_alive true
    log_path var/"log/1craft-browseruse.log"
    error_log_path var/"log/1craft-browseruse.log"
  end

  def caveats
    <<~EOS
      Quickstart:
        1. Start the shared background MCP daemon:
             brew services start browseruse

        2. Check your connection auth token:
             1craft-browseruse -token

        3. Load the Chrome extension in Google Chrome:
             - Open chrome://extensions
             - Turn ON 'Developer mode' (top-right)
             - Click 'Load unpacked' and select:
                 #{opt_pkgshare}/extension
             - In extension Options, paste your token and click Save.

        4. Add MCP server to Claude Code / AGY / Cursor / OpenCode:
             SSE URL: http://localhost:3025/mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/1craft-browseruse --version")
    assert_predicate pkgshare/"extension/manifest.json", :exist?
  end
end
