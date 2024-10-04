# Quick Look yazi plugin for MacOS

To install, clone the repo, or

```shell
ya pack -a vvatikiotis/quicklook
```

To use, add the following keymap to 'keymap.toml':

```toml
[[manager.prepend_keymap]]
on = ["o"]
run = ["plugin quicklook"]
desc = "Macos Quicklook"
```
