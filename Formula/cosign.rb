# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.4.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "637b065b445ca1545b26ad6490c2bb79b4526fcda87ff165146da0a6a4ac0f2d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "909f7dc7d60729a388c90f3eead78205065bc06883015b3fa8247a039385ac2a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "bac6a2dee9100f5708226179466e0dad45e76291ef0d70b929ca52fe59a1ae0d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "74306d441ac70e36406ace160cebd539cfcd6ffb9e17d05b2969d716fd625b91"
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
