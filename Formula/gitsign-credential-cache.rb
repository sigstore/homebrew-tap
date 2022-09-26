# typed: false
# frozen_string_literal: true

class GitsignCredentialCache < Formula
  desc "Keyless Git signing using Sigstore Credential Cache"
  homepage "https://sigstore.dev"
  version "0.3.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.3.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_amd64"
      sha256 "9c43b1fcfd6f41bdee79c864386aa7a2db184b5e57114b780e06aaa2d15a1005"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_arm64"
      sha256 "ad46e6ef9bfa38dc11a29cbd4b863c224e8427aa1a80b96ea905ecee20d8ac38"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_amd64"
      sha256 "0407fa0e49397b9501147ede40513d6958287655105a9d6244191b4e956d154a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_arm64"
      sha256 "1e54dd59eec8d1ad4418af57791453c75b09d8762da5390f7009c4f7195ed444"
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
