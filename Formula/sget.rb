# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.5.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.5.1"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "a5edca8f3cdaba5da0c347a4a6346f030dc48d3df344b05b2026509ee9aa5c9c"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "5851ee9ea5e16ca86cbb59a59734a01824672721236227eed5ef163c4bba44f0"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "704969acbb759606a2b37a21a03fcc28b5940050551f07e2896b5526342a56db"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "be0ece54d2fe80de79fbad04e099f41474a9e5beb66762bc338cb4c10babdc53"
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
