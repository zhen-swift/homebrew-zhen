# Contributing

This repository holds one formula. A change to zhen itself belongs in
[zhen-core](https://github.com/zhen-swift/zhen-core).

- One formula change per pull request. A version bump is one pull request, opened after the
  zhen-core tag it names has been pushed. `Docs/RELEASING.md` has the steps.
- Run `Scripts/check.sh` before you open it. CI runs the same script.
- Add a line to `CHANGELOG.md` under **Unreleased**.
- Explain the decision, not the diff. Say why the formula has to change, and what you could
  not verify.
