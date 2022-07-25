# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.10.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.10.0"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "2e0d0d85df678d3dae15c71be475afee1253f297f047aa0fe4a073aef0ab9cc9"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "1c72933b6e2f02dc6a304a4906cd98eb205f269a8f73c61a0561659e88b0cba6"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "e027aee742ffa1af04438f92a049c3d5ca6c472ec559fb9d1493272328d90218"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "75dd354be0276b7fb9a32e980cdb752d6192e8777eabd7ad48d7e921778fd042"
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
