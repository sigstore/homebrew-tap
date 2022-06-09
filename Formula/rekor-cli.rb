# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.8.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.8.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "2fca4376f2759c921e7e66e3d0c09e63c08a25745dcb10d0cace40b7cf61c3de"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "979a58b188d30577e354f8bcdbd42b327917fccbbd938a67a4641f39edaf4b4b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "464c05ab11289351eb86a9d5a27e8b6eb689746d12d37ac47747b1c994d44653"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "2f2ae35e6e9b8c0ef696538562eb5bc1a49cc8ed6187f31cfd884dba43ebce39"
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
