# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.10.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.10.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "cfea22744ddd41130396848dacd612ce5867215a6eb8242c5a59923ebf7dc6c2"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "b01037fdcdfb0b18824090cd80535c6ded030820bcce18ee151df8f3f9378dfb"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "a5522bc99edcc368d5ae2cf37024280bf5b9ede22d5fd0b7a9e9c83a7397f5d1"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "ab728ed86d06eb0bab45bf4378e734975ad63208de2c275c4b887f7916a3e952"
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
