# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.11.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.11.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "40738481b5b62fec69711977ede5707ab77c630c5d8c76c6ae0976eebd14a212"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "0a571d8c8ea6be69847e8459b0aa94d5a1ac57ab95de6c47770f914bbfdb46ef"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "5659781cb8675229977cbbb09fd0a13d5c9b2053fc56aa56c10eeb70911946e0"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "177797af799ab824948195896ea069af6c3b06f310913beccbee6b2c2acb6ccc"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "sget-#{os}-#{cpu}" => "sget"
  end

  test do
    system "#{bin}/sget", "version"
  end
end
