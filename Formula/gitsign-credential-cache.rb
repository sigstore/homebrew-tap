# typed: false
# frozen_string_literal: true

class GitsignCredentialCache < Formula
  desc "Keyless Git signing using Sigstore Credential Cache"
  homepage "https://sigstore.dev"
  version "0.5.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.5.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_amd64"
      sha256 "52e2a5b8a4451cc8c6ee833fdfd3bf410abbcf9e8da5579338e4d7471f7867f5"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_arm64"
      sha256 "69c4918a1ac4e52faea4288ac2cfdfac512972baedfbd5c8d17d0d34b8d54144"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_amd64"
      sha256 "30692814f8c0b4b57d6a7d319386d3c38401bd9b763f8535edc36e9bd250ce75"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_arm64"
      sha256 "1adbbb42c7eb81c683268a6674ed35107bdd33470789c6a9ff02b3e63ee80ea6"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "gitsign-credential-cache_#{version}_#{os}_#{cpu}" => "gitsign-credential-cache"
  end

  test do
    system "#{bin}/gitsign-credential-cache", "--version"
  end
end
