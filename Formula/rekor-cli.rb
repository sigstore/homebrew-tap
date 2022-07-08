# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "0.9.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v0.9.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "3d06cf86d726f625f94d16613b671b0e280c349662bf50e2a7a262d09d993849"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "10924422c9e48a35fba089039612c96bcb38b5e7799191b2e1119fd57a94fddf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "1bebeaf3d8fbd16841a6f9cf86312085b4eb331075d17978af2fd221ce361eb3"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "d0d3c513baa89ab256cacebe6d33e5e765ecc493bc672aa213d5a87679a1aa1d"
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
