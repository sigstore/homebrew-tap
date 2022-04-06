# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev"
  version "1.7.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.7.1"

  on_macos do
    depends_on "pcsc-lite"

    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
      sha256 "f9b598a5c7f571f1ccfd168aea90c1022dc53f4ee9997f6d58aa9f3b0db04a7f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
      sha256 "b2427998b43c3db3dd773b127f4fc17e3c55353d0c6ac4a4c3fdff9309ce912f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
      sha256 "2ed460ccc1ba44f10ef98c19cafddad5b5199659c8a35e4b9b2040012ae1b235"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-arm64"
      sha256 "1caf266cf27825ea10081363746e034b6f24da0e38475d4ddad7162ecbd2069d"
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
