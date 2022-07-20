if g:epic_fisherman_mode == 1
  set showtabline=0

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
else
  nmap <silent> H :BufferPrevious<CR>
  nmap <silent> L :BufferNext<CR>

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
endif
