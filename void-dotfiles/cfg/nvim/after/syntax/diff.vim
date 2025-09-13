"""         ╔═════════════════════════════════════════════════════════╗
"""         ║  Extend syntax to include additional diff files         ║
"""         ╚═════════════════════════════════════════════════════════╝
let s:char = (getline('$')->matchstr('^[#;@!$%^&|:]\S\@!') ?? '#')->escape('^$.*[]~\"/')
execute $'syn match diffComment "^{s:char}.*$"'
