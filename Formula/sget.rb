# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.13.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.13.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "0860d09b53e057de2821c875a110d74e568b917db17e11d4c5691a4a2a15ddd8"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "5d0898557193b273febdc2dfb8f9b0c922ac5c4de18e52f46cef4d71dac910f2"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "36c25be6bb496ccd57e676a93edfb05931517443e6f5ce1e51f08650c1bb260f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "653f9f8327421f4e1c78db29cd952af7844014421a06bd9c8f6d2f52b49aa752"
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
