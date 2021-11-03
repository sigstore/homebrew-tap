# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.3.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "bf8423700e8bbf01f03769f7b4bd078a4c8527ce98c28cd4c9bf2f83144e9485"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "5c204f0a8543d695e4037d090d3dc1f97c26ffae67b8740c4b4098ad2cca4abd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "9604a5eb171748113f92a67495556007dde6f45804f0b38d3e55c3bc7e151774"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "87675ea2a887b0817a6d9f9b8b1ed4a46633d2b0574cc284d3e58ab2c1546277"
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
