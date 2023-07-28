# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.7.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.7.1"

  depends_on "sigstore/tap/gitsign-credential-cache"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "20b0cda0598b2dc2ad1e06139af19b6abda262c5c890aec1a2f2fbd8be30c43d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "0c692e72b4c78666623b68c3934c3676f271dd6f23dfc1447358741428cfe561"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "0e506f25d5e30e11d0a694007ad2be8e5059fdf1f88b843e1e9545b8b1dcf0e3"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "e5464065bda377627ca080caa260aaaadea1079f6210a637387bdaac32be6768"
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
