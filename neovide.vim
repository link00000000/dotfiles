let s:neovide_persist_fullscreen_file = GetDataDir() . '/neovide-fullscreen.txt'
let s:neovide_extended_settings_file_path = GetDataDir() . '/neovide-settings-extended.json'
let s:neovide_persist_restart_session_file = GetDataDir() . '/neovide-restart-session.vim'

function! s:ReadNeovideSettings()
    if !filereadable(s:neovide_extended_settings_file_path)
        return {}
    else
        let l:buffer = readfile(s:neovide_extended_settings_file_path)
        return json_decode(l:buffer)
    endif
endfunction

function! s:WriteNeovideSettings(obj)
    let l:buffer = json_encode(a:obj)
    call writefile([l:buffer], s:neovide_extended_settings_file_path)
endfunction

function! s:ToggleFullscreen()
    let g:neovide_fullscreen = !g:neovide_fullscreen

    let l:neovide_settings = s:ReadNeovideSettings()
    let l:neovide_settings.fullscreen = g:neovide_fullscreen
    call s:WriteNeovideSettings(l:neovide_settings)
endfunction

function! s:Restart()
    execute 'mksession! ' . s:neovide_persist_restart_session_file
    call system('neovide -- -S ' . s:neovide_persist_restart_session_file)
    execute 'qa!'
endfunction

function! s:Scale(delta)
    echo a:delta
    let g:neovide_scale_factor = g:neovide_scale_factor + a:delta
endfunction

" Read fullscreen state from extended settings
let s:neovide_extended_settings = s:ReadNeovideSettings()
if has_key(s:neovide_extended_settings, 'fullscreen')
    if type(s:neovide_extended_settings.fullscreen) != type(v:t_number)
        echo "Error reading key 'fullscreen' from neovide-settings.json. 'fullscreen' not set to a boolean value."
    else
        let g:neovide_fullscreen = s:neovide_extended_settings.fullscreen
    endif
endif

" Toggle fullscreen command
command! -nargs=0 NeovideToggleFullscreen :call s:ToggleFullscreen()
nmap <silent> <F11> :NeovideToggleFullscreen<CR>

" Restart command
command! -nargs=0 Restart :call s:Restart()

" Scale command
command! -nargs=1 Scale :call s:Scale(<f-args>)
nmap <C-=> :Scale(0.05)
nmap <C--> :Scale(-0.05)

" Set font
" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/CascadiaCode.zip
set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h12

let g:neovide_remember_window_size = v:true

" Scoll animations
let g:neovide_scroll_animation_length = 0

" Cursor animations
let g:neovide_cursor_animation_length = 0
let g:neovide_cursor_vfx_mode = "" " Possible values: "", "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"
let g:neovide_cursor_antialiasing = v:false
