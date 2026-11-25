"""Unit tests for .github/scripts/docs_versions.py

Run from the repository root with:

    pytest tests/test_docs_versions.py
"""

import json
import os
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "../.github/scripts"))

from docs_versions import (  # noqa: E402
    SWITCHER_TAG,
    add_switcher,
    is_final,
    releases,
    remove_replaced_rcs,
    update,
)

SCRIPT = os.path.join(os.path.dirname(__file__), "../.github/scripts/docs_versions.py")


def make_site(site: Path, *folders: str, home: bool = True) -> Path:
    """Build a fake published docs site to run docs_versions.py against.

    Args:
        site: Directory to build the site in, usually pytest's tmp_path.
        folders: Version folders to create, such as "stable" or "v2.1.5".
        home: Whether to give each folder a minimal index.html home page.

    Returns:
        The site directory, for chaining.
    """
    for name in folders:
        (site / name).mkdir(parents=True)
        if home:
            (site / name / "index.html").write_text(
                "<html>\n  <body>\n    <p>docs</p>\n  </body>\n</html>\n"
            )
    return site


def versions_json(site: Path) -> list[dict[str, str]]:
    """Read the versions.json that update() wrote.

    Args:
        site: Directory holding the published docs.

    Returns:
        The entries of versions.json, each a {"name": ..., "path": ...} dict.
    """
    return json.loads((site / "versions.json").read_text())


def names(site: Path) -> list[str]:
    """Read the version labels from versions.json, in picker order.

    Args:
        site: Directory holding the published docs.

    Returns:
        The "name" of each entry, such as ["2.1.5", "stable"].
    """
    return [entry["name"] for entry in versions_json(site)]


class TestReleases:
    """releases() finds the vX.Y.Z and vX.Y.Z-rc folders and turns their names
    into sortable version tuples."""

    def test_parses_final_and_rc_folders(self, tmp_path):
        """A final release gets 1 as its fourth number and an RC gets 0."""
        make_site(tmp_path, "v2.1.5", "v3.0.0-rc")
        assert releases(tmp_path) == {
            (2, 1, 5, 1): "v2.1.5",
            (3, 0, 0, 0): "v3.0.0-rc",
        }

    def test_ignores_non_release_folders_and_files(self, tmp_path):
        """Only folders named exactly vX.Y.Z or vX.Y.Z-rc count as releases;
        stable/, latest/, other names and plain files are ignored."""
        make_site(tmp_path, "stable", "latest", "v2.1", "2.1.5", "v2.1.5-beta")
        (tmp_path / "v9.9.9").write_text("a file, not a folder")
        assert releases(tmp_path) == {}

    def test_versions_sort_numerically_with_rc_below_its_release(self, tmp_path):
        """Versions sort as numbers (2.10 after 2.9), and an RC sorts just below
        its final release."""
        make_site(tmp_path, "v2.9.0", "v2.10.0", "v2.10.0-rc", "v10.0.0")
        ordered = [releases(tmp_path)[v] for v in sorted(releases(tmp_path))]
        assert ordered == ["v2.9.0", "v2.10.0-rc", "v2.10.0", "v10.0.0"]


class TestIsFinal:
    """is_final() tells a final release from a release candidate."""

    def test_final_release(self):
        """A version tuple ending in 1 (vX.Y.Z) is a final release."""
        assert is_final((3, 0, 0, 1)) is True

    def test_release_candidate(self):
        """A version tuple ending in 0 (vX.Y.Z-rc) is not a final release."""
        assert is_final((3, 0, 0, 0)) is False


class TestRemoveReplacedRcs:
    """remove_replaced_rcs() deletes an RC folder once its final release is
    published, and nothing else."""

    def test_removes_rc_once_its_release_is_published(self, tmp_path):
        """v3.0.0-rc is deleted when v3.0.0 exists, and v3.0.0 is kept."""
        make_site(tmp_path, "v3.0.0", "v3.0.0-rc")
        assert remove_replaced_rcs(tmp_path) == ["v3.0.0-rc"]
        assert not (tmp_path / "v3.0.0-rc").exists()
        assert (tmp_path / "v3.0.0").is_dir()

    def test_keeps_rc_without_its_release(self, tmp_path):
        """An RC whose final release isn't published yet stays on the site."""
        make_site(tmp_path, "v2.1.5", "v3.0.0-rc")
        assert remove_replaced_rcs(tmp_path) == []
        assert (tmp_path / "v3.0.0-rc").is_dir()

    def test_keeps_rc_when_only_an_older_release_matches_partly(self, tmp_path):
        """Only the exact same X.Y.Z replaces an RC: v3.0.1 does not replace
        v3.0.0-rc or v3.1.0-rc."""
        make_site(tmp_path, "v3.0.1", "v3.0.0-rc", "v3.1.0-rc")
        assert remove_replaced_rcs(tmp_path) == []


class TestAddSwitcher:
    """add_switcher() adds the version-switcher.js script tag to the home page
    of each version folder."""

    def test_adds_tag_before_closing_body_with_its_indent(self, tmp_path):
        """The tag goes on its own line just above </body>, using the same
        indent as </body>, and nothing else in the page changes."""
        make_site(tmp_path, "stable")
        assert add_switcher(tmp_path) == ["stable"]
        html = (tmp_path / "stable" / "index.html").read_text()
        assert html == (
            "<html>\n  <body>\n    <p>docs</p>\n"
            f"  {SWITCHER_TAG}\n  </body>\n</html>\n"
        )

    def test_running_twice_changes_nothing(self, tmp_path):
        """A page that already loads the script is left alone, so the publish
        workflow can run the script on every publish."""
        make_site(tmp_path, "stable", "v2.1.5")
        add_switcher(tmp_path)
        before = (tmp_path / "v2.1.5" / "index.html").read_text()
        assert add_switcher(tmp_path) == []
        assert (tmp_path / "v2.1.5" / "index.html").read_text() == before

    def test_covers_pinned_and_release_folders_only(self, tmp_path):
        """stable/, latest/ and release folders get the tag; any other folder
        on the site is not touched."""
        make_site(tmp_path, "stable", "latest", "v2.1.5", "v3.0.0-rc", "other")
        assert add_switcher(tmp_path) == ["stable", "latest", "v3.0.0-rc", "v2.1.5"]
        assert SWITCHER_TAG not in (tmp_path / "other" / "index.html").read_text()

    def test_skips_folder_without_home_page(self, tmp_path):
        """A version folder with no index.html is skipped without an error."""
        make_site(tmp_path, "stable", home=False)
        assert add_switcher(tmp_path) == []

    def test_warns_when_page_has_no_closing_body(self, tmp_path, capsys):
        """A page with no </body> is left unchanged and a warning is printed."""
        make_site(tmp_path, "stable", home=False)
        page = tmp_path / "stable" / "index.html"
        page.write_text("<html><p>no body tag</p></html>")
        assert add_switcher(tmp_path) == []
        assert page.read_text() == "<html><p>no body tag</p></html>"
        assert "has no </body>" in capsys.readouterr().out


class TestUpdate:
    """update() removes replaced RCs, writes versions.json in picker order and
    adds the switcher to every home page."""

    def test_newest_final_release_is_listed_first(self, tmp_path):
        """The newest final release comes first, then stable and latest, then
        every other release (RCs included), newest first."""
        make_site(
            tmp_path, "stable", "latest", "v2.1.5", "v2.9.1", "v2.10.0", "v3.0.0-rc"
        )
        update(tmp_path)
        assert names(tmp_path) == [
            "2.10.0",
            "stable",
            "latest (develop)",
            "3.0.0-rc",
            "2.9.1",
            "2.1.5",
        ]

    def test_entries_point_at_the_folders(self, tmp_path):
        """Each entry's label drops the "v" from the folder name, and its path
        is the folder, which the picker and the site root link to."""
        make_site(tmp_path, "stable", "latest", "v2.1.5")
        update(tmp_path)
        assert versions_json(tmp_path) == [
            {"name": "2.1.5", "path": "v2.1.5/"},
            {"name": "stable", "path": "stable/"},
            {"name": "latest (develop)", "path": "latest/"},
        ]

    def test_pinned_first_when_no_final_release(self, tmp_path):
        """With only an RC published, stable and latest stay at the top; an RC
        is never put first."""
        make_site(tmp_path, "stable", "latest", "v3.0.0-rc")
        update(tmp_path)
        assert names(tmp_path) == ["stable", "latest (develop)", "3.0.0-rc"]

    def test_missing_pinned_folders_are_left_out(self, tmp_path):
        """stable or latest is only listed when its folder exists."""
        make_site(tmp_path, "latest", "v2.1.5")
        update(tmp_path)
        assert names(tmp_path) == ["2.1.5", "latest (develop)"]

    def test_replaced_rc_is_removed_and_dropped_from_list(self, tmp_path):
        """An RC replaced by its final release is deleted and doesn't appear in
        versions.json."""
        make_site(tmp_path, "stable", "v3.0.0", "v3.0.0-rc")
        update(tmp_path)
        assert names(tmp_path) == ["3.0.0", "stable"]
        assert not (tmp_path / "v3.0.0-rc").exists()

    def test_empty_site_writes_empty_list(self, tmp_path):
        """A site with no version folders gets an empty versions.json."""
        update(tmp_path)
        assert versions_json(tmp_path) == []

    def test_adds_switcher_to_every_home_page(self, tmp_path):
        """update() also adds the version picker to every version's home
        page."""
        make_site(tmp_path, "stable", "latest", "v2.1.5")
        update(tmp_path)
        for name in ("stable", "latest", "v2.1.5"):
            assert SWITCHER_TAG in (tmp_path / name / "index.html").read_text()


def test_command_line_update(tmp_path):
    """Running the script as the docs workflow does
    (python3 docs_versions.py update SITE) writes versions.json and prints the
    list."""
    make_site(tmp_path, "stable", "v2.1.5")
    result = subprocess.run(
        [sys.executable, SCRIPT, "update", str(tmp_path)],
        capture_output=True,
        text=True,
        check=True,
    )
    assert "versions.json: 2.1.5, stable" in result.stdout
    assert names(tmp_path) == ["2.1.5", "stable"]


def test_command_line_requires_a_command():
    """Running the script without the update command fails instead of doing
    nothing."""
    result = subprocess.run([sys.executable, SCRIPT], capture_output=True, text=True)
    assert result.returncode != 0
