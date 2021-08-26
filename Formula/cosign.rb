# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev/"
  version "1.1.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"
  bottle :unneeded

  uses_from_macos "pcsc-lite" if OS.mac?

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-amd64"
    sha256 "786f2e084746581ac09ff4052bfbf4a8ba595e1e4d1602240b7a20a12780fd0b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-darwin-arm64"
    sha256 "953b26dca1dc208360ae5ff8b783a966c24e0894b4f39ad3e09818d77aa73fd0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign-linux-amd64"
    sha256 "c0b66f6948361f7f2c8c569d82d9471f36dd8354cf43f6bba6e578b31944127b"
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
