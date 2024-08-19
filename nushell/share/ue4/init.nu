def __ensure-ue4cli [] {
  if (which ^ue4 | is-empty) {
    error make {
      msg: "ue4 command not found",
      help: "Install ue4cli from https://github.com/adamrehn/ue4cli",
    }
  }
}

def __ensure-uproject [] {
  if (glob *.uproject | is-empty) {
    error make { msg: "Current directory does not contain a uproject." }
  }
}

export def ue4 [] {
  echo "Use `ue` instead"
}

export def ue5 [] {
  echo "Use `ue` instead"
}

export def --wrapped ue [...rest] {
  ^ue4 ...$rest
}

# Clean rebuild project
export def --wrapped "ue rebuild" [...rest] {
  __ensure-ue4cli
  __ensure-uproject

  ^ue4 clean
  ^ue4 rebuild ...$rest
}

# Build project
export def --wrapped "ue build" [...rest] {
  __ensure-ue4cli
  __ensure-uproject

  ^ue4 build ...$rest
}

# Build and run project
export def --wrapped "ue run" [
  --no-build, # Skip project re-build step
  --build-args: string, # Additional arguments to pass to `ue build` during build step
  ...rest
] {
  __ensure-ue4cli
  __ensure-uproject

  if not ($no_build) {
    ue build $build_args
  }

  ^ue4 run ...$rest
}

# Generate project files
export def --wrapped "ue gen" [
  --ctags, # Generate ctags
  ...rest
] {
  __ensure-ue4cli
  __ensure-uproject

  let project_name = (pwd | path parse | get stem)
  
  ^ue4 gen -VSCode ...$rest

  (open $".vscode/compileCommands_($project_name).json"
    | str replace --regex $"(^ue4 root)\\(.*\\)clang++" $"clang++ @'(pwd)/clang-flags.txt'"
    | save --force "compile_commands.json")

  if ($ctags) {
    if (which ctags | is-empty) {
      error make {
        msg: "ctags command not found",
        help: "Install with `winget install UniversalCtags.Ctags`"
      }
    }

    echo "Generating ctags"
  	ctags -R --c++-kinds=+p --fields=+iaS --extras=+q --languages=C++ $"(^ue4 root)/Engine/Source"
  }
}
