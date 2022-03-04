# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.6.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.6.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "c06fbc2bea90b55636e2b460d2bb6f06c239ba9f1e93e5bbb25beaa5084d210b"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "61d6179e55b326fbe4f72dd82a841e08735df3ecc6f6b9de8b0b0f67fbb3611a"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "3241c236571b9a2fa6cd1df88a84a5b09a4d6fc58155020518df93813cfd8e77"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "d650889a5d48e4e3865b53f6a0b995911ccdffc8b79283fd77171167c665158b"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "sget-#{os}-#{cpu}" => "sget"
  end

  test do
    system "#{bin}/sget", "version"
  end
end
