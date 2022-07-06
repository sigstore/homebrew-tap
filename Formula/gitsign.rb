# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.2.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "46fad3e9ecf412e4c7fd7f17bc842690020c0fc521f0f9e8f3f6881639e4c8d1"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "50dac63ba1aff473ececb09bcefabfb6e0b686e3efcdd58109ee85c426384c2c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "f503984e8a10c21b1ad42913616737a7fad68ee7a9c9da72c4df4ac8e05c144c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "4524d3f2f20c9d64873f2e44094a69f6d2d3790804f07e99e02ced7142eac03a"
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
