# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.11.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.11.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "f1896e1b4fb78c4926c67b05dd0cb4600f4b2f420021a8fba138239111118834"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "9a66c39d5e96efa628b0b4611a937d537fb68a3cac66950428754a32e74a4f6b"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "7eeb8a8c6776012a076f6bf3100b81a9cddf5c450c1c5e29fa1ce9982dad38ad"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "c95f19fe84ce1c3035863a2eb892829eb513bc96dddf028eeb7abbc6e87e7f53"
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
