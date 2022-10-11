# typed: false
# frozen_string_literal: true

class GitsignCredentialCache < Formula
  desc "Keyless Git signing using Sigstore Credential Cache"
  homepage "https://sigstore.dev"
  version "0.3.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.3.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_amd64"
      sha256 "62fc5612f5466cd29f11e30c1472851a2200808b3e42f78e71bf0892d0bd6150"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_arm64"
      sha256 "1d85278b33caa67383ef13ad2479c4de91a1927b97b6268ad16bb88ad0a59ac3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_amd64"
      sha256 "8bd2bec840127b86a78946e20689afd933cfe7303a81089a083128fc5e7ce44b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_arm64"
      sha256 "6d80eb8e51807a8cbc5502879ea5d023f1917d39cc1311519b78a3348860125a"
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
