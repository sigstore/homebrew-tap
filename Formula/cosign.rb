# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.5.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.5.2"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "991c3f961f901aec75a4068ac2c3046bd5ab36d00cba6ddbf231b5d0123c83bf"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "d6ceb52358b69e02ddc2194d47cf5587e8c4885aaa0b9dbb98f0902410adc2ae"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "080c0ba10674d2909fb3b4b867b102aefa021959edf2696c8cc1ba08e824bccb"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "9b7551a871f14b4c278a7857c2cc7d9366b922ed9a4c73387f507ab25cfec463"
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
