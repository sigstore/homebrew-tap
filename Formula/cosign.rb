# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev/"
  version "1.0.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"
  bottle :unneeded

  uses_from_macos "pcsc-lite" if OS.mac?

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
    sha256 "76656d48fa57f1bebbeaac8fdf5d17f590cdb45074e4d4fd5457a48f8e5ee497"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
    sha256 "f9b331c84117403d54e0c4e887db3eee58fc5059427e2ed251709c948f724d6e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
    sha256 "e36a05ab402bfee5463ad4752d8dc2941204c7b01a9a9931f921e91d94ba2484"
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
