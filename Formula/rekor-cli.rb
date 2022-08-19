# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.11.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.11.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "13b798529e603ab0827ea0f27b026babcb785cd3d18f18bb5ddc586c90b733c5"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "71cd2bbeceb3872ff3ca6a8628bb2f8b680831b6dc7dd1a8796c93fce00b50e5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "76ea21c367b9af60fed6a0966135722971d619c2b66f6ad6bf338b006452f4a0"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "49a6db8c205155c971152267fbce5b8474fc01ca5ecabcb4142906aa025f40f2"
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
