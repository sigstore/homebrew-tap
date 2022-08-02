# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.10.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.10.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "ceb3c8686eda63923572eb625743841a90aa7916eaf4c1d33a921adcab25f97f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "b9cf92c4054ad4f53e456a37eb06a45987b8f19285efce4d5f3e0c0d7d99e598"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "8bd6c237a902a2be3632bce7f84eaf62bee5cb2702f78a2d8ff8b6f7e5264af8"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "c790e551b1cde42579662b97d8634653afcee376ded3957cd072b157ffbf62c3"
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
