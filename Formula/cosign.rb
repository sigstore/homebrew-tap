# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.7.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.7.2"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "fab8f2c4f8705a4c4fd2cc97856213e1d0b86d5b1707a39edc462b9b05afe7fb"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "6dababc0001a695f03aa5a9712700d7ee1763375c5e97fc2544f11a88ebe9d5b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "80f80f3ef5b9ded92aa39a9dd8e028f5b942a3b6964f24c47b35e7f6e4d18907"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "2448231e6bde13722aad7a17ac00789d187615a24c7f82739273ea589a42c94b"
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
