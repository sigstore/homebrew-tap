# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.8.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.8.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "fb79038cfcd74146f2be2d6cbf64f8552ca504e6cf5e62bfea7680220fedee5c"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "a60fb8e802946c2991c1d11aec0e472d7b510a7a5c99b07b0d4f9831d0623684"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "d285e5924bb884a9daf6d46fac2d70d5883012296cf283014e1771fd98646c4d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "31bff3a4b4401dffea95b51c319937bb5b85a52f493e10ec88b16aed2f34e88a"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "rekor-cli-#{os}-#{cpu}" => "rekor-cli"
  end

  test do
    system "#{bin}/rekor-cli", "version"
  end
end
