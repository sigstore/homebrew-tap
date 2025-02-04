# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "2.4.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v2.4.2"

  option "with-linux-piv-pkcs11", "Download cosign linux binary with piv/pkcs11 enabled"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "2697aba2d9ea5159b8f209025cfc392a8a25ce177c8d3b0e07afd4e1db3b163c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "f9a574c1ab208918a0d96ffca7a105dfb32792f6c33e0da2dbefb76e25600ab8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-amd64"
        sha256 "c11a712367c563648f35815af70b2aea88ffb3ebef75fc09a169a67968e22b65"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
        sha256 "e7f5bd99a790703333e8f8e8e6c91d5e646f3d7041e4cf935b56587de20cec3f"
      end
    end

    if Hardware::CPU.arm?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-arm64"
        sha256 "80f5f0cf9a1d214d544b10c50ae75fb1c1072352d547bab30255882e92754677"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
        sha256 "9ab2a932190161d67b9fcda81777e28086b2152c7d506a0e2f83dbb3fd7e2b1c"
      end
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    if build.with? "linux-piv-pkcs11"
      bin.install "cosign-#{os}-pivkey-pkcs11key-#{cpu}" => "cosign"
    else
      bin.install "cosign-#{os}-#{cpu}" => "cosign"
    end
  end

  test do
    system "#{bin}/cosign", "version"
  end
end
