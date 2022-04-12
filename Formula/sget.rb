# typed: false
# frozen_string_literal: true

class Sget < Formula
  desc "Automatic verification of signatures with our binary transparency log, Rekor"
  homepage "https://sigstore.dev"
  version "1.7.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git", tag: "v1.7.2"

  if Hardware::CPU.intel?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-amd64"
    sha256 "742c0b44a799e3a619164af8f3bd2cdd0b6309aa335bdcc9f061196239ac2efa"
  end

  if Hardware::CPU.arm?
    url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-darwin-arm64"
    sha256 "5e7134c68e3b3b78d6f55db63b57f200cd958ce4cf0fa0b60ddcce36e734933a"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-amd64"
      sha256 "fd1fc2143baadab82ac5a2fa6df6eb7a18b28485f04a50c8422b900881ddfc58"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/cosign/releases/download/v#{version}/sget-linux-arm64"
      sha256 "9631a9faaa49ad36742b7b83fa213cf7e8c95c6164b46c487ec52d581503ab51"
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
