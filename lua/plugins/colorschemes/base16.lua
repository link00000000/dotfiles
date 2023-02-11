local M = {}

local scheme = {
	_3024 = "base16-3024",
	apathy = "base16-apathy",
	ashes = "base16-ashes",
	atelier_cave_light = "base16-atelier-cave-light",
	atelier_cave = "base16-atelier-cave",
	atelier_dune_light = "base16-atelier-dune-light",
	atelier_dune = "base16-atelier-dune",
	atelier_estuary_light = "base16-atelier-estuary-light",
	atelier_estuary = "base16-atelier-estuary",
	atelier_forest_light = "base16-atelier-forest-light",
	atelier_forest = "base16-atelier-forest",
	atelier_heath_light = "base16-atelier-heath-light",
	atelier_heath = "base16-atelier-heath",
	atelier_lakeside_light = "base16-atelier-lakeside-light",
	atelier_lakeside = "base16-atelier-lakeside",
	atelier_plateau_light = "base16-atelier-plateau-light",
	atelier_plateau = "base16-atelier-plateau",
	atelier_savanna_light = "base16-atelier-savanna-light",
	atelier_savanna = "base16-atelier-savanna",
	atelier_seaside_light = "base16-atelier-seaside-light",
	atelier_seaside = "base16-atelier-seaside",
	atelier_sulphurpool_light = "base16-atelier-sulphurpool-light",
	atelier_sulphurpool = "base16-atelier-sulphurpool",
	atlas = "base16-atlas",
	bespin = "base16-bespin",
	black_metal_bathory = "base16-black-metal-bathory",
	black_metal_burzum = "base16-black-metal-burzum",
	black_metal_dark_funeral = "base16-black-metal-dark-funeral",
	black_metal_gorgoroth = "base16-black-metal-gorgoroth",
	black_metal_immortal = "base16-black-metal-immortal",
	black_metal_khold = "base16-black-metal-khold",
	black_metal_marduk = "base16-black-metal-marduk",
	black_metal_mayhem = "base16-black-metal-mayhem",
	black_metal_nile = "base16-black-metal-nile",
	black_metal_venom = "base16-black-metal-venom",
	black_metal = "base16-black-metal",
	brewer = "base16-brewer",
	bright = "base16-bright",
	brogrammer = "base16-brogrammer",
	brushtrees_dark = "base16-brushtrees-dark",
	brushtrees = "base16-brushtrees",
	chalk = "base16-chalk",
	circus = "base16-circus",
	classic_dark = "base16-classic-dark",
	classic_light = "base16-classic-light",
	codeschool = "base16-codeschool",
	cupcake = "base16-cupcake",
	cupertino = "base16-cupertino",
	darktooth = "base16-darktooth",
	decaf = "base16-decaf",
	default_dark = "base16-default-dark",
	default_light = "base16-default-light",
	dracula = "base16-dracula",
	edge_dark = "base16-edge-dark",
	edge_light = "base16-edge-light",
	eighties = "base16-eighties",
	embers = "base16-embers",
	espresso = "base16-espresso",
	flat = "base16-flat",
	framer = "base16-framer",
	fruit_soda = "base16-fruit-soda",
	gigavolt = "base16-gigavolt",
	github = "base16-github",
	google_dark = "base16-google-dark",
	google_light = "base16-google-light",
	grayscale_dark = "base16-grayscale-dark",
	grayscale_light = "base16-grayscale-light",
	greenscreen = "base16-greenscreen",
	gruvbox_dark_hard = "base16-gruvbox-dark-hard",
	gruvbox_dark_medium = "base16-gruvbox-dark-medium",
	gruvbox_dark_pale = "base16-gruvbox-dark-pale",
	gruvbox_dark_soft = "base16-gruvbox-dark-soft",
	gruvbox_light_hard = "base16-gruvbox-light-hard",
	gruvbox_light_medium = "base16-gruvbox-light-medium",
	gruvbox_light_soft = "base16-gruvbox-light-soft",
	harmonic_dark = "base16-harmonic-dark",
	harmonic_light = "base16-harmonic-light",
	heetch_light = "base16-heetch-light",
	heetch = "base16-heetch",
	helios = "base16-helios",
	hopscotch = "base16-hopscotch",
	horizon_dark = "base16-horizon-dark",
	horizon_light = "base16-horizon-light",
	horizon_terminal_dark = "base16-horizon-terminal-dark",
	horizon_terminal_light = "base16-horizon-terminal-light",
	ia_dark = "base16-ia-dark",
	ia_light = "base16-ia-light",
	icy = "base16-icy",
	irblack = "base16-irblack",
	isotope = "base16-isotope",
	macintosh = "base16-macintosh",
	marrakesh = "base16-marrakesh",
	materia = "base16-materia",
	material_darker = "base16-material-darker",
	material_lighter = "base16-material-lighter",
	material_palenight = "base16-material-palenight",
	material_vivid = "base16-material-vivid",
	material = "base16-material",
	mellow_purple = "base16-mellow-purple",
	mexico_light = "base16-mexico-light",
	mocha = "base16-mocha",
	monokai = "base16-monokai",
	nord = "base16-nord",
	nova = "base16-nova",
	ocean = "base16-ocean",
	oceanicnext = "base16-oceanicnext",
	one_light = "base16-one-light",
	onedark = "base16-onedark",
	outrun_dark = "base16-outrun-dark",
	papercolor_dark = "base16-papercolor-dark",
	papercolor_light = "base16-papercolor-light",
	paraiso = "base16-paraiso",
	phd = "base16-phd",
	pico = "base16-pico",
	pop = "base16-pop",
	porple = "base16-porple",
	railscasts = "base16-railscasts",
	rebecca = "base16-rebecca",
	sandcastle = "base16-sandcastle",
	seti = "base16-seti",
	shapeshifter = "base16-shapeshifter",
	snazzy = "base16-snazzy",
	solarflare = "base16-solarflare",
	solarized_dark = "base16-solarized-dark",
	solarized_light = "base16-solarized-light",
	spacemacs = "base16-spacemacs",
	summerfruit_dark = "base16-summerfruit-dark",
	summerfruit_light = "base16-summerfruit-light",
	synth_midnight_dark = "base16-synth-midnight-dark",
	tomorrow_night_eighties = "base16-tomorrow-night-eighties",
	tomorrow_night = "base16-tomorrow-night",
	tomorrow = "base16-tomorrow",
	tube = "base16-tube",
	twilight = "base16-twilight",
	unikitty_dark = "base16-unikitty-dark",
	unikitty_light = "base16-unikitty-light",
	woodland = "base16-woodland",
	xcode_dusk = "base16-xcode-dusk",
	zenburn = "base16-zenburn",
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default_dark)
end

return M