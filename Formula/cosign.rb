# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.5.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.5.0"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "315fdddcfb3052f1b1b3f3f756bdcc05c8d740d8ac1e2cf57db38b1ada421a3b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "5552e39f36e27241db0816f65bc37a9b141f4d973c42686da706a4d161cf81e1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "5bf1aa3ff4bd129c478e16e0b83febf3cc1b91b9daed60be31e8c6614a99b021"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "0027169db9929f22a6751255828b62d024526dd9821f64e4d94404ba7a225586"
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
