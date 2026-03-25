class TorProxy < Formula
  desc "Tor-based internet anonymizer for macOS — routes traffic via SOCKS proxy"
  homepage "https://github.com/davidwhittington/mac-security"
  url "https://github.com/davidwhittington/mac-security/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "8b41a6753fbd5185663ccf33220c761a0be70231fa41e403a1ae6cb50b7eeee7"
  license "MIT"
  version "0.10.0"

  depends_on "tor"

  def install
    bin.install "scripts/tor-proxy/tor-proxy"
  end

  def caveats
    <<~EOS
      tor-proxy routes macOS system traffic through the Tor network
      by configuring the SOCKS proxy on your active network interface.

      Usage:
        tor-proxy enable     Start Tor and route traffic through it
        tor-proxy disable    Stop Tor and restore direct connections
        tor-proxy status     Show connection state and external IP
        tor-proxy newid      Request a new Tor circuit (new exit IP)

      Notes:
        - enable/disable prompt for your password (networksetup needs admin)
        - Not all apps honor the system SOCKS proxy (see docs for details)
        - For faster identity switching, enable the Tor control port:
            echo -e "ControlPort 9051\\nCookieAuthentication 0" >> $(brew --prefix)/etc/tor/torrc
            brew services restart tor

      Documentation: https://github.com/davidwhittington/mac-security/blob/main/docs/guides/tor-proxy.md
      Source repo:   https://github.com/davidwhittington/mac-security
    EOS
  end

  test do
    assert_match "Usage: tor-proxy", shell_output("#{bin}/tor-proxy")
  end
end
