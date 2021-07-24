# typed: false
# frozen_string_literal: true

class Cosign < Formula
  desc "Container Signing, Verification and Storage in an OCI registry"
  homepage "https://sigstore.dev/"
  version "0.6.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"
  bottle :unneeded

  uses_from_macos "pcsc-lite"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign_darwin_amd64_#{version}_darwin_amd64"
    sha256 "357041436df8638036c35a57664b3c0d5ee9087887e63782749534a8b198f208"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign_darwin_arm64_#{version}_darwin_arm64"
    sha256 "11f17e47bb0985b047bd7374dbfae6f07c25c808e8c236ff784481a1473aaac8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/cosign_linux_amd64_#{version}_linux_amd64"
    sha256 "00add9839794d76a2863fd534677ff48686d796dea06ccef6b82422a5955b9bf"
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "cosign_#{os}_#{cpu}_#{version}_#{os}_#{cpu}" => "cosign"
  end

  test do
    system "#{bin}/cosign", "version"
  end
end
