class MacDeploy < Formula
  desc "macOS workstation security hardening and audit tools"
  homepage "https://davidwhittington.github.io/mac-deploy"
  url "https://github.com/davidwhittington/mac-deploy/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "ba04dadcd1bd4704fd5a07a8bfe105c4ace8cd7fa230e2c8f96f6aade29236c7"
  license "MIT"
  version "0.4.0"

  def install
    bin.install "scripts/audit/security-audit.sh" => "mac-deploy-audit"
    bin.install "pkgs/capture.sh"                 => "mac-deploy-capture"
    bin.install "pkgs/deploy.sh"                  => "mac-deploy-deploy"
  end

  def caveats
    <<~EOS
      mac-deploy tools installed:

        mac-deploy-audit     Run a full security posture audit (outputs Markdown)
        mac-deploy-capture   Snapshot current Homebrew and shell config
        mac-deploy-deploy    Restore a saved machine profile

      Quick start:
        mac-deploy-audit --brief
        mac-deploy-audit --save   # saves report to private/workstations/

      Full documentation: https://davidwhittington.github.io/mac-deploy
      Source repo:        https://github.com/davidwhittington/mac-deploy
    EOS
  end

  test do
    system "#{bin}/mac-deploy-audit", "--brief"
  end
end
