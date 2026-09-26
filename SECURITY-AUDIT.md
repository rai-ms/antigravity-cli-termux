# rai-ms fork: audit notes (2026-09-27)

Reviewed `install.sh`, `build.sh`, `lib/agy_helper.c` of wallentx/antigravity-cli-termux.

- No telemetry, credential access or data upload in the scripts or the C launcher.
- The launcher only clears LD_PRELOAD/LD_LIBRARY_PATH, sets GODEBUG/SSL_CERT_FILE and execs the
  patched official binary through Termux's glibc loader.
- The VA39 patch in build.sh is a deterministic instruction rewrite of Google's binary.

Changes in this fork:
1. Build from source on the device; do not use upstream prebuilt release tarballs.
2. build.sh only accepts a storage.googleapis.com/antigravity-public URL from Google's manifest
   and verifies the manifest's sha512 before patching.
3. Self-update (download of upstream prebuilt releases) is disabled in the launcher.
4. `install-local.sh` installs the locally built binaries.

Install: `pkg install glibc-repo && pkg install glibc clang jq python curl tar resolv-conf ca-certificates`,
then `./build.sh && ./install-local.sh`.
