# Mindustry Schematic Repository

Custom schematics for [Mindustry](https://mindustrygame.github.io/), compatible with the [Schematic Browser](https://github.com/MindustryDesignIt/schematic-browser-mod) mod.

## Adding This Repository

See the [Schematic Browser documentation](https://github.com/MindustryDesignIt/schematic-browser-mod#adding-repositories) for instructions on adding custom repositories.

## Structure

```
schematics/
```

Place `.msch` files directly in the `schematics/` folder. Subfolders act as categories in-game.

## Sync Helper

```bash
./sync.sh              # Commit & push with timestamp
./sync.sh "My message" # Commit & push with custom message
./auto-sync.sh &       # Auto-commit on file changes (background)
```

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)