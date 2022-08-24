# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.11.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.11.1"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "a2b5aa3d82cf845c137d3da29aac33557767575967ec8683d673ef6c0116803d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "d9ec1d1dd722a5cc62ece8ec0832ada0645f48d3d4b8858874d8cad96a15bf2a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "4d9e4a8e79b714039b272ef89ae29bc45b32e585b6010a5b9048da14d93cfd5f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "9fb8b494edb4b95caa9b822d2910460e40b16bc90b9477a2af2bcfba0bb9982f"
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
