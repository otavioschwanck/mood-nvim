if g:enable_tabs == 1
  nmap <silent> H :BufferPrevious<CR>
  nmap <silent> L :BufferNext<CR>

  nnoremap <silent> <C-s> :BufferPick<CR>

  nmap <leader>1 :BufferGoto 1<CR>
  nmap <leader>2 :BufferGoto 2<CR>
  nmap <leader>3 :BufferGoto 3<CR>
  nmap <leader>4 :BufferGoto 4<CR>
  nmap <leader>5 :BufferGoto 5<CR>
  nmap <leader>6 :BufferGoto 6<CR>
  nmap <leader>7 :BufferGoto 7<CR>
  nmap <leader>8 :BufferGoto 8<CR>
  nmap <leader>9 :BufferGoto 9<CR>

  lua << EOF
    local wk = require("which-key")
    wk.register({
      b = {
        name = "+Buffer",
        p = { ":silent BufferPrevious<CR>", "Previous" },
        n = { ":silent BufferNext<CR>", "Next" },
        N = { ":e ~/.nvim-scratch<CR>", "Open Scratch Buffer" },
        f = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
        F = { ":Telescope buffers<CR>", "Find all buffers" },
        C = { ":BufferCloseAllButCurrent<CR>", "Close All But Current" },
        c = { ":BufferCloseAllButPinned<CR>", "Close All But Pinned" },
        b = { ":BufferPin<CR>", "Pin Buffer" },
        s = { ":BufferOrderByLanguage<CR>", "Sort By Language" },
        S = { ":BufferOrderByDirectory<CR>", "Sort By Directory" },
      },
    }, { prefix = "<leader>", silent = false })
EOF
else
  set showtabline=0

  nmap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
  nmap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
  nmap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
  nmap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
  nmap <leader>5 :lua require("harpoon.ui").nav_file(5)<CR>
  nmap <leader>6 :lua require("harpoon.ui").nav_file(6)<CR>
  nmap <leader>7 :lua require("harpoon.ui").nav_file(7)<CR>
  nmap <leader>8 :lua require("harpoon.ui").nav_file(8)<CR>
  nmap <leader>9 :lua require("harpoon.ui").nav_file(9)<CR>

  call timer_start(200, {-> execute("BarbarDisable") })
  au BufEnter * set showtabline=0

  nmap <silent> H :lua require("harpoon.ui").nav_prev()<CR>
  nmap <silent> L :lua require("harpoon.ui").nav_next()<CR>

  lua << EOF
    local wk = require("which-key")
    wk.register({
      b = {
        name = "+Buffer",
        N = { ":e ~/.nvim-scratch<CR>", "Open Scratch Buffer" },
        f = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
        F = { ":Telescope buffers<CR>", "Find all buffers" },
        n = { ":lua require('harpoon.ui').nav_next()<CR>", "Next Harpoon" },
        p = { ":lua require('harpoon.ui').nav_prev()<CR>", "Prev Harpoon" }
      },
    }, { prefix = "<leader>", silent = false })
EOF
endif
