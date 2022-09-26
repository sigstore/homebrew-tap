# typed: false
# frozen_string_literal: true

class Gitsign < Formula
  desc "Keyless Git signing using Sigstore"
  homepage "https://sigstore.dev"
  version "0.3.1"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.3.1"

  depends_on "sigstore/tap/gitsign-credential-cache"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_amd64"
      sha256 "e5fa99e806e6c859c99deefd83283dfbdf27a2ba1192a9c7b30c2fb46f888b18"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_darwin_arm64"
      sha256 "9873da5c6390f6934b88106a0a42fe4be45cd04cfd86c5fbb866193702282475"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_amd64"
      sha256 "9d0b843aa5237ed2d7ba1c29b03d384c26c0585bae41c22d846ae8d8fc88fd68"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign_#{version}_linux_arm64"
      sha256 "8f6cfdf162626b167f237054a57d704d576a0e76c3bfc5ff40d31dd51c6b383a"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "gitsign_#{version}_#{os}_#{cpu}" => "gitsign"
  end

  test do
    system "#{bin}/gitsign", "--version"
  end
end
