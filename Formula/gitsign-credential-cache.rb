# typed: false
# frozen_string_literal: true

class GitsignCredentialCache < Formula
  desc "Keyless Git signing using Sigstore Credential Cache"
  homepage "https://sigstore.dev"
  version "0.2.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_amd64"
      sha256 "bad42e6b04a980dc778d6a73d929e79fc84b862cece90966736f9b165624bb67"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_arm64"
      sha256 "88cf90a11b0a9d263b24001842ca95bd403b24289908e0b8b9779e27473c7675"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_amd64"
      sha256 "3b459e717915526a0eb5eb0aaece60a6aed55ffb37f568a19f5ddff07015cda4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_arm64"
      sha256 "25e06fa60d4506454a830699e8145dba117d34e803ea92fdcfa1901f584a7053"
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
