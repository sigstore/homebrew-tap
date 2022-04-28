# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.8.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.8.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "0d4e481c9e629e9658bf0ae6e487f06a98aabf09e2a4c0aec4ee99b58276df4a"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "6bbd4f74f87182853e9b2a153d1e4aa3204ef00ebec0099513db1f2e6ed9ffc4"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "6719aa3d6e338703309592ebabe901ceffd9d8445a373858407ce0a6537e9e7b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "923b9280ffa2bef0073b5f106648e10c657380c72938b208f7032dcc8ab97c13"
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
