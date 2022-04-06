# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.7.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.7.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "e317aa8afff22f0bd759ff2a56c4269bc36e0db80bbd21071f444c51a9ffeb85"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "28a21789e000351d58a98bb5fd1b2425e2258945aa9e05c7fb594debf44baef7"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "2b2fd3c481eafe8f219d0dd8423883e87c73d9ec91a22fb898d7c63871d7261a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "597bd30e09d4656aea30828b271299f1d252ab000cc4b67df08ddabe9c8b7c89"
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
