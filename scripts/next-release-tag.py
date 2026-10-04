import re
import sys


def next_release_tag(tags):
    versions = []
    for tag in tags:
        match = re.fullmatch(r"(v?)(\d+)\.(\d+)\.(\d+)", tag.strip())
        if match:
            prefix, major, minor, patch = match.groups()
            versions.append((prefix, int(major), int(minor), int(patch)))
    if not versions:
        raise ValueError("No stable version tag found; create an initial version tag first")
    prefix, major, minor, patch = max(versions, key=lambda version: version[1:])
    return f"{prefix}{major}.{minor}.{patch + 1}"


if __name__ == "__main__":
    try:
        print(next_release_tag(sys.stdin.read().splitlines()))
    except ValueError as error:
        sys.exit(str(error))
