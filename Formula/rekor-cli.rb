# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "1.1.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v1.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "a734773bed0b30f9ab199a5a920bb558afd4a89fb182c87ce427e6ad1275f8d0"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "934d76c8ed8e53423a1b426ecbb92e352f06fee00442c93799c16d9838f6c03a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "afde22f01d9b6f091a7829a6f5d759d185dc0a8f3fd21de22c6ae9463352cf7d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "5eb9779dcbf09ce6ea49582c8d397f78573c632275df350fc60987e26593491c"
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
