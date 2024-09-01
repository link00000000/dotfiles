function is_unreal_project()
  -- TODO: Check for UnrealNvim.json or *.uproject
end

return {
  "zadirion/Unreal.nvim",
  dependencies = {
    "tpope/vim-dispatch",
  },
  ft = { "cpp", "cxx", "h", "hpp" },
  cmd = { "UnrealGenWithEngine", "UnrealGen", "UnrealBuild", "UnrealRun", "UnrealCD" },
}
