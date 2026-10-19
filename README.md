# homebrew-zhen

The Homebrew tap for [zhen](https://github.com/zhen-swift/zhen-core), a fast native network
scanner for macOS.

```sh
brew install zhen-swift/zhen/zhen
```

Installing by the full name trusts this one formula, which Homebrew requires for anything
outside its official taps. After that, `zhen` alone is enough.

Upgrade with `brew upgrade zhen` and remove it with `brew uninstall zhen`. Uninstalling leaves
your scan history in `~/Library/Application Support/zhen/`.

## Requirements

- macOS 15.6 (Sequoia) or later, on Apple silicon or Intel.
- Xcode 26. The formula builds zhen from source, and there are no prebuilt bottles.

## What it installs

- `zhen`, the command line.
- `man zhen`, its manual page.

It does not install `zhen-helper`, the privileged helper. The zhen app registers that helper
for itself. The command line doesn't need it: under `sudo` it opens the capture device
directly.

## Problems

Report bugs in zhen to [zhen-core](https://github.com/zhen-swift/zhen-core/issues). Only
problems with the formula itself belong here.
