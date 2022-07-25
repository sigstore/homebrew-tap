# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.10.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.10.0"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "49cf390cbfbce2047f123a7793cf4a8cd0d32a6ba5d260fa0e3282ea2a663e28"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "6af4bfa11e3e7fcd5a2a3a1081a501acb75cc2bb7a3d2dc381ab1aaa06d11982"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "1f50825bb207098a9dac23c342151e441dc09a593d7707c172abb11701ace40b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "e3b42544310c0cb7483c35dce19a503e68e62b51df11ff341451ae1f418023ad"
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
