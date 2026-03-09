class MacDeploy < Formula
  desc "macOS workstation security hardening and audit tools"
  homepage "https://davidwhittington.github.io/mac-deploy"
  url "https://github.com/davidwhittington/mac-deploy/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "5f85470b4d728eae072f1d9b230e3dcbf499eb9d3a3b8fb3dee9a2d99939edc6"
  license "MIT"
  version "0.7.0"

  def install
    bin.install "scripts/audit/security-audit.sh"    => "mac-deploy-audit"
    bin.install "scripts/harden-sshd.sh"             => "mac-deploy-harden-ssh"
    bin.install "scripts/enable-stealth-firewall.sh" => "mac-deploy-firewall"
    bin.install "scripts/first-run.sh"               => "mac-deploy-first-run"
    bin.install "scripts/apply-configs.sh"           => "mac-deploy-configs"
    bin.install "scripts/apply-defaults.sh"          => "mac-deploy-defaults"
    bin.install "scripts/brew-upgrade.sh"            => "mac-deploy-upgrade"
    bin.install "pkgs/capture.sh"                    => "mac-deploy-capture"
    bin.install "pkgs/deploy.sh"                     => "mac-deploy-deploy"
  end

  def caveats
    <<~EOS
      mac-deploy tools installed:

        mac-deploy-audit        Run a full security posture audit (outputs Markdown)
        mac-deploy-harden-ssh   Apply SSH hardening config (requires sudo)
        mac-deploy-firewall     Enable Application Firewall + stealth mode (requires sudo)
        mac-deploy-first-run    Interactive bootstrap for a new Mac
        mac-deploy-configs      Render and deploy app config templates
        mac-deploy-defaults     Apply hardened macOS system preferences
        mac-deploy-upgrade      Upgrade all Homebrew packages and log changes
        mac-deploy-capture      Snapshot current Homebrew and shell config
        mac-deploy-deploy       Restore a saved machine profile

      Quick start (new machine):
        sudo mac-deploy-first-run

      Or step by step:
        mac-deploy-audit --brief
        sudo mac-deploy-harden-ssh
        sudo mac-deploy-firewall
        mac-deploy-configs --list
        mac-deploy-configs --dry-run
        mac-deploy-configs

      Config templating note:
        mac-deploy-configs expects a configs/ directory alongside the script.
        For full template support, clone the repo:
          git clone https://github.com/davidwhittington/mac-deploy.git
          cd mac-deploy && bash scripts/apply-configs.sh

      Full documentation: https://davidwhittington.github.io/mac-deploy
      Source repo:        https://github.com/davidwhittington/mac-deploy
    EOS
  end

  test do
    system "#{bin}/mac-deploy-audit", "--brief"
  end
end
