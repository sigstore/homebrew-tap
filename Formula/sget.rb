# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.13.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.13.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "7b1a01339a47344d8d4aae60266123d7cc8eb8a8c7be7dc91e1a65e69ad403a4"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "03eff8168b424bf6f7d71bd5e57c98d0363cab16b9668298ded3600c7bcebf40"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "67653293421b43ab98698914b533684bc0141043a2439dc2f3125ba1684cdf29"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "1ef4c15826e7da99c6916792bde727926509f85f7e6e5b523cfbd6331c7cefae"
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
