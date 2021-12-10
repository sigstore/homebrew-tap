# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.4.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "2cc416dedc800ccfe73aadf54a627c7006344b38838d141971d912aa3a28563a"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "d9712d5789b914837eac0e7a3c48a970112a59d9474f2f7db19e12dabef88a36"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "86f86212d5330e6888fb2a2c8e84c5c0ca6b158292ab604b48617f7696979d33"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "d3163abd72fe842503a80263d763d88e3f7938ae303de4ed8fb941b5c022f30b"
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
