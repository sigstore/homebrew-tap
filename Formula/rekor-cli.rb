# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.12.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.12.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "3e5f7f1f3f89c5ff929fe0f0cca59ab9aaf62b0452c8d89582ca87e791566dd3"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "ea074893c098e96b8024e0e993b1729c5371fa8a50d702c873266e188a118ad8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "4b5d84134bdbde9e873de58c4e679e7f1a00d18f22d49c52b7fd990e3980738a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "732f70cc0deac414e17919a0b04cd66b51ddd1ab6cc73c9cabcb5606cace4be3"
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
