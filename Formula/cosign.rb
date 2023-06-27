# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "2.1.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v2.1.1"

  option "with-linux-piv-pkcs11", "Download cosign linux binary with piv/pkcs11 enabled"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "5b7b4db7dbd7c19ce89d24a484627dc96fadd2632b033fe9a1f8005c29dbe84e"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "4339a0af0059ddc4a7af7c218dcaaa1496948563f5915a7773aadb085a7eea0e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-amd64"
        sha256 "ec1c3cf06af6495080696bc26bc95fdd1525190888d1785ccb20708f4576e54a"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
        sha256 "84a859fb654e2c2c0cbc6433a8195fef60bccd16b4cf412f486c2c67d4b91241"
      end
    end

    if Hardware::CPU.arm?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-arm64"
        sha256 "c45045ba7068a59ba0842649235d4a01c86a0e883f0e0572b83954c887c347da"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
        sha256 "563ae4c2f03dd70a9b90e4058cdf14b3e33aa77d9dc6276ecb97473513c238f8"
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
