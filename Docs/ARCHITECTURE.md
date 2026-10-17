# Architecture

## What the formula does

`Formula/zhen.rb` downloads the source tarball of one zhen-core tag. It runs
`swift build --configuration release --product zhen`, then installs:

- `.build/release/zhen` to `bin/`.
- `zhen.1` from the repository root to `man1/`.

That is the same build and the same two files as zhen-core's `Scripts/install.sh`.

## Why from source

zhen-core publishes no release artifacts. Nothing signs or notarizes the command line,
and there are no GitHub Releases to download a binary from. Building from source needs
nothing that doesn't already exist.

The alternative is Homebrew bottles. Publishing them means a workflow with a write token that
commits bottle hashes back to `main`. The house rules don't allow workflows that write.

## Why there is no helper

zhen-core builds two executables, `zhen` and `zhen-helper`, and only `zhen` is installed.

`zhen-helper` is a launch daemon that the app registers through `SMAppService`, from inside
its own bundle. It only accepts clients signed with the app's Developer ID. A Homebrew
install can't register it and couldn't talk to it if it did.

The command line doesn't use the helper. Under `sudo` it opens the BPF device directly.

## The embedded Info.plist

zhen-core links `Sources/zhen/Info.plist` into the binary's `__TEXT,__info_plist` section.
That plist is what makes macOS attribute Local Network access to `zhen` rather than to the
terminal. A binary without it doesn't fail; it scans and reports an empty network.

The formula's `test do` therefore checks `otool -P` for `NSLocalNetworkUsageDescription`, the
same check `Scripts/install.sh` makes. The linker flag that embeds the plist is an
`unsafeFlags` setting. SwiftPM allows it here because the formula builds zhen-core as the root
package.

## Known rough edges

- **Users need Xcode 26.** With no bottles, every install compiles. A machine with only the
  Command Line Tools is refused by `depends_on xcode`.
- **The Local Network prompt can come back after an upgrade.** The binary is ad-hoc signed.
  macOS identifies it by the signature, and every build has a new one. This is unverified
  across a real upgrade, because there has only been one version.
- **From 0.8.0, `zhen --version` says "commit unknown".** zhen-core's `StampCommit` build
  plugin, added after 0.7.0, reads the commit from `.git`, and a tarball has none. Two ways
  out: point the formula at the git tag (`url "….git", tag:, revision:`), or have the plugin
  accept the commit from the environment. The second is a zhen-core change. Decide when
  0.8.0 is tagged.
- **`head` builds whatever is on zhen-core `main`.** It is there for testing a release
  before it is tagged. It is not supported.
