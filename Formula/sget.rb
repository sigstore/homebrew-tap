# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.9.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.9.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "c58dab896383104146c426e93f44a031a0243e9400a7b20a6c596da6d7aaf262"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "36b87b76c5f23de7e7136f87be59e0c644e25fdafb633f4208a95de7269952c1"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "d34c95da5459b469ff6678291b892448fa72487ea9dbba355a6f3ee053368247"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "d4be3d515d50c7c48c39db68f9370d15f26fc9dac88e0363772224af623beee1"
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
