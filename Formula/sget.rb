# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.12.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.12.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "cab5eb6c179a2300494afa24d21d67c2993acfb0cfb9ea78ab263428ba499429"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "a58c8655a3921b194d5f8db3c8409a0ecabb32b7ae32d894f195e388d429fdae"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "59dfe5417a8c137c8404eeba84b6029069fd6ab0c461dea0dd7ee80a05360e33"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "83af722ed9122463d5044687857a05e73c077608e61406c6358ec08703b52447"
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
