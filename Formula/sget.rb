# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.5.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.5.2"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "c4dedbd20b7d26a068b90a170ef23640739381a28397d5b73c0ebaa8f4535f95"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "c271217fb85c2ab5ddea571865ddbca5b04ca8a04e7382c60ec080f014a45765"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "d466fc955b2645c9269ff461b3bb843aa8795131b11d4c232ac2bebccebef7f4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "8b2d4612e4902be873f041af6e0a6d58c7c4c386d51643d7ea287589e5e39ebc"
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
