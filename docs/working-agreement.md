# Working Agreement

## Canonical Workspace

All future code and documentation changes for CajaValentia happen here:

```text
/Users/ab/Documents/GitHub/CajaValentia
```

This local Git repository and its private GitHub remote are the single source of
truth for active work.

The older Drive project folder is an archive/source of historical evidence. Do
not edit code there. Read or copy from it only when auditing an old file, then
make the actual change and commit in the canonical Git repository.

## Before Any Work

1. Open the canonical repository, not the Drive project folder.
2. Run `git status -sb` and identify the current branch.
3. For a behavioral or hardware change, start a named branch from the intended
   baseline.
4. Make a focused commit with a plain-language message.
5. Push the branch to GitHub before relying on it as the only copy.

## Branches and Tags

- `main`: the stable reference line. It currently ends at `v2.0.0-rc.2`.
- `migration/r2022a-r2026a-ni-usb6501`: modern MATLAB/hardware work. Do not
  merge it into `main` until supervised Windows and physical-box validation.
- A tag names an exact, recoverable version. Do not move or delete release tags.
- Use a new `rc` tag only after a meaningful testable milestone.

## Hardware Rule

No source edit, tag, or simulation alone proves box safety. Keep physical tests
documented, supervised, and separate from active animal sessions. Record the
MATLAB version, driver version, device detection, and observed result.

## Keep Out of Git

- Animal/session results and identifying information.
- Passwords, private keys, WiFi credentials, and license files.
- Generated output in `matlab/resultados/`.

## Sharing With the Lab

The GitHub repository is private. Invite collaborators through GitHub rather
than sharing editable copies of folders. Ask them to comment, open an issue, or
work in a branch; no one should casually edit `main`.
