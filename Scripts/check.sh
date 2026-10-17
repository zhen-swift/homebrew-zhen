#!/usr/bin/env bash
# What CI runs, and what to run before opening a pull request. The tap must already be
# tapped: in CI by setup-homebrew, locally with
#
#     brew tap zhen-swift/zhen "$(git rev-parse --show-toplevel)"
#
# It builds from source and never calls sudo.
set -euo pipefail

FORMULA="zhen-swift/zhen/zhen"

# Homebrew refuses to load a formula from an untrusted tap. This is the same item-level
# trust that `brew install zhen-swift/zhen/zhen` grants, and nothing broader. The audit
# runs before the install, so the trust has to be granted here.
brew trust --formula "${FORMULA}"

brew style zhen-swift/zhen
brew audit --strict --online "${FORMULA}"
brew install --build-from-source --verbose "${FORMULA}"
brew test --verbose "${FORMULA}"
