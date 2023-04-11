# typed: false
# frozen_string_literal: true

class GitsignCredentialCache < Formula
  desc "Keyless Git signing using Sigstore Credential Cache"
  homepage "https://sigstore.dev"
  version "0.6.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/gitsign.git", tag: "v0.6.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_amd64"
      sha256 "ac80810589a7276362b8df5c9768b1ab447deb120295c60ed30ebb9a7d7ea251"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_darwin_arm64"
      sha256 "34b92bb4349af1ed1820f95c20241f9c3c424b92869ca8c16711c07f3baa34be"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_amd64"
      sha256 "4dc410517c92db16f7bd7e382d0b2b0ba68b8500a90164612ead284d85140dbe"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/gitsign/releases/download/v#{version}/gitsign-credential-cache_#{version}_linux_arm64"
      sha256 "ed690846ff679619f3631d82618c906ad9d14a193f65d9d8c0d525ddcbe7029a"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "gitsign-credential-cache_#{version}_#{os}_#{cpu}" => "gitsign-credential-cache"
  end

  test do
    system "#{bin}/gitsign-credential-cache", "--version"
  end
end
