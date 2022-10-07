# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.13.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.13.0"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "87c4f0cbab222c235a446f8675bcee9b2798c53ed00301f4458259a65dbc69a8"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "8b95f851af2de4ddf7b0f5d8f283f87cbb4a872a4f3367aacdaba67e491048e6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "45dbb8dd7d9f77eb010c091dea391da71730df2512d9fb1b65cd40136aee579e"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "950e39dbe7e182603d5d59d9e2a76e804d5d49bb9fb1b577510cb0bc7fd5a6a9"
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
