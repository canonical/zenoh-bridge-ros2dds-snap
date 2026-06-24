# zenoh-bridge-ros2dds-snap

The [zenoh-bridge-ros2dds](https://github.com/eclipse-zenoh/zenoh-plugin-ros2dds) application as a snap.

[![Get it from the Snap Store](https://snapcraft.io/en/dark/install.svg)](https://snapcraft.io/zenoh-bridge-ros2dds)
[![zenoh-bridge-ros2dds](https://snapcraft.io/zenoh-bridge-ros2dds/badge.svg)](https://snapcraft.io/zenoh-bridge-ros2dds)

## Install

To install the snap from the store:

```bash
snap install zenoh-bridge-ros2dds
```

## Usage

The bridge daemon is installed **disabled**. Enable and start it with:

```bash
sudo snap start --enable zenoh-bridge-ros2dds.bridge
```

To stop and disable it again:

```bash
sudo snap stop --disable zenoh-bridge-ros2dds.bridge
```

To run an ad-hoc bridge instance without the daemon:

```bash
snap run zenoh-bridge-ros2dds.zenoh-bridge-ros2dds [OPTIONS]
```

### Configuration

Config is auto-discovered on startup.
Place the configuration file in one of the following directories:

| Directory | Applies to |
|---|---|
| `~/snap/zenoh-bridge-ros2dds/common/` | Ad-hoc app only; takes precedence |
| `/var/snap/zenoh-bridge-ros2dds/common/` | Daemon and ad-hoc app (fallback) |

Having more than one extension in the same directory is an error — the launcher will print the conflicting filenames and exit.

To bypass auto-discovery and pass a config explicitly:

```bash
snap run zenoh-bridge-ros2dds.zenoh-bridge-ros2dds -c ~/snap/zenoh-bridge-ros2dds/common/my-config.json5
```

After changing the daemon's config, restart it:

```bash
sudo snap restart zenoh-bridge-ros2dds.bridge
```

See the [upstream DEFAULT_CONFIG.json5](https://github.com/eclipse-zenoh/zenoh-plugin-ros2dds/blob/main/DEFAULT_CONFIG.json5)
for a fully annotated example of all available options.

### Required interfaces

The snap uses `strict` confinement. The `network` and `network-bind` interfaces
are auto-connected.

## Development

Make sure that [snapcraft is installed](https://snapcraft.io/docs/snapcraft-setup).

Build the snap:

```bash
snapcraft pack
```

Install the locally built snap:

```bash
sudo snap install --dangerous zenoh-bridge-ros2dds_*.snap
```
