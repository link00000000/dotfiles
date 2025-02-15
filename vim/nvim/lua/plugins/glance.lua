return {
  "DNLHC/glance.nvim",
  -- Pinned because of regression introduced for nvim version 0.11
  -- https://github.com/DNLHC/glance.nvim/commit/4671f94372118e1659a7e71594d622719350389b#diff-7230cebf60aa12788f604a2e01061f49f20f877247f13f0025d851ae6da459e5R84
  commit = "cf91734f28fcd35bd60a5a87b6d768faafb73268",
  config = function ()
    require("glance").setup { }
  end,
}
