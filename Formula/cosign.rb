# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://github.com/sigstore/cosign"
  version "1.2.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"
  bottle :unneeded

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "94872d7882e2fc6b8aebe864101395d2769f31783399282545156ccc2c516cf4"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "917e56e1966d31a98e455904d4996563061ab0ce845e541434bba796b1f5b027"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "490cb1941aa317cd24a0bd9f2fe38932805dbaaba0ae89c12ec8138d15bdd8a0"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "cosign-#{os}-#{cpu}" => "cosign"
  end

  test do
    system "#{bin}/cosign", "version"
  end
end
