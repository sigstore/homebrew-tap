# typed: false
# frozen_string_literal: true

class PolicyTester < Formula
  desc "CLI for validating an image against a ClusterImagePolicy"
  homepage "https://sigstore.dev"
  version "0.7.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/policy-controller.git", tag: "v0.7.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-darwin-amd64"
      sha256 "3c8dd03c7da5e6c6e506c061a958c26cb199c5d2bb95216a887dd8645e1941d6"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-darwin-arm64"
      sha256 "f782f52270f614d007240839bc3b91767b18aa939b9f3ca9dbdd2094c2943a53"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-linux-amd64"
      sha256 "e67ca887c5df0c6d78a67b45f0adc6b9fc8dd43e1f12a0fbbe45977ee243fe78"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-linux-arm64"
      sha256 "50cbc03181ccac4392da4f6651d5bc93795cf8ec61b1d7953e1a875061623efe"
    end
  end

  def install
    cpu = Hardware::CPU.intel? ? "amd64" : "arm64"
    os = OS.mac? ? "darwin" : "linux"
    bin.install "tester-#{os}-#{cpu}" => "policy-tester"
  end

  test do
    system "#{bin}/policy-tester", "-version"
  end
end
