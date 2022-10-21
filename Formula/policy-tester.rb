# typed: false
# frozen_string_literal: true

class PolicyTester < Formula
  desc "CLI for validating an image against a ClusterImagePolicy"
  homepage "https://sigstore.dev"
  version "0.4.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/policy-controller.git", tag: "v0.4.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-darwin-amd64"
      sha256 "23f3d19c09cffdc84fb0d060fefc31f1075be98824be386e4bd170bec887f9fd"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-darwin-arm64"
      sha256 "54aea12d46dcae7929aba260a88bb3e548f024a8547021788bfc744bf4653e8b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-linux-amd64"
      sha256 "39deceb663de852b8ac27ba816449fb8e14ca10532657be35b7bdd5829241f3e"
    end

    if Hardware::CPU.arm?
      url "https://github.com/sigstore/policy-controller/releases/download/v#{version}/tester-linux-arm64"
      sha256 "11d13e210e1349bf345566ceda53fb6da6f6914de8b6fdf5206de17ae11839e6"
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
