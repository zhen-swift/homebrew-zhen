class Zhen < Formula
  desc "Fast native network scanner that says what it could not work out"
  homepage "https://github.com/zhen-swift/zhen-core"
  # The git tag, not the tarball: zhen-core's StampCommit plugin reads the commit from
  # .git, and a tarball build would report "commit unknown".
  url "https://github.com/zhen-swift/zhen-core.git",
      tag:      "0.9.0",
      revision: "00dffeb06d03fd6e5142f6a9e0f2804b9ec471fe"
  license "Apache-2.0"
  head "https://github.com/zhen-swift/zhen-core.git", branch: "main"

  # zhen runs on macOS 15.6 and later. Homebrew can only name Sequoia, but Xcode 26 itself
  # needs 15.6, so the Xcode requirement is what holds the floor.
  depends_on xcode: ["26.0", :build]
  depends_on macos: :sequoia

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
