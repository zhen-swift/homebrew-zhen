class Zhen < Formula
  desc "Fast native network scanner that says what it could not work out"
  homepage "https://github.com/zhen-swift/zhen-core"
  url "https://github.com/zhen-swift/zhen-core/archive/refs/tags/0.7.0.tar.gz"
  sha256 "c5e672c109929eb6678d4ee5a7ab0c53a3abf04a0a1b6e888be42825f5ad04ad"
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
    # The Info.plist is linked into the binary. Without it the Local Network permission
    # attaches to the terminal instead, and every scan reports an empty network.
    assert_match "NSLocalNetworkUsageDescription", shell_output("otool -P #{bin}/zhen")
  end
end
