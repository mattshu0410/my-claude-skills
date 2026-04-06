#!/bin/bash
# Install claude skills by symlinking into ~/.claude/skills/
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

mkdir -p "$SKILLS_DIR"

# Install scientific skills (from submodule)
for skill_dir in "$SCRIPT_DIR"/scientific/scientific-skills/*/; do
    skill_name="$(basename "$skill_dir")"
    skill_file="$skill_dir/SKILL.md"
    if [ -f "$skill_file" ]; then
        target="$SKILLS_DIR/scientific-$skill_name.md"
        ln -sf "$skill_file" "$target"
        echo "  Linked: scientific-$skill_name"
    fi
done

# Install custom skills
for skill_file in "$SCRIPT_DIR"/skills/*.md; do
    if [ -f "$skill_file" ]; then
        skill_name="$(basename "$skill_file")"
        target="$SKILLS_DIR/$skill_name"
        ln -sf "$skill_file" "$target"
        echo "  Linked: $skill_name"
    fi
done

echo "Done! Skills installed to $SKILLS_DIR"
