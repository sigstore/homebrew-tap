# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "2.0.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v2.0.1"

  option "with-linux-piv-pkcs11", "Download cosign linux binary with piv/pkcs11 enabled"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "a22da39c4e290d3ae5a2a882476daf84b46ac19acd0b01aac8e173d7f57b8eae"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "95774f0f8d0b1674606893e3837ecd3f01d65c0ea4a71409b089307ffd1f9bed"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-amd64"
        sha256 "57b48a40095688e3cf00b786ec3cd662bbc88c0154f8077f8a19d423208c5440"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
        sha256 "924754b2e62f25683e3e74f90aa5e166944a0f0cf75b4196ee76cb2f487dd980"
      end
    end

    if Hardware::CPU.arm?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-arm64"
        sha256 "dbcbfd2b2d667ac880709f61d105c5b331a8f73657bcd08c964d191f7bfb62ca"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
        sha256 "4a8cd49518cc667bb16e6aaf9da291b647c38baffa462fd495043ae6762f6981"
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
