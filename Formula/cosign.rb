# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "2.1.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v2.1.0"

  option "with-linux-piv-pkcs11", "Download cosign linux binary with piv/pkcs11 enabled"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "7ba6cf7a02a203e1978464f09551164ccacb9aefcfef8d3ec73e67af46417a91"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "c8ddd323d6b714105e4b05b48beba6b4f57c552464aefd4691d018bff6b4c362"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-amd64"
        sha256 "9730c93b9d64dc6293a5ed31950587376df901582c732f175c91383f763079ba"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
        sha256 "c4fef1a4c7e49ce2006493b9aa894b28be247987959698b97de771c129cce8ea"
      end
    end

    if Hardware::CPU.arm?
      if build.with? "linux-piv-pkcs11"
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-pivkey-pkcs11key-arm64"
        sha256 "b9541b25c467de096da555ffcd2c8baf68b5270a8b4aec034b82d709533c0ff6"
      else
        url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
        sha256 "f795a6903daadf764a5092599bfe6945cedd7656bef37884a3049ac1a529266c"
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
