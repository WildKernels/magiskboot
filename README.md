# magiskboot

Standalone build of `magiskboot` from [topjohnwu/Magisk](https://github.com/topjohnwu/Magisk) - no app, only the native boot image tool.

## What it does
- Clones upstream Magisk (shallow) nightly + on manual dispatch
- Builds only `magiskboot` via `build.py native magiskboot` (Rust + NDK)
- Publishes static binaries for all Android ABIs

Binaries are fully static (`-static`, `musl` tiny printf when `B_CRT0=1`) - run on device via `adb` or in recovery.

## Build locally
```bash
git clone https://github.com/topjohnwu/Magisk.git upstream
python upstream/build.py ndk          # one-time: downloads ONDK r30.1 to $ANDROID_HOME/ndk/magisk
python upstream/build.py -vr native magiskboot
ls upstream/native/out/*/magiskboot
```

Or via helper:
```bash
./scripts/sync.sh            # clone/update upstream + build
./scripts/build.sh           # build only (expects ./upstream present)
```

## CI
- Workflow: `.github/workflows/build.yml`
- Triggers: nightly `03:00 UTC` cron, `workflow_dispatch` (manual), push to `main`
- Artifacts: `magiskboot-<abi>` + `magiskboot-all.tar.gz`

## Roadmap
- [ ] Host builds: `x86_64` Linux exe, `macOS` arm64/x86_64, `Windows` exe (cross via `cargo` + `mingw`)
- Current workflow has placeholders (matrix disabled) - enable when NDK host cross is verified

## Upstream
- Source: https://github.com/topjohnwu/Magisk
- License: GPL-3.0-only (Magisk)
