--          ╔═════════════════════════════════════════════════════════╗
--          ║                         Base                            ║
--          ╚═════════════════════════════════════════════════════════╝
local palette
if vim.o.background == 'light' then
  -- palette = {
  --   base00 = "#F1E3D1",
  --   base01 = "#DDCEBC",
  --   base02 = "#C9B9A7",
  --   base03 = "#B5A492",
  --   base04 = "#A0907D",
  --   base05 = "#64513E",
  --   base06 = "#786653",
  --   base07 = "#8C7B68",
  --   base08 = "#D09700",
  --   base09 = "#64513E",
  --   base0A = "#993333",
  --   base0B = "#908D6A",
  --   base0C = "#d09700",
  --   base0D = "#BF7979",
  --   base0E = "#9E5581",
  --   base0F = "#75858C",
  -- }
  -- palette = {
  --   base00 = "#EFECF4",
  --   base01 = "#E2DFE7",
  --   base02 = "#8B8792",
  --   base03 = "#7E7887",
  --   base04 = "#655F6D",
  --   base05 = "#585260",
  --   base06 = "#26232A",
  --   base07 = "#19171C",
  --   base08 = "#BE4678",
  --   base09 = "#AA573C",
  --   base0A = "#A06E3B",
  --   base0B = "#2A9292",
  --   base0C = "#398BC6",
  --   base0D = "#576DDB",
  --   base0E = "#955AE7",
  --   base0F = "#BF40BF",
  -- }
  -- charcoal_light
  palette = {
    base00 = '#d6b891',
    base01 = '#c0a179',
    base02 = '#a28662',
    base03 = '#887254',
    base04 = '#1e1812',
    base05 = '#35291d',
    base06 = '#413325',
    base07 = '#d6b891',
    base08 = '#413325',
    base09 = '#120f09',
    base0A = '#292016',
    base0B = '#120f09',
    base0C = '#413325',
    base0D = '#120f09',
    base0E = '#292016',
    base0F = '#66553f',
  }
end
if vim.o.background == 'dark' then
  -- Tokyo Night
  -- palette =  {
  --   base00 = "#1A1B26",
  --   base01 = "#3b4261",
  --   base02 = "#3b4261",
  --   base03 = "#545c7e",
  --   base04 = "#565c64",
  --   base05 = "#a9b1d6",
  --   base06 = "#bbc5f0",
  --   base07 = "#c0caf5",
  --   base08 = "#f7768e",
  --   base09 = "#ff9e64",
  --   base0A = "#e0af68",
  --   base0B = "#9ece6a",
  --   base0C = "#2ac3de",
  --   base0D = "#7aa2f7",
  --   base0E = "#9d7cd8",
  --   base0F = "#9abdf5"
  -- }
  -- Mountain
  -- palette =  {
  --   base00 = "#0f0f0f",
  --   base01 = "#151515",
  --   base02 = "#191919",
  --   base03 = "#323232",
  --   base04 = "#535353",
  --   base05 = "#f0f0f0",
  --   base06 = "#d8d8d8",
  --   base07 = "#414141",
  --   base08 = "#ac8a8c",
  --   base09 = "#d3d0ad",
  --   base0A = "#ACA98A",
  --   base0B = "#8aac8b",
  --   base0C = "#9EC3C4",
  --   base0D = "#8fb4b5",
  --   base0E = "#C49EC4",
  --   base0F = "#9d9a7b",
  -- }
  -- Jellybans
  -- palette = {
  --   base00 = "#151515",
  --   base01 = "#1c1c1c",
  --   base02 = "#404040",
  --   base03 = "#888888",
  --   base04 = "#ddddbf",
  --   base05 = "#e8e8d3",
  --   base06 = "#eeeede",
  --   base07 = "#f1f1e5",
  --   base08 = "#cf6a4c",
  --   base09 = "#d8ad4c",
  --   base0A = "#d8ad4c",
  --   base0B = "#99ad6a",
  --   base0C = "#71b9f8",
  --   base0D = "#597bc5",
  --   base0E = "#c6b6ee",
  --   base0F = "#d8ad4c",
  -- }
  -- Gruvbox
  -- palette = {
  --   base00 = "#1e2122",
  --   base01 = "#2c2f30",
  --   base02 = "#36393a",
  --   base03 = "#404344",
  --   base04 = "#d4be98",
  --   base05 = "#c0b196",
  --   base06 = "#c3b499",
  --   base07 = "#c7b89d",
  --   base08 = "#ec6b64",
  --   base09 = "#e78a4e",
  --   base0A = "#e0c080",
  --   base0B = "#a9b665",
  --   base0C = "#86b17f",
  --   base0D = "#7daea3",
  --   base0E = "#d3869b",
  --   base0F = "#d65d0e"
  -- }
  -- everforest
  -- palette = {
  --   base00 = "#2b3339",
  --   base01 = "#323c41",
  --   base02 = "#3a4248",
  --   base03 = "#868d80",
  --   base04 = "#d3c6aa",
  --   base05 = "#d3c6aa",
  --   base06 = "#e9e8d2",
  --   base07 = "#fff9e8",
  --   base08 = "#7fbbb3",
  --   base09 = "#d699b6",
  --   base0A = "#83c092",
  --   base0B = "#dbbc7f",
  --   base0C = "#e69875",
  --   base0D = "#a7c080",
  --   base0E = "#e67e80",
  --   base0F = "#d699b6"
  -- }
  -- aquarium
  -- palette = {
  --   base00 = "#20202A",
  --   base01 = "#2c2e3e",
  --   base02 = "#3D4059",
  --   base03 = "#313449",
  --   base04 = "#63718b",
  --   base05 = "#ced4df",
  --   base06 = "#414560",
  --   base07 = "#63718b",
  --   base08 = "#ebb9b9",
  --   base09 = "#e8cca7",
  --   base0A = "#e6dfb8",
  --   base0B = "#b1dba4",
  --   base0C = "#b8dceb",
  --   base0D = "#a3b8ef",
  --   base0E = "#f6bbe7",
  --   base0F = "#eAc1c1"
  -- }
  -- Kanagawa
  -- palette = {
  --   base00 = "#181616",
  --   base01 = "#1b1b1b",
  --   base02 = "#282828",
  --   base03 = "#5a524c",
  --   base04 = "#bdae93",
  --   base05 = "#ddc7a1",
  --   base06 = "#ebdbb2",
  --   base07 = "#fbf1c7",
  --   base08 = "#c4746e",
  --   base09 = "#e46876",
  --   base0A = "#c4b28a",
  --   base0B = "#8a9a7b",
  --   base0C = "#8ea4a2",
  --   base0D = "#8ba4b0",
  --   base0E = "#a292a3",
  --   base0F = "#7aa89f",
  -- }
  -- paradise
  -- palette = {
  --   base00 = "#151515",
  --   base01 = "#1F1F1F",
  --   base02 = "#2E2E2E",
  --   base03 = "#424242",
  --   base04 = "#BBB6B6",
  --   base05 = "#E8E3E3",
  --   base06 = "#E8E3E3",
  --   base07 = "#E8E3E3",
  --   base08 = "#B66467",
  --   base09 = "#D9BC8C",
  --   base0A = "#D9BC8C",
  --   base0B = "#8C977D",
  --   base0C = "#8AA6A2",
  --   base0D = "#8DA3B9",
  --   base0E = "#A988B0",
  --   base0F = "#BBB6B6",
  -- }
  -- custom 01
  -- palette = {
  --   base00 = "#1A1B26",
  --   base01 = "#16161E",
  --   base02 = "#2F3549",
  --   base03 = "#444B6A",
  --   base04 = "#787C99",
  --   base05 = "#A9B1D6",
  --   base06 = "#CBCCD1",
  --   base07 = "#D5D6DB",
  --   base08 = "#C0CAF5",
  --   base09 = "#A9B1D6",
  --   base0A = "#0DB9D7",
  --   base0B = "#9ECE6A",
  --   base0C = "#B4F9F8",
  --   base0D = "#2AC3DE",
  --   base0E = "#BB9AF7",
  --   base0F = "#F7768E",
  -- }
  --  One Dark
  -- palette = {
  --   base00 = "#282C34",
  --   base01 = "#353B45",
  --   base02 = "#3E4451",
  --   base03 = "#545862",
  --   base04 = "#565C64",
  --   base05 = "#ABB2BF",
  --   base06 = "#B6BDCA",
  --   base07 = "#C8CCD4",
  --   base08 = "#E06C75",
  --   base09 = "#D19A66",
  --   base0A = "#E5C07B",
  --   base0B = "#98C379",
  --   base0C = "#56B6C2",
  --   base0D = "#61AFEF",
  --   base0E = "#C678DD",
  --   base0F = "#BE5046",
  -- }
  -- everblush
  -- palette = {
  --   base00 = "#141b1e",
  --   base01 = "#1e2527",
  --   base02 = "#232a2d",
  --   base03 = "#404749",
  --   base04 = "#b3b9b8",
  --   base05 = "#cacaca",
  --   base06 = "#d2d2d2",
  --   base07 = "#dadada",
  --   base08 = "#e57474",
  --   base09 = "#e19d5c",
  --   base0A = "#e5c76b",
  --   base0B = "#8ccf7e",
  --   base0C = "#71baf2",
  --   base0D = "#67cbe7",
  --   base0E = "#c47fd5",
  --   base0F = "#ef7d7d",
  -- }
  -- charcoal_dark
  palette = {
    base00 = '#120f09',
    base01 = '#1e1812',
    base02 = '#35291d',
    base03 = '#66553f',
    base04 = '#a28662',
    base05 = '#c0a179',
    base06 = '#d6b891',
    base07 = '#292016',
    base08 = '#887254',
    base09 = '#d6b891',
    base0A = '#c0a179',
    base0B = '#927a60',
    base0C = '#a28662',
    base0D = '#d6b891',
    base0E = '#a28662',
    base0F = '#887254',
  }
end
if palette then
  require('mini.base16').setup({
    palette = palette,
    use_cterm = true,
    plugins = {
      default = false,
      ['echasnovski/mini.nvim'] = true,
    }
  })
  vim.g.colors_name = 'base'
end
-- General: ======================================================================================
vim.api.nvim_set_hl(0, 'SignColumn', { bg = palette.base00 })
vim.api.nvim_set_hl(0, 'Cursor', { fg = palette.base00, bg = palette.base0B })
vim.api.nvim_set_hl(0, 'LineNr', { fg = palette.base03, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'Search', { fg = palette.base07, bg = palette.base03 })
vim.api.nvim_set_hl(0, 'CurSearch', { fg = palette.base00, bg = palette.base0B })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = palette.base0B, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'CurSearch' })
vim.api.nvim_set_hl(0, 'FloatTitle', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'FloatBorder' })
-- Pmenu: ========================================================================================
vim.api.nvim_set_hl(0, 'Pmenu', { bg = palette.base00, fg = palette.base04, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = palette.base01, fg = palette.base04, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'PmenuMatch', { fg = palette.base0B, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'PmenuExtra', { bg = palette.base00, fg = palette.base04, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'PmenuMatchSel', { link = 'PmenuMatch' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { link = 'Pmenu' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { link = 'PmenuSel' })
vim.api.nvim_set_hl(0, 'PmenuKind', { link = 'PmenuExtra' })
vim.api.nvim_set_hl(0, 'PmenuExtraSel', { link = 'PmenuExtra' })
vim.api.nvim_set_hl(0, 'PmenuKindSel', { link = 'PmenuExtra' })
-- Tabline: ======================================================================================
vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = palette.base0B, bg = palette.base00, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = palette.base03, bg = palette.base00, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniTablineVisible', { link = 'MiniTablineCurrent' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { link = 'MiniTablineCurrent' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { link = 'MiniTablineCurrent' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { link = 'MiniTablineHidden' })
vim.api.nvim_set_hl(0, 'MiniTablineTabpagesSection', { link = 'MiniTablineCurrent' })
vim.api.nvim_set_hl(0, 'MiniTablineFill', { link = 'MiniTablineCurrent' })
-- Starter: ======================================================================================
vim.api.nvim_set_hl(0, 'MiniStarterHeader', { fg = palette.base0B, bg = palette.base00, bold = true, italic = true })
vim.api.nvim_set_hl(0, 'MiniStarterItem', { fg = palette.base07, bg = palette.base00, bold = true, italic = true })
vim.api.nvim_set_hl(0, 'MiniStarterItemPrefix', { link = 'MiniStarterHeader' })
vim.api.nvim_set_hl(0, 'MiniStarterQuery', { link = 'MiniStarterHeader' })
vim.api.nvim_set_hl(0, 'MiniStarterSection', { link = 'MiniStarterHeader' })
vim.api.nvim_set_hl(0, 'MiniStarterHeadeMiniStarterQueryr', { link = 'MiniStarterHeader' })
vim.api.nvim_set_hl(0, 'MiniStarterFooter', { link = 'MiniStarterHeader' })
-- Files: ========================================================================================
vim.api.nvim_set_hl(0, 'MiniFilesBorder', { fg = palette.base0B, bg = palette.base00, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'MiniFilesDirectory', { fg = palette.base04, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'MiniFilesNormal', { fg = palette.base04, bg = palette.base00, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'MiniFilesCursorLine', { bg = palette.base01, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniFilesBorderModified', { link = 'MiniFilesBorder' })
vim.api.nvim_set_hl(0, 'MiniFilesFile', { link = 'MiniFilesDirectory' })
vim.api.nvim_set_hl(0, 'MiniFilesTitle', { link = 'MiniFilesBorder' })
vim.api.nvim_set_hl(0, 'MiniFilesTitleFocused', { link = 'MiniFilesBorder' })
-- Picker: =======================================================================================
vim.api.nvim_set_hl(0, 'MiniPickBorder', { fg = palette.base0B, bg = palette.base00, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'MiniPickNormal', { fg = palette.base04, bg = palette.base00, bold = false, italic = false })
vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { bg = palette.base01, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniPickMatchMarked', { fg = palette.base0B, bg = palette.base00, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniPickPrompt', { fg = palette.base07, bg = palette.base00, bold = true, italic = false })
vim.api.nvim_set_hl(0, 'MiniPickMatchRanges', { link = 'MiniPickMatchMarked' })
vim.api.nvim_set_hl(0, 'MiniPickPreviewRegion', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickPreviewLine', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickBorderBusy', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickBorderText', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickIconDirectory', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickIconFile', { link = 'MiniPickBorder' })
vim.api.nvim_set_hl(0, 'MiniPickHeader', { link = 'MiniPickBorder' })
-- Snippets ======================================================================================
vim.api.nvim_set_hl(0, 'MiniSnippetsCurrent', { fg = palette.base0B })
vim.api.nvim_set_hl(0, 'MiniSnippetsCurrentReplace', { link = 'MiniSnippetsCurrent' })
vim.api.nvim_set_hl(0, 'MiniSnippetsFinal', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'MiniSnippetsUnvisited', { link = 'MiniSnippetsCurrent' })
vim.api.nvim_set_hl(0, 'MiniSnippetsVisited', { link = 'MiniSnippetsCurrent' })
-- Notify ========================================================================================
vim.api.nvim_set_hl(0, 'MiniNotifyBorder', { fg = palette.base0B, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'MiniNotifyNormal', { fg = palette.base04, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'MiniNotifyLspProgress', { link = 'MiniNotifyNormal' })
vim.api.nvim_set_hl(0, 'MiniNotifyTitle', { link = 'MiniNotifyBorder' })
-- Diff ==========================================================================================
vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = palette.base0B, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = palette.base0C, bg = palette.base00 })
vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = palette.base08, bg = palette.base00 })
-- Completions: =================================================================================
vim.api.nvim_set_hl(0, 'MiniCompletionActiveParameter', { fg = palette.base04, bg = palette.base01 })
vim.api.nvim_set_hl(0, 'MiniCompletionInfoBorderOutdated', { link = 'MiniCompletionActiveParameter' })
