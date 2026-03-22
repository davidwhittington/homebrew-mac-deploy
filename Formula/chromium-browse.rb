class ChromiumBrowse < Formula
  desc "Simulated browsing traffic generator for any Chromium-based browser"
  homepage "https://github.com/davidwhittington/mac-security"
  url "https://github.com/davidwhittington/mac-security/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "0bc7c4b60bb101f823dbc4c7a0977636ba2f9c943f6d628f1f84c53a9072153b"
  license "MIT"
  version "0.9.0"

  depends_on "python@3.12"

  def install
    venv = libexec/"venv"
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", venv
    system venv/"bin/pip", "install", "--quiet", "websockets>=12.0", "aiohttp>=3.9"

    # Install the Python script
    libexec.install "scripts/chromium-browse/chromium-browse.py"

    # Install example urls.txt
    (pkgshare).install "scripts/chromium-browse/urls.txt.example"

    # Create a wrapper that uses the venv Python
    (bin/"chromium-browse").write <<~EOS
      #!/usr/bin/env bash
      exec "#{venv}/bin/python3" "#{libexec}/chromium-browse.py" "$@"
    EOS
  end

  def caveats
    <<~EOS
      chromium-browse generates simulated browsing traffic through any
      Chromium-based browser running in headless mode via CDP.

      Supported browsers: Chrome, Edge, Brave, Island, Arc, Vivaldi,
      Opera, Comet, Atlas, Sidekick, Wavebox, Thorium, and any custom
      Chromium binary.

      Usage:
        chromium-browse --browser island --urls urls.txt
        chromium-browse --browser chrome --rounds 3
        chromium-browse --browser /path/to/binary
        chromium-browse --list-browsers

      An example urls.txt is at:
        #{pkgshare}/urls.txt.example

      Quick start:
        cp #{pkgshare}/urls.txt.example ~/urls.txt
        # Edit ~/urls.txt with your target URLs
        chromium-browse --browser island --urls ~/urls.txt
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/chromium-browse --help", 0).downcase
  end
end
