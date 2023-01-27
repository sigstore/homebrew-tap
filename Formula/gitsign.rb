# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.5.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.5.2"

  depends_on "sigstore/tap/gitsign-credential-cache"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "4807d0a9c385442a309eddf7d45e5a383ca06e589def58bdf8af387ffb4a4dee"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "80251fe4c7f37a515214c329c90d52212cf160d75c41341201042a7741a1144b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "e0ead963a99b966e5bbb3410a79ab330a7c863ee45ecd7b6e9e2247a6702fb1a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "43121f61da0431336cf6da9cb5a5b84da32ff9934f2012f96610c5486ff581aa"
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
