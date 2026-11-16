#!/usr/bin/env python3
"""Keep the published docs site (the gh-pages branch) in line with its folders.

The site is laid out as:

    stable/                docs built from master
    latest/                docs built from develop
    vX.Y.Z/                releases
    vX.Y.Z-rc/             release candidates, until vX.Y.Z is published
    versions.json          every version, for the pickers
    version-switcher.js    the floating version picker

    docs_versions.py update SITE

update does three things:

1. Deletes each release candidate folder (vX.Y.Z-rc) once its final release
   (vX.Y.Z) has been published.
2. Writes versions.json: stable, latest, then every release, newest first,
   with a release candidate listed just below its final release.
   The site root (index.html) forwards readers to the first entry, and the
   picker on each version's home page reads the whole list.
3. Makes sure the home page of every version (stable/, latest/ and each
   release folder, old ones included) loads version-switcher.js. It runs on
   every publish because a rebuilt folder starts without the script tag, and
   it skips pages that already have the tag.
"""

import argparse
import json
import re
import shutil
from pathlib import Path

RELEASE_DIR = re.compile(r"^v(\d+)\.(\d+)\.(\d+)(-rc)?$")

# (major, minor, patch, final), see releases()
Version = tuple[int, int, int, int]

# listed ahead of the releases, as (folder, label shown in the picker)
PINNED = [("stable", "stable"), ("latest", "latest (develop)")]

# Each version's home page is one folder below the site root, where
# version-switcher.js is published, so the relative path works wherever the
# site is served from (the custom domain or a fork's /<repo>/ path).
SWITCHER_FILE = "version-switcher.js"
SWITCHER_TAG = f'<script src="../{SWITCHER_FILE}" defer></script>'


def releases(site: Path) -> dict[Version, str]:
    """Find the release folders (vX.Y.Z and vX.Y.Z-rc) directly under site.

    The version is split into numbers so that versions compare the way people
    expect: as text "2.10.0" would sort before "2.9.0", as (2, 10, 0) it
    sorts after (2, 9, 0). A fourth number, 0 for a release candidate and 1
    for a final release, sorts 2.1.3-rc just below 2.1.3.

    Args:
        site: Directory holding the published docs, one folder per version.

    Returns:
        A dict mapping (major, minor, patch, final) to the folder name, for
        example {(2, 1, 5, 1): "v2.1.5", (3, 0, 0, 0): "v3.0.0-rc"}. Folders
        that are not named vX.Y.Z or vX.Y.Z-rc, such as stable/ and latest/,
        are left out.
    """
    found = {}
    for folder in site.iterdir():
        match = RELEASE_DIR.match(folder.name)
        if folder.is_dir() and match:
            major, minor, patch, rc = match.groups()
            version = (int(major), int(minor), int(patch), 0 if rc else 1)
            found[version] = folder.name
    return found


def remove_replaced_rcs(site: Path) -> list[str]:
    """Delete each release candidate folder whose final release is published.

    Args:
        site: Directory holding the published docs, one folder per version.

    Returns:
        The folders that were deleted, as a list of names.
    """
    found = releases(site)
    removed = []
    for (major, minor, patch, final), folder in sorted(found.items()):
        if not final and (major, minor, patch, 1) in found:
            shutil.rmtree(site / folder)
            removed.append(folder)
    return removed


def add_switcher(site: Path) -> list[str]:
    """Make each version's home page load version-switcher.js.

    Adds SWITCHER_TAG just before the closing body tag of index.html in
    stable/, latest/ and every release folder. Pages that already load the
    script are left alone, so running this again changes nothing. Old
    releases are patched this way too: they get one added line and nothing
    else.

    Args:
        site: Directory holding the published docs, one folder per version.

    Returns:
        The folders whose index.html was changed, as a list of names.
    """
    folders = [folder for folder, _ in PINNED] + [
        found for _, found in sorted(releases(site).items(), reverse=True)
    ]
    changed = []
    for name in folders:
        page = site / name / "index.html"
        if not page.is_file():
            continue
        # bytes in and out, so nothing else in the page is touched
        html = page.read_bytes().decode("utf-8")
        if SWITCHER_FILE in html:
            continue
        # searches from the end and splits around the last </body>
        head, closing, tail = html.rpartition("</body>")
        if not closing:
            print(f"warning: {page} has no </body>, switcher not added")
            continue
        # the new line goes above </body>, which keeps its own indent
        indent = head[len(head.rstrip(" \t")) :]
        page.write_bytes(
            f"{head}{SWITCHER_TAG}\n{indent}{closing}{tail}".encode("utf-8")
        )
        changed.append(name)
    return changed


def update(site: Path) -> None:
    """Tidy up release candidates, write site/versions.json and add the
    version picker to the home pages.

    Release candidates whose final release is published are deleted first,
    so they drop out of versions.json too. versions.json holds stable and
    latest (when their folders exist), followed by every release, newest
    first. The site root page forwards readers to the first entry, and the
    picker on each version's home page lists all of them.

    Args:
        site: Directory holding the published docs, one folder per version.
    """
    removed = remove_replaced_rcs(site)
    print("release candidates removed:", ", ".join(removed) or "(none)")

    found = releases(site)

    entries = [
        {"name": label, "path": f"{folder}/"}
        for folder, label in PINNED
        if (site / folder).is_dir()
    ]
    entries += [
        # the label is the folder name without its "v": 2.1.3 or 2.1.3-rc
        {"name": found[version][1:], "path": f"{found[version]}/"}
        for version in sorted(found, reverse=True)
    ]
    (site / "versions.json").write_text(json.dumps(entries, indent=2) + "\n")
    print("versions.json:", ", ".join(entry["name"] for entry in entries) or "(empty)")

    changed = add_switcher(site)
    print("version picker added to:", ", ".join(changed) or "(nothing new)")


def main():
    """Read the command line and run update(), as the docs workflow calls it:

        docs_versions.py update SITE
    """
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    commands = parser.add_subparsers(dest="command", required=True)
    rewrite = commands.add_parser("update")
    rewrite.add_argument("site", type=Path)

    args = parser.parse_args()
    update(args.site)


if __name__ == "__main__":
    main()
