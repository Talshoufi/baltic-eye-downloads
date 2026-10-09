# Baltic Eye â€” installer downloads

**Baltic IT - Tareq Alshoufi**

Dedicated live-camera viewing for Ubuntu 24.04 Desktop, Intel/AMD 64-bit PCs. This repository contains the public setup script and compiled application downloads. Application source is maintained privately. No GitHub login is needed to install.

## Install

Close any running Baltic Eye window. In the Ubuntu desktop terminal:

```bash
sudo apt update
sudo apt install -y git curl
git clone https://github.com/Talshoufi/baltic-eye-downloads.git
cd baltic-eye-downloads
bash install.sh
~/.local/bin/baltic-eye --windowed
```

The script downloads the compiled v0.5.0 package and verifies its checksum. Internet access is required. Run as the desktop user; the installer requests sudo only for system dependencies. Existing cameras and credentials are retained and backed up. First-time installations ask you to set an administrator password and add your cameras.

Alternatively, download the ZIP and checksum from [Releases](https://github.com/Talshoufi/baltic-eye-downloads/releases), verify using `sha256sum -c`, extract the ZIP, and run `bash install-ubuntu.sh` from the extracted directory.

## Start automatically

After verifying your cameras, close the viewer and run:

```bash
bash ~/.local/share/baltic-eye-tools/enable-autostart.sh
```

Log out and back in. Startup requires a graphical desktop login. Ubuntu automatic login is not configured by this installer.

## Recovery

Close Baltic Eye and run `bash ~/.local/share/baltic-eye-tools/rollback.sh` to select the previous installed release. Configuration remains in `~/.local/share/aperture` for upgrade compatibility. Keep the database and device key together for filesystem recovery. Prefer encrypted backups from the application's settings.

## Release status

Version 0.5.0 is an appliance release candidate. Live viewing only; no recording or PTZ. Includes independent saved views, multiple viewing windows, and bulk camera setup with ONVIF discovery and stream testing. Hardware capacity and camera compatibility vary. Reboot/recovery and sustained-load testing on the target appliance remain required before customer deployment.

The original application Python source is not distributed in this package. Compilation is not a guarantee against reverse engineering. Runtime dependencies are installed separately and retain their own licence terms; see the package's third-party and compiler notices. A public download does not make the application open source.
