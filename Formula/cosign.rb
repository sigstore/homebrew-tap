# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://github.com/sigstore/cosign"
  version "1.2.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"
  bottle :unneeded

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "974b33f61004e235db9c5f57edb105ae0c1ff28b0bb4193a399f6b3bc9ac66fb"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "c86e50ede69216d4d3f45523c3f9aef265192290a49ee92bc1ffc73de7bbb131"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "690e9d6220aa715b61e332a0efefb60f4f4889cb8c0d0195d28a406425d617f0"
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
