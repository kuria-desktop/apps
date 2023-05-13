import os    # Access to `/` for strings

# src: out -> Compiles src.nim from srcDir as bin/out
namedBin = {
  "settings/main": "bin/settings",
}.toTable()

version       = "0.1.0"
author        = "Luke"
description   = "Apps for the kuria desktop environment"
license       = "GPL-3.0-only"


# Dependencies

requires "nim >= 1.4.8", "owlkettle"
