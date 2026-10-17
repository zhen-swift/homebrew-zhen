## What this changes, and why

<!-- A version bump names the zhen-core tag. Anything else says why the formula has to
     change rather than zhen-core. -->

## Checks

- [ ] `Scripts/check.sh` passes locally
- [ ] A version bump follows a pushed zhen-core tag, and `sha256` is the hash of that tag's tarball
- [ ] `CHANGELOG.md` has a line under **Unreleased**

## The rules this repository does not bend

- [ ] Tagged zhen-core releases only. Never a branch, never an untagged commit
- [ ] `zhen-helper` is never installed
- [ ] No bottles, and no workflow that writes to the repository

## What you could not verify

<!-- Say it plainly. -->
