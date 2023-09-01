# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "1.3.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v1.3.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "06392aa99a3e903b6eefebd999de7990a94ea7354f1e0918e343ba63429b86ec"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "fda3fe6757d3e326798221361c337f7a10e9086832ab30caf32c5caf6674bbb3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "52b7757f755d3c66e39cd8cd6203e984bf932b952bf141b31dfd85847482ba70"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "d1f4fff3a169337b38f40690938105fd012ba0ae49b86c281c04d8eff85d82a8"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "rekor-cli-#{os}-#{cpu}" => "rekor-cli"
  end

  test do
    system "#{bin}/rekor-cli", "version"
  end
end
