# typed: false
# frozen_string_literal: true

class RekorCli < Formula
  desc "Secure Supply Chain - Transparency Log"
  homepage "https://sigstore.dev"
  version "1.2.2"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git", tag: "v1.2.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-amd64"
      sha256 "8f9945a2f8918e28cd91fd886db1a1a42cdaace1015f6f25f66e61d74d20a92e"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-darwin-arm64"
      sha256 "a0936b25387ce95eb8a8c906eb268a06d05f2c62f5e824946816fb4ced13dd53"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-amd64"
      sha256 "5244c65e2a5b0d73f87f2c8b7a7bdadb2ad0bc9db6c02d6ba2f559f27632d650"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/rekor/releases/download/v#{version}/rekor-cli-linux-arm64"
      sha256 "e4fab2149e2eeea3ad76982774d963d22a53354062db7b77f45919f87257921b"
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
