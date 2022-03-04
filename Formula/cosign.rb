# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.6.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.6.0"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "fcff17a94fb8a5098c9b9b623e2e190cc4d3c47c4f5e8dbf75b72a56a874b219"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "e59fb49a3cc03adbb81dbd2f5cd6206fe09479cdbb7426cdd1b22aaf9145bbbc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "b62ac8c1ab1cdb072d442d2f3db7d7ffe977566a6170cd03dd48e4583dad3203"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "5f1c8bb2b30c75fb1c72c266b08d9cfc517ddb8b632e35627fd63aaf09e8f1bd"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "cosign-#{os}-#{cpu}" => "cosign"
  end

  test do
    system "#{bin}/cosign", "version"
  end
end
