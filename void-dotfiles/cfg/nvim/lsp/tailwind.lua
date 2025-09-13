--          ╔═════════════════════════════════════════════════════════╗
--          ║                      TailwindCss LSP                    ║
--          ╚═════════════════════════════════════════════════════════╝
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    -- html
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    -- css
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    -- js
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    -- mixed
    "vue",
    "svelte",
    "templ",
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
        unusedClasses = "warning",
      },
      classAttributes = {
        'class',
        'className',
        "class:list",
        "classList",
        "ngClass",
      },
      includeLanguages = {
        typescriptreact = "javascript",
        javascriptreact = "javascript",
        html = "html",
        svelte = "html",
        vue = "html",
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html",
      },
      experimental = {
        classRegex = {
          "cn\\(([^)]*)\\)", "clsx\\(([^)]*)\\)",
          "cva\\(([^)]*)\\)", "twMerge\\(([^)]*)\\)",
        },
      },
    },
  },
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root_files = {
      -- Generic
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
      -- Django
      "theme/static_src/tailwind.config.js",
      "theme/static_src/tailwind.config.cjs",
      "theme/static_src/tailwind.config.mjs",
      "theme/static_src/tailwind.config.ts",
      "theme/static_src/postcss.config.js",
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Find root directory by searching upwards for any root file
    local root = vim.fs.find(root_files, { path = fname, upward = true })[1]

    if root then
      on_dir(vim.fs.dirname(root))
    else
      -- fallback, e.g. to git root or cwd
      on_dir(vim.fn.getcwd())
    end
  end,
}
