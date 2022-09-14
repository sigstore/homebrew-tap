# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.12.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.12.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "910565867d4c35051a7afca22642f9ba55c179ec5e0bfd081fef21ae5cdd0d04"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "78b589b95047beaed501cf9596b63d679387a141b7539b482717673276831a7c"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "db3ce6398c148a3e17f5bad493e5d3c682725d3d1b70953c53bd0c3dc5e2449f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "d861c7a7f6c066118e2aee82fb52d978c62ed825b590df50eb9238ed287490d3"
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
