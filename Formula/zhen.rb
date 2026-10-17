class Zhen < Formula
  desc "Fast native network scanner that says what it could not work out"
  homepage "https://github.com/zhen-swift/zhen-core"
  # The git tag, not the tarball: zhen-core's StampCommit plugin reads the commit from
  # .git, and a tarball build would report "commit unknown".
  url "https://github.com/zhen-swift/zhen-core.git",
      tag:      "0.8.0",
      revision: "f629ba242533be893ca7d49ba4a789d598647d9d"
  license "Apache-2.0"
  head "https://github.com/zhen-swift/zhen-core.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on macos: :tahoe

  def install
    # SwiftPM sandboxes its own build and Homebrew already sandboxes this one; the two
    # cannot nest.
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "zhen"
    bin.install ".build/release/zhen"
    man1.install "zhen.1"
  end

  def caveats
    <<~EOS
      The first scan asks for Local Network access for `zhen`. Without it, scans come
      back empty. Allow it in System Settings > Privacy & Security > Local Network.

      `sudo zhen` adds the ARP sweep, half-open port scanning and fingerprinting.

      Scan history is kept in ~/Library/Application Support/zhen/ and is not removed
      by `brew uninstall`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zhen --version")
    refute_match "commit unknown", shell_output("#{bin}/zhen --version")
    # The Info.plist is linked into the binary. Without it the Local Network permission
    # attaches to the terminal instead, and every scan reports an empty network.
    assert_match "NSLocalNetworkUsageDescription", shell_output("otool -P #{bin}/zhen")
  end
end
