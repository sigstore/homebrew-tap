# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "2.2.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v2.2.2"

  option "with-linux-piv-pkcs11", "Download cosign linux binary with piv/pkcs11 enabled"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "e3d43db982b642be15a622e3791480620f5e7f2e902ab0c9e2db21daaa36259e"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "7874404ce8a9b29251ff485c6ecb46ecfebd6b1f5fa3cb6cd0b9bf2c75bab2d5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-amd64"
        sha256 "f20c9bf2dde7c973425fe77202158f3e8180ff65a0e48cd0a97d32489369191e"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
        sha256 "121ba0031827c090364894688049651d3a0a82a87235c469322a202aa2944211"
      end
    end

    if Hardware::CPU.arm?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-arm64"
        sha256 "d06517e0685273c64fa6df331a1f5e89b93689db77d1c4489c86f09909c24589"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
        sha256 "82eb62be7e1b7924db193d4a4a496eca94510df2961d88406ba07fb3435f6e8f"
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
