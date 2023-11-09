# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.8.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.8.0"

  depends_on "sigstore/tap/gitsign-credential-cache"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "98d3000e08ce6b0e74bb4e88c7bd7439a51939793aff7c1803a7cdc99ba8b7db"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "7de0a64ebe98ac49e52823fda6c009d58d7f3e0805aafd892aaac97e339ca4db"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "132bf44a24b16d1b14aa6ee4f31c5ac3a20cde4f14c66f46e5635ae55352d631"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "3e42b29a35819ace442cf1d78c11966be3f7fa93db8f750e4aad9c196bc0717e"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "gitsign_#{version}_#{os}_#{cpu}" => "gitsign"
  end

  test do
    system "#{bin}/gitsign", "--version"
  end
end
