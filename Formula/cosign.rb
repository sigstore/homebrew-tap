# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.12.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.12.1"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "87a7e93b1539d988fefe0d00fd5a5a0e02ef43f5f977c2a701170c502a17980d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "41bc69dae9f06f58e8e61446907b7e53a4db41ef341b235172d3745c937f1777"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "b30fdc7d9aab246bc2f6a760ed8eff063bd37935389302c963c07018e5d48a12"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "d9ba8512d8dd6cc05b2c626d2e2ec966dd24c5f8ad3b479ae9ab6066c8d9deb7"
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
