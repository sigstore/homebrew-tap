# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.3.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.3.2"

  depends_on "sigstore/tap/gitsign-credential-cache"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "2c9f76d6e8b2d24cbf92c110a054c0d5a61f61b77a4b8663e6db7f46868515b3"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "5400478ba54bfc6d0e2f7a27a651eb6f5dd32a6bb1d0b6a8bd10bb731f6bd0d4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "37e6696f0a94440d941b24ba31fc3da3500bd8c73166a30ec6a3e756355530a2"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "02e560f92ad3df5078ac1e699bf587c06b8f56792627869ac3381c342d6cbd39"
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
