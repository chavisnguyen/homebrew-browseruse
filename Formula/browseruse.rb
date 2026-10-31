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
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.1/1craft-browseruse-darwin-arm64.tar.gz"
      sha256 "282434b6f22c17e04a0b7a9d96c60f573a2e076c7de29ddde5504e9f42777ad2"
    end
    on_intel do
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.1/1craft-browseruse-darwin-amd64.tar.gz"
      sha256 "12f8cb11dcc6f0980f5ec7e740bde438dd4f2c3b7ef2e51805948bd6db8d728d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/1craft-browseruse/releases/download/v1.2.1/1craft-browseruse-linux-amd64.tar.gz"
      sha256 "61b910fafbe375a7bdd828ab7890696422898bf496fba682a37eae44a10cdbcd"
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
