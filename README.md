# Mindustry Schematic Repository

Personal schematic collection for [Mindustry](https://mindustrygame.github.io/), compatible with [Schematic Browser](https://github.com/MindustryDesignIt/schematic-browser-mod).

## Structure

```
schematics/          # Place your .msch files here
sync.sh              # Manual sync: stages, commits, and pushes .msch files
auto-sync.sh         # Auto-sync: watches for changes and syncs automatically
```

## Usage

### Manual sync
```bash
./sync.sh                    # Auto-generates commit message with timestamp
./sync.sh "Add new base"     # Custom commit message
```

### Auto-sync (runs in background)
```bash
./auto-sync.sh &             # Start watching for changes
pkill -f auto-sync.sh        # Stop auto-sync
```

## Schematic Browser Mod Setup

1. Install the [Schematic Browser mod](https://github.com/MindustryDesignIt/schematic-browser-mod)
2. In Mindustry, open the Schematic Browser settings
3. Add this repository's raw URL as a source:
   ```
   https://raw.githubusercontent.com/<your-username>/<repo-name>/main/schematics/
   ```
4. Reload schematics in the mod

## Requirements

- `git` 
- `inotify-tools` (for auto-sync): `sudo pacman -S inotify-tools` / `sudo apt install inotify-tools`
- GitHub remote configured as `origin`

## Notes

- Only `.msch` files are tracked (configured in `.gitattributes` as binary)
- The `schematics/` folder is the only folder synced
- Commit history stays clean — only schematic changes are committed
