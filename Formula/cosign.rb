# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.11.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.11.0"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "6aea1e357418b747d2880c64b17a36a94a35c9d9e561f9876fbbcac7f578c1f9"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "fea422de8f5ef56a1270c5a8b7c21ffa9e01132c3798d50c8bfead580b4484b8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "e205253fd34a0107084536bb030b73c1c5230c03ac1af2931b40f2b40b43f6d7"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "178e1e6610ae88e7ebc437946e0fa01282a745065709ecf93f9bb8d8bb53486a"
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
