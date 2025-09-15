#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Load                           ║
#               ╚═════════════════════════════════════════════════════════╝
config.load_autoconfig(False)
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Backend                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.backend = 'webengine'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Fonts                          ║
#               ╚═════════════════════════════════════════════════════════╝
# UI ==================================================================================
c.fonts.default_size = '13px'
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.completion.entry = 'default_size default_family'
c.fonts.completion.category = 'bold default_size default_family'
c.fonts.debug_console = 'bold default_size default_family'
c.fonts.contextmenu = 'bold default_size default_family'
c.fonts.prompts = 'bold default_size default_family'
c.fonts.downloads = 'bold default_size default_family'
c.fonts.hints = 'bold default_size default_family'
c.fonts.keyhint = 'bold default_size default_family'
c.fonts.statusbar = 'bold default_size default_family'
c.fonts.tooltip = 'bold default_size default_family'
c.fonts.tabs.selected = "bold default_size default_family"
c.fonts.tabs.unselected = "bold default_size default_family"
c.fonts.messages.error = "bold default_size default_family"
c.fonts.messages.info = "bold default_size default_family"
c.fonts.messages.warning = "bold default_size default_family"
# Web =================================================================================
c.fonts.web.family.fixed = 'JetBrainsMono Nerd Font'
c.fonts.web.family.serif = 'Times New Roman'
c.fonts.web.family.sans_serif = 'Arial'
c.fonts.web.family.standard = 'Arial'
c.fonts.web.family.fantasy = 'Arial'
c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 14
c.fonts.web.size.minimum = 4
c.fonts.web.size.minimum_logical = 6
#               ╔═════════════════════════════════════════════════════════╗
#               ║                             Tabs                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.tabs.wrap = True
c.tabs.background = True
c.tabs.pinned.shrink = True
c.tabs.pinned.frozen = True
c.tabs.new_position.stacking = True
c.tabs.tooltips = True
c.tabs.tabs_are_windows = False
c.tabs.mousewheel_switching = False
c.tabs.favicons.scale = 1.3
c.tabs.undo_stack_size = 10
c.tabs.show_switching_delay = 5000
c.tabs.width = 28
c.tabs.max_width = -1
c.tabs.min_width = -1
c.tabs.indicator.width = 0
c.tabs.indicator.padding = {'top': 0, 'bottom': 0, 'left': 0, 'right': 0}
c.tabs.padding = {"top": 8, "bottom": 8, "left": 4, "right": 4}
c.tabs.position = "left"
c.tabs.show = "switching"
c.tabs.mode_on_change = 'normal'
c.tabs.favicons.show = "always"
c.tabs.last_close = "default-page"
c.tabs.close_mouse_button = 'middle'
c.tabs.close_mouse_button_on_bar = 'new-tab'
c.tabs.select_on_remove = 'prev'
c.tabs.title.alignment = 'center'
c.tabs.title.elide = 'middle'
c.tabs.title.format = '{audio}{current_title}'
c.tabs.title.format_pinned = '#{audio}{index}: {current_title}'
c.tabs.new_position.related = 'next'
c.tabs.new_position.unrelated = 'last'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Statusbar                       ║
#               ╚═════════════════════════════════════════════════════════╝
c.statusbar.show = 'in-mode'
c.statusbar.position = 'bottom'
c.statusbar.padding = {'top': 1, 'bottom': 1, 'left': 1, 'right': 1}
c.statusbar.widgets = ['keypress', 'search_match', 'url']
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Downloads                       ║
#               ╚═════════════════════════════════════════════════════════╝
c.downloads.prevent_mixed_content = True
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.downloads.remove_finished = 5000
c.downloads.location.directory = "/home/lli/Downloads"
c.downloads.location.suggestion = "both"
c.downloads.position = 'bottom'
c.downloads.open_dispatcher = None
#               ╔═════════════════════════════════════════════════════════╗
#               ║                       Completion                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.completion.quick = True
c.completion.shrink = True
c.completion.use_best_match = True
c.completion.cmd_history_max_items = 0
c.completion.web_history.max_items = 0
c.completion.delay = 0
c.completion.scrollbar.padding = 0
c.completion.scrollbar.width = 4
c.completion.min_chars = 1
c.completion.height = "20%"
c.completion.show = "always"
c.completion.timestamp_format = '%Y-%m-%d'
c.completion.favorite_paths = []
c.completion.open_categories = ['quickmarks']
c.completion.web_history.exclude = ['file://*', 'http://localhost:*', 'https://*.google.com', 'https://duckduckgo.com']
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Input                          ║
#               ╚═════════════════════════════════════════════════════════╝
c.input.match_counts = True
c.input.escape_quits_reporter = True
c.input.mouse.back_forward_buttons = True
c.input.media_keys = True
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.leave_on_load = True
c.input.insert_mode.auto_load = True
c.input.insert_mode.plugins = False
c.input.links_included_in_focus_chain = False
c.input.mouse.rocker_gestures = False
c.input.spatial_navigation = False
c.input.partial_timeout = 30000
c.input.forward_unbound_keys = 'all'
c.input.mode_override = None
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Search                          ║
#               ╚═════════════════════════════════════════════════════════╝
c.search.incremental = True
c.search.wrap = True
c.search.wrap_messages = False
c.search.ignore_case = "smart"
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Keyhint                         ║
#               ╚═════════════════════════════════════════════════════════╝
c.keyhint.delay = 300
c.keyhint.radius = 2
c.keyhint.blacklist = []
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Hints                           ║
#               ╚═════════════════════════════════════════════════════════╝
c.hints.scatter = True
c.hints.hide_unmatched_rapid_hints = True
c.hints.uppercase = True
c.hints.leave_on_load = False
c.hints.min_chars = 1
c.hints.radius = 2
c.hints.auto_follow_timeout = 0
c.hints.auto_follow = 'unique-match'
c.hints.mode = "letter"
c.hints.chars = "asdfghjkl"
c.hints.dictionary = r"C:\Users\lli\AppData\Roaming\qutebrowser\config\misc\dict\english.txt"
c.hints.next_regexes = ['\\bnext\\b', '\\bmore\\b', '\\bnewer\\b', '\\b[>→≫]\\b', '\\b(>>|»)\\b', '\\bcontinue\\b']
c.hints.prev_regexes = ['\\bprev(ious)?\\b', '\\bback\\b', '\\bolder\\b', '\\b[<←≪]\\b', '\\b(<<|«)\\b']
c.hints.padding =  {"top": 2, "bottom": 2, "left": 2, "right": 2}
c.hints.selectors = {
    "all": [
       "a",
       "area",
       "textarea",
       "select",
       'input:not([type="hidden"])',
       "button",
       "frame",
       "iframe",
       "img",
       "link",
       "summary",
       '[contenteditable]:not([contenteditable="false"])',
       "[onclick]",
       "[onmousedown]",
       '[role="link"]',
       '[role="option"]',
       '[role="button"]',
       '[role="tab"]',
       '[role="checkbox"]',
       '[role="switch"]',
       '[role="menuitem"]',
       '[role="menuitemcheckbox"]',
       '[role="menuitemradio"]',
       '[role="treeitem"]',
       "[aria-haspopup]",
       "[ng-click]",
       "[ngClick]",
       "[data-ng-click]",
       "[x-ng-click]",
       '[tabindex]:not([tabindex="-1"])',
    ],
    "links": ["a[href]", "area[href]", "link[href]", '[role="link"][href]'],
    "images": ["img"],
    "media": ["audio", "img", "video"],
    "url": ["[src]", "[href]"],
    "inputs": [
         'input[type="text"]',
         'input[type="date"]',
         'input[type="datetime-local"]',
         'input[type="email"]',
         'input[type="month"]',
         'input[type="number"]',
         'input[type="password"]',
         'input[type="search"]',
         'input[type="tel"]',
         'input[type="time"]',
         'input[type="url"]',
         'input[type="week"]',
         "input:not([type])",
         '[contenteditable]:not([contenteditable="false"])',
         "textarea",
    ],
}
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Content                        ║
#               ╚═════════════════════════════════════════════════════════╝
# Style ===============================================================================
c.content.prefers_reduced_motion = False
c.content.fullscreen.overlay_timeout = 5000
c.content.user_stylesheets = []
# Adblock =============================================================================
c.content.blocking.enabled = True
c.content.blocking.hosts.block_subdomains = True
c.content.blocking.method = "both"
c.content.blocking.whitelist = ['https://*.split.io/*']
c.content.blocking.hosts.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']
c.content.blocking.adblock.lists = [
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt",
    "https://easylist-downloads.adblockplus.org/bitblock.txt",
    "https://easylist-downloads.adblockplus.org/cntblock.txt",
    "https://easylist-downloads.adblockplus.org/ruadlist.txt",
    "https://easylist-msie.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-msie.adblockplus.org/antiadblockfilters.txt",
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_adservers.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_adservers_popup.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_general_block.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_general_block_popup.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_thirdparty.txt",
    "https://github.com/easylist/easylist/raw/refs/heads/master/easylist/easylist_thirdparty_popup.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://raw.github.com/reek/anti-adblock-killer/master/anti-adblock-killer-filters.txt",
    "https://raw.githubusercontent.com/LanikSJ/ubo-filters/main/filters/combined-filters.txt",
    "https://raw.githubusercontent.com/easylist/ruadlist/refs/heads/master/advblock.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/annoyances-cookies.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/annoyances-others.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/badlists.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2020.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2021.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2022.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2023.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2024.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters-2025.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/quick-fixes.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/resource-abuse.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/ubo-link-shorteners.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/ubol-filters.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/",
]
# media ===============================================================================
c.content.webgl = True
c.content.images = True
c.content.pdfjs = True
c.content.canvas_reading = True
c.content.print_element_backgrounds = True
c.content.autoplay = False
c.content.mute = False
# Privacy =============================================================================
c.content.private_browsing = True
c.content.dns_prefetch = True
c.content.fullscreen.window = True
c.content.site_specific_quirks.enabled = True
c.content.site_specific_quirks.skip = []
c.content.xss_auditing = False
c.content.geolocation = False
c.content.plugins = False
c.content.media.audio_capture = False
c.content.media.audio_video_capture = False
c.content.media.video_capture = False
c.content.desktop_capture = False
c.content.mouse_lock = False
c.content.register_protocol_handler = False
c.content.hyperlink_auditing = False
c.content.persistent_storage = "ask"
c.content.proxy = 'system'
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.default_encoding = "utf-8"
c.content.tls.certificate_errors = 'ask-block-thirdparty'
c.content.unknown_url_scheme_policy = 'allow-from-user-interaction'
c.content.netrc_file = None
# headers =============================================================================
c.content.headers.do_not_track = True
c.content.headers.accept_language = 'en-US,en;q=0.9'
c.content.headers.referer = 'same-domain'
c.content.headers.user_agent = 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version_short} Safari/{webkit_version}'
c.content.headers.custom = {}
# Notifications =======================================================================
c.content.notifications.enabled = False
c.content.notifications.show_origin = True
c.content.notifications.presenter = 'auto'
# Cookies =============================================================================
c.content.cookies.store = True
c.content.cookies.accept = "no-3rdparty"
# Javascript ==========================================================================
c.content.javascript.enabled = True
c.content.javascript.alert = True
c.content.javascript.prompt = True
c.content.javascript.modal_dialog = False
c.content.javascript.can_open_tabs_automatically = False
c.content.local_content_can_access_remote_urls = False
c.content.local_content_can_access_file_urls = True
c.content.local_storage = True
c.content.javascript.legacy_touch_events = 'never'
c.content.javascript.clipboard = 'access'
c.content.javascript.log = {'unknown': 'debug', 'info': 'debug', 'warning': 'debug', 'error': 'debug'}
c.content.javascript.log_message.excludes = {'userscript:_qute_stylesheet': ['*Refused to apply inline style because it violates the following Content Security Policy directive: *']}
c.content.javascript.log_message.levels = {'qute:*': ['error'], 'userscript:GM-*': [], 'userscript:*': ['error']}
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          PerSite                        ║
#               ╚═════════════════════════════════════════════════════════╝
# Permission ==========================================================================
with config.pattern("meet.google.com") as p:
    p.content.notifications.enabled = True
    p.content.media.audio_video_capture = True
    p.content.media.audio_capture = True
    p.content.media.video_capture = True
    p.content.desktop_capture = True
with config.pattern("*://*.discord.com") as dc:
    dc.content.autoplay = True
    dc.content.desktop_capture = True
    dc.content.media.audio_capture = True
    dc.content.media.audio_video_capture = True
    dc.content.media.video_capture = True
with config.pattern("*://*.element.io") as el:
    el.content.autoplay = True
    el.content.desktop_capture = True
    el.content.media.audio_capture = True
    el.content.media.audio_video_capture = True
    el.content.media.video_capture = True
    el.content.notifications.enabled = True
    el.content.media.audio_capture = True
with config.pattern("*://mail.proton.me") as pm:
    pm.content.register_protocol_handler = True
    pm.content.notifications.enabled = True
with config.pattern("*://mail.google.com") as gm:
    gm.content.register_protocol_handler = False
    gm.content.notifications.enabled = False
with config.pattern("*://outlook.office.com") as outl:
    outl.content.register_protocol_handler = False
    outl.content.notifications.enabled = False
with config.pattern("*://*.aternos.org") as aternos:
    aternos.content.notifications.enabled = True
# InDevtools ==========================================================================
for tool in ['devtools', 'chrome-devtools', 'chrome', 'qute']:
    with config.pattern(tool + '://*') as t:
        t.content.cookies.accept = 'all'
        t.content.images = True
        t.content.javascript.enabled = True
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Window                         ║
#               ╚═════════════════════════════════════════════════════════╝
c.window.hide_decoration = True
c.window.transparent = False
c.window.title_format = 'qtb - {perc} {current_title} {title_sep}'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Zoom                           ║
#               ╚═════════════════════════════════════════════════════════╝
c.zoom.mouse_divider = 512
c.zoom.default = "100%"
c.zoom.levels = ['25%', '33%', '50%', '67%', '75%', '80%', '90%', '100%', '110%', '125%', '150%', '175%', '200%', '250%', '300%', '400%', '500%']
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Session                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.auto_save.session = True
c.session.lazy_restore = True
c.auto_save.interval = 50000
c.session.default_name = "default"
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          FileSelect                     ║
#               ╚═════════════════════════════════════════════════════════╝
c.fileselect.handler = 'default'
c.fileselect.folder.command = ["alacritty", "-e", "bash", '-c', "yazi", "--choosedir={}"]
c.fileselect.multiple_files.command = ["alacritty", "-e", "bash", '-c', "yazi", "--choosefiles={}"]
c.fileselect.single_file.command = ["alacritty", "-e", "bash", '-c', "yazi", "--choosefile={}"]
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Instance                       ║
#               ╚═════════════════════════════════════════════════════════╝
c.new_instance_open_target = "tab"
c.new_instance_open_target_window = "last-focused"
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Prompt                          ║
#               ╚═════════════════════════════════════════════════════════╝
c.prompt.filebrowser = True
c.prompt.radius = 2
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Logging                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.logging.level.console = 'info'
c.logging.level.ram = 'debug'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                        Messages                         ║
#               ╚═════════════════════════════════════════════════════════╝
c.messages.timeout = 5000
#               ╔═════════════════════════════════════════════════════════╗
#               ║                        Spellcheck                       ║
#               ╚═════════════════════════════════════════════════════════╝
# c.spellcheck.languages = ["en-US"]
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Editor                         ║
#               ╚═════════════════════════════════════════════════════════╝
c.editor.remove_file = True
c.editor.command = ["alacritty", "-e", "nvim", "{file}"]
c.editor.encoding = 'utf-8'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Scrolling                      ║
#               ╚═════════════════════════════════════════════════════════╝
c.scrolling.smooth = True
c.scrolling.bar = 'never'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Others                         ║
#               ╚═════════════════════════════════════════════════════════╝
c.history_gap_interval = 30
c.confirm_quit=["downloads"]
c.changelog_after_upgrade = 'major'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Qt                              ║
#               ╚═════════════════════════════════════════════════════════╝
c.qt.workarounds.disable_hangouts_extension = True
c.qt.workarounds.remove_service_workers = False
c.qt.workarounds.locale = False
c.qt.highdpi = False
c.qt.force_software_rendering = 'none'
c.qt.workarounds.disable_accelerated_2d_canvas = 'never'
c.qt.chromium.experimental_web_platform_features = 'never'
c.qt.chromium.low_end_device_mode = 'never'
c.qt.chromium.process_model = 'process-per-site-instance'
c.qt.chromium.sandboxing = 'enable-all'
c.qt.environ = {}
c.qt.args = [
    "enable-accelerated-video-decode"
    "enable-accelerated-video",
    "enable-gpu-rasterization",
    "enable-native-gpu-memory-buffers",
    "enable-oop-rasterization",
    "enable-quic",
    "enable-unsafe-webgpu",
    "enable-zero-copy",
    "enable-vulkan",
    'use-vulkan=native',
    "font-cache-shared-handle",
    "ignore-gpu-blocklist",
    "num-raster-threads=4",
    "disable-logging",
    "disable-pinch",
    "disable-features=PermissionElement",
]
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          URL                            ║
#               ╚═════════════════════════════════════════════════════════╝
c.url.open_base_url = True
c.url.auto_search = 'naive'
c.url.default_page = '/home/lli/.config/qutebrowser/startpage/index.html'
c.url.start_pages = [ '/home/lli/.config/qutebrowser/startpage/index.html' ]
c.url.yank_ignored_parameters += ['smid', 'smtyp', 'fbclid', 'fb_news_token']
c.url.incdec_segments = ['path', 'query']
c.url.searchengines = {
    # search engines ==================================================================
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'dd': 'https://duckduckgo.com/?q={}',
    'gg': 'https://www.google.com/search?q={}',
    'gi': 'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    'gn': 'https://news.google.com/search?q={}',
    'bi': 'https://www.bing.com/search?q={}',
    'yi': 'https://yandex.com/search/?text={}',
    'sw': 'https://swisscows.com/web?culture=en&query={}',
    'yy': 'https://www.youtube.com/results?search_query={}&search=Search',
    'yt': 'https://www.youtube.com/results?search_query={}&search=Search',
    'wi': 'https://en.wikipedia.org/wiki/{}',
    'mp': 'https://www.google.com/maps/search/{}',
    # translate =======================================================================
    'ar': 'https://translate.google.com/?sl=auto&tl=ar&text={}&op=translate',
    'tr': 'https://translate.google.com/?sl=auto&tl=en&text={}&op=translate',
    'en': 'https://translate.google.com/?sl=auto&tl=en&text={}&op=translate',
    'ro': 'https://translate.google.com/?sl=auto&tl=ro&text={}&op=translate',
    'ru': 'https://translate.google.com/?sl=auto&tl=ru&text={}&op=translate',
    'ja': 'https://translate.google.com/?sl=auto&tl=ja&text={}&op=translate',
    # entertainment ===================================================================
    're': 'https://www.reddit.com/r/{}/',
    'rr': 'https://www.reddit.com/r/{unquoted}',
    'rs': 'https://www.reddit.com/search?q={}',
    'ro': 'https://old.reddit.com/search?q={}',
    'pi': 'https://www.pinterest.com/search/pins/?q={}',
    'fb': 'https://www.facebook.com/s.php?q={}',
    'ig': 'https://www.instagram.com/explore/tags/{}',
    'tw': 'https://twitter.com/search?q={}',
    # dev =============================================================================
	"ld": "https://devdocs.io#q={}",
	"lp": "https://devdocs.io#q=python {}",
	"ll": "https://devdocs.io#q=lua {}",
	"lr": "https://devdocs.io#q=rust {}",
    # tech ============================================================================
	"ph": "https://phind.com/search?q={}",
	"so": "https://stackoverflow.com/search?q={}",
	"sg": "https://sourcegraph.com/search?q=context:global+{}&patternType=standard&sm=1",
    'gh': 'https://github.com/search?o=desc&q={}&s=stars',
    'gu': 'https://github.com/search?q={}&type=Users',
    'gc': 'https://github.com/search?q={}&type=Code',
    'gs': 'https://gist.github.com/search?q={}',
    'hb': 'http://github.com/search?q={}',
    'gl': 'https://gitlab.com/search?search={}&group_id=&project_id=&snippets=false&repository_ref=&nav_source=navbar',
    'pk': 'https://porkbun.com/checkout/search?prb=ce1274dcf2&q={}&tlds=&idnLanguage=&search=search&csrf_pb=e78192c1c41609bac923887d0a45b5ec',
    'rp': 'http://github.com/catalinplesu/{}',
    'wolframalpha': 'http://www.wolframalpha.com/input/?i={}',
    # streaming =======================================================================
	"in": "https://inv.nadeko.net/search?q={}",
    'nf': "https://www.netflix.com/search?q={}",
    'sp': "https://open.spotify.com/search/{}",
    'an': 'https://ww.anime4up.rest/?search_param=animes&s={}',
    "ai": "anilist.co/search/anime?search={}",
    'db': 'https://www.imdb.com/find?q={}',
    'zo': 'https://zoro.to/search?keyword={}',
    'to': 'https://www.1377x.to/search/{}/1/',
    'pt': 'https://thepiratebay.org/search.php?q={}',
    # Packages ========================================================================
    "sc": "https://scoop.sh/#/apps?q={}",
    "vo": "https://voidlinux.org/packages/?arch=x86_64&q={}",
    # books ===========================================================================
    'bl': 'https://libgen.rs/search.php?req={}',
    'ba': 'https://annas-archive.org/search?q=%{}',
    # language ========================================================================
    'du': 'https://www.urbandictionary.com/define.php?term={}',
    'dt': 'https://thefreedictionary.com/{}',
    'da': 'https://www.merriam-webster.com/dictionary/%{}',
    'de': 'https://www.merriam-webster.com/thesaurus/%{}',
    'dh': 'https://www.thesaurus.com/browse/{}',
    'dx': 'https://dexonline.ro/definitie/{}',
    # buy =============================================================================
    'jo': 'https://www.joom.com/en/search/q.{}',
    'al': "https://aliexpress.ru/wholesale?SearchText={}&g=y&page=1",
    'az': 'https://www.amazon.com/s?k={}',
    'av': "https://www.avito.ru/sankt-peterburg?q={}",
    'tm': 'https://www.temu.com/search_result.html?search_key={}',
    # others ==========================================================================
    'up': "https://www.reddit.com/r/unixporn/search?q={}&restrict_sr=on",
}
#               ╔═════════════════════════════════════════════════════════╗
#               ║                          Aliases                        ║
#               ╚═════════════════════════════════════════════════════════╝
c.aliases['o'] = 'open'
c.aliases['h'] = 'help -t'
c.aliases['e'] = 'session-load'
c.aliases['w'] = 'session-save'
c.aliases['wc'] = 'session-save --current --only-active-window'
c.aliases['bd'] = 'tab-close'
c.aliases['bo'] = 'tab-only'
c.aliases['wq'] = 'quit --save'
c.aliases['wq!'] = 'quit --save'
c.aliases['wqa'] = 'quit --save'
c.aliases['mpv'] = 'spawn --detach mpv {url}'
c.aliases['tor'] = 'spawn --detach tor-browser {url}'
c.aliases['ff'] = 'spawn --detach firefox {url}'
c.aliases['ed'] = 'spawn --detach msedge {url}'
c.aliases['ch'] = 'spawn --detach chromium {url}'
#               ╔═════════════════════════════════════════════════════════╗
#               ║                       Keybidings                        ║
#               ╚═════════════════════════════════════════════════════════╝
# Remap ===============================================================================
c.bindings.key_mappings = {
    '<Enter>': '<Return>',
    '<Shift-Return>': '<Return>',
    '<Shift-Enter>': '<Return>',
    '<Ctrl-Enter>': '<Ctrl-Return>'
}
# Unbind ==============================================================================
unbind_keys = ['d', 'q', 'r', 'm', 'M', '<Ctrl-v>']
for key in unbind_keys:
    config.unbind(key)
# General  ============================================================================
config.bind("u", "undo")
config.bind("U", "undo -w")
config.bind('rr', 'reload')
config.bind("sm", "messages")
config.bind('qm', 'macro-record')
config.bind('yl', 'hint --rapid links yank')
config.bind("ya", "mode-enter caret;;selection-toggle;;move-to-end-of-document;;yank selection;;mode-leave")
config.bind('<Esc>', 'clear-keychain ;; search ;; fullscreen --leave ;; clear-messages')
config.bind('<Ctrl-v>', 'hint inputs --first ;; cmd-later 10 insert-text -- {clipboard}')
config.bind('<Ctrl-o>', 'cmd-set-text -s :open -w')
config.bind('<Ctrl-x>', 'cmd-set-text :')
config.bind("'", "mode-enter jump_mark")
config.bind(';', 'cmd-set-text :')
# [Boo-Qui]kmark  ============================================================================
config.bind("a", "cmd-set-text -s :quickmark-add {url}")
config.bind("A", "cmd-set-text -s :bookmark-add {url}")
config.bind("b", "cmd-set-text -s :quickmark-load -t")
config.bind("B", "cmd-set-text -s :bookmark-load -t")
# scrolling ==========================================================================
config.bind('<Ctrl-h>', 'cmd-run-with-count 20 scroll left')
config.bind('<Ctrl-j>', 'cmd-run-with-count 20 scroll down')
config.bind('<Ctrl-k>', 'cmd-run-with-count 20 scroll up')
config.bind('<Ctrl-l>', 'cmd-run-with-count 20 scroll right')
# Devtools ============================================================================
config.bind('wi', 'devtools bottom')
config.bind('wI', 'devtools window')
config.bind('<Ctrl-i>', 'devtools left')
config.bind('<Ctrl-Shift-i>', 'devtools right')
# Tabs  ===============================================================================
config.bind('T', 'hint links tab')
config.bind('dd', 'tab-close')
config.bind('do', 'tab-only')
config.bind('dh', 'tab-focus 1')
config.bind('dl', 'tab-focus last')
config.bind('dp', 'tab-pin')
config.bind('dm', 'tab-mute')
config.bind('dc', 'tab-clone')
config.bind('dn', 'tab-focus last')
config.bind('dn', 'tab-only ;; home')
config.bind('ds', 'cmd-set-text --space :tab-select')
config.bind('dJ', 'tab-move +')
config.bind('dK', 'tab-move -')
config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('gm', 'tab-move')
config.bind('<Ctrl-n>', 'tab-next')
config.bind('<Ctrl-p>', 'tab-prev')
config.bind('<Ctrl-q>', 'tab-close')
config.bind("<Ctrl-m>", "tab-mute")
config.bind("<Ctrl-PgDown>", "tab-next")
config.bind("<Ctrl-PgUp>", "tab-prev")
config.bind("<Ctrl-Tab>", "tab-focus last")
# Open ================================================================================
config.bind('ee', 'cmd-set-text :open {url:pretty}')
config.bind('ev', 'edit-url')
config.bind('ep', 'open -p')
config.bind('ew', 'open -w')
config.bind('et', 'open -t')
config.bind('ec', "spawn chromium {url}")
config.bind('ef', "spawn firefox {url}")
config.bind('ei', "spawn msedge {url}")
config.bind('<Ctrl-e>', 'open -w')
config.bind('<Ctrl-t>', 'open -t ;; cmd-set-text -s :open')
# Zoom  ===============================================================================
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind("zz", "zoom")
config.bind('z0', 'zoom')
config.bind('zf', 'fullscreen')
config.bind('<Ctrl-0>', 'zoom')
config.bind('<Ctrl-=>', 'zoom-in')
config.bind('<Ctrl-->', 'zoom-out')
# Downloads  ==========================================================================
config.bind('co', 'download-open')
config.bind('ce', 'download-cancel')
config.bind('cc', 'download-clear')
config.bind('cr', 'download-retry')
config.bind('ca', 'hint all download')
config.bind('ci', 'hint images download')
# Configuration =======================================================================
config.bind("se", "config-edit")
config.bind("sv", "config-edit")
config.bind("ss", "config-source")
config.bind("sa", "adblock-update")
config.bind("sr", "greasemonkey-reload")
# Videos  =============================================================================
config.bind('rvv', 'hint links spawn mpv {hint-url}')
config.bind('rvm', 'spawn mpv {url}')
config.bind('rvd', 'hint links spawn alacritty -e yt-dlp {hint-url}')
# images ==============================================================================
config.bind('rii', 'hint images run open {hint-url}')
config.bind('rit', 'hint images run open -t {hint-url}')
config.bind('rio', 'hint images')
config.bind('riy', 'hint images yank')
config.bind('riY', 'hint images yank-primary')
config.bind('rig', 'hint images run open https://www.google.com/searchbyimage?&image_url={hint-url}')
# Screenshot ==========================================================================
config.bind("rss", "cmd-set-text -s :screenshot --force")
# Print ===============================================================================
config.bind("rpp", "print")
# Sessions ============================================================================
config.bind("Ss", "session-save")
config.bind("Sl", "session-load default")
# private =============================================================================
config.bind('rap', 'hint all run open -p {hint-url}')
# messages  =============================================================================
# Toggle ==============================================================================
config.bind("tdt", "config-cycle colors.webpage.darkmode.enabled false true")
config.bind("ttt", "config-cycle tabs.show multiple switching")
config.bind('ttp', 'config-cycle tabs.position top left')
config.bind("tst", "config-cycle statusbar.show always in-mode")
config.bind("tbh", "config-cycle -p -t -u *://{url:host}/* content.blocking.enabled true false ;; reload")
config.bind("tBh", "config-cycle -p -u *://{url:host}/* content.blocking.enabled true false ;; reload")
config.bind("tbH", "config-cycle -p -t -u *://*.{url:host}/* content.blocking.enabled true false ;; reload")
config.bind("tBH", "config-cycle -p -u *://*.{url:host}/* content.blocking.enabled true false ;; reload")
config.bind("tbu", "config-cycle -p -t -u {url} content.blocking.enabled true false ;; reload")
config.bind("tBu", "config-cycle -p -u {url} content.blocking.enabled true false ;; reload")
# Stylesheets =========================================================================
config.bind(',c', 'config-cycle content.user_stylesheets "" ""')
config.bind(',r', 'config-cycle content.user_stylesheets "~/.config/qutebrowser/styles/nord-all-sites.css" "~/.config/qutebrowser/styles/solarized-dark-all-sites.css" "~/.config/qutebrowser/styles/solarized-light-all-sites.css"  "" ')
config.bind(',a', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/4chan.css ""')
config.bind(',b', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/reddit.css ""')
config.bind(',e', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/empornium.css ""')
config.bind(',h', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/hacker.css ""')
config.bind(',s', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/scaruffi.css ""')
config.bind(',q', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/qutebrowser.css ""')
# archived ============================================================================
config.bind(',w', 'open https://web.archive.org/web/*/{url}')
config.bind(',W', 'open -t https://web.archive.org/web/*/{url}')
config.bind(',g', 'open https://www.google.com/search?q=cache:{url}')
config.bind(',G', 'open -t https://www.google.com/search?q=cache:{url}')
# javascript =========================================================================
config.bind("xjt", "set content.javascript.enabled true")
config.bind("xjf", "set content.javascript.enabled false")
# Focus ===============================================================================
config.bind('<Ctrl-1>', 'tab-focus 1')
config.bind('<Ctrl-2>', 'tab-focus 2')
config.bind('<Ctrl-3>', 'tab-focus 3')
config.bind('<Ctrl-4>', 'tab-focus 4')
config.bind('<Ctrl-5>', 'tab-focus 5')
config.bind('<Ctrl-6>', 'tab-focus 6')
config.bind('<Ctrl-7>', 'tab-focus 7')
config.bind('<Ctrl-8>', 'tab-focus 8')
config.bind('<Ctrl-9>', 'tab-focus -1')
# passthrough =========================================================================
config.bind('<Ctrl-v>', 'mode-leave', mode='passthrough')
config.bind('<Ctrl-Escape>', 'mode-leave', mode='passthrough')
# Completion ==========================================================================
config.bind('<Ctrl-c>', 'mode-leave', mode='command')
config.bind('<Ctrl-n>', 'command-history-next', mode='command')
config.bind('<Ctrl-p>', 'command-history-prev', mode='command')
config.bind('<Ctrl-j>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-k>', 'completion-item-focus prev', mode='command')
config.bind("<Ctrl-f>", 'completion-item-focus next-page', mode="command")
config.bind("<Ctrl-b>", 'completion-item-focus prev-page', mode="command")
config.bind('<Ctrl-d>', 'completion-item-del', mode='command')
config.bind('<Ctrl-a>', 'rl-beginning-of-line', mode='command')
config.bind('<Ctrl-e>', 'rl-end-of-line', mode='command')
config.bind('<Ctrl-l>', 'rl-forward-char', mode='command')
config.bind('<Ctrl-h>', 'rl-backward-char', mode='command')
config.bind('<Ctrl-w>', 'rl-forward-word', mode='command')
config.bind('<Ctrl-b>', 'rl-backward-word', mode='command')
config.bind('<Ctrl-x>', 'rl-backward-delete-char', mode='command')
config.bind('<Ctrl-y>', 'rl-yank', mode='command')
# prompt ==============================================================================
config.bind('<Ctrl-c>', 'mode-leave', mode='prompt')
config.bind('<Ctrl-d>', 'rl-delete-char', mode='prompt')
config.bind('<Ctrl-j>', 'prompt-item-focus next', mode='prompt')
config.bind('<Ctrl-k>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Ctrl-n>', 'prompt-item-focus next', mode='prompt')
config.bind('<Ctrl-p>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Ctrl-o>', 'prompt-open-download', mode='prompt')
config.bind('<Ctrl+l>', 'fake-key -g /', mode='prompt')
# Insert ==============================================================================
config.bind('<Ctrl-l>', 'fake-key <Left>', mode='insert')
config.bind('<Ctrl-h>', 'fake-key <Right>', mode='insert')
config.bind('<Ctrl-j>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-k>', 'fake-key <Up>', mode='insert')
config.bind('<Ctrl-H>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-A>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-E>', 'fake-key <End>', mode='insert')
config.bind('<Ctrl-D>', 'fake-key <Delete>', mode='insert')
config.bind('<Ctrl-W>', 'fake-key <Ctrl-Backspace>', mode='insert')
config.bind('<Ctrl-U>', 'fake-key <Shift-Home> ;; fake-key <Delete>', mode='insert')
config.bind('<Ctrl-K>', 'fake-key <Shift-End> ;; fake-key <Delete>', mode='insert')
# Caret ===============================================================================
config.bind("/", "cmd-set-text /", mode="caret")
config.bind('$', 'move-to-end-of-line', mode='caret')
config.bind('0', 'move-to-start-of-line', mode='caret')
config.bind("_", "move-to-start-of-line", mode="caret")
config.bind('<Ctrl-Space>', 'selection-drop', mode='caret')
config.bind('<Escape>', 'mode-leave', mode='caret')
config.bind('<Return>', 'yank selection', mode='caret')
config.bind('<Space>', 'selection-toggle', mode='caret')
config.bind('G', 'move-to-end-of-document', mode='caret')
config.bind("H", "scroll left", mode="caret")
config.bind("J", "scroll down", mode="caret")
config.bind("K", "scroll up", mode="caret")
config.bind("L", "scroll right", mode="caret")
config.bind("h", "move-to-prev-char", mode="caret")
config.bind("j", "move-to-next-line", mode="caret")
config.bind("k", "move-to-prev-line", mode="caret")
config.bind("l", "move-to-next-char", mode="caret")
config.bind('V', 'selection-toggle --line', mode='caret')
config.bind('Y', 'yank selection -s', mode='caret')
config.bind('[', 'move-to-start-of-prev-block', mode='caret')
config.bind(']', 'move-to-start-of-next-block', mode='caret')
config.bind('b', 'move-to-prev-word', mode='caret')
config.bind('c', 'mode-enter normal', mode='caret')
config.bind('e', 'move-to-end-of-word', mode='caret')
config.bind('gg', 'move-to-start-of-document', mode='caret')
config.bind('o', 'selection-reverse', mode='caret')
config.bind('v', 'selection-toggle', mode='caret')
config.bind('w', 'move-to-next-word', mode='caret')
config.bind('y', 'yank selection', mode='caret')
config.bind('{', 'move-to-end-of-prev-block', mode='caret')
config.bind('}', 'move-to-end-of-next-block', mode='caret')
# hint ================================================================================
config.bind('<Ctrl-c>', 'mode-leave', mode='hint')
config.bind(';', 'hint links', mode='hint')
config.bind('B', 'hint links tab-bg', mode='hint')
config.bind('F', 'hint all', mode='hint')
config.bind('I', 'hint images run open -t -- {hint-url}', mode='hint')
config.bind('O', 'hint links fill :open -r -t {hint-url}', mode='hint')
config.bind('P', 'hint links run open -p {hint-url}', mode='hint')
config.bind('R', 'hint --rapid links tab-bg', mode='hint')
config.bind('T', 'hint links tab-fg', mode='hint')
config.bind('W', 'hint links window', mode='hint')
config.bind('m', 'hint all hover', mode='hint')
config.bind('o', 'hint links fill :open {hint-url}', mode='hint')
config.bind('t', 'hint inputs', mode='hint')
config.bind('x', 'hint all delete', mode='hint')
config.bind('y', 'hint links yank', mode='hint')
# accept  =============================================================================
config.bind('y', 'prompt-accept yes', mode='yesno')
config.bind('n', 'prompt-accept no', mode='yesno')
config.bind('<Return>', 'prompt-accept yes', mode='yesno')
#               ╔═════════════════════════════════════════════════════════╗
#               ║                         Themes                          ║
#               ╚═════════════════════════════════════════════════════════╝
# Darkmode ============================================================================
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.threshold.foreground = 150
c.colors.webpage.darkmode.threshold.background = 100
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'smart-simple'
c.colors.webpage.darkmode.policy.page = 'smart'
# Lightmode ===========================================================================
config.set("colors.webpage.darkmode.enabled", False, "file://*")
config.set("colors.webpage.darkmode.enabled", False, "http://localhost:*")
for domain in ['localhost',  'vercel.app', 'qutebrowser.org', 'codepen.io', 'whatsapp.com', 'kasmweb.com', 'instapaper.com', 'cz-usa.com', 'mossberg.com', 'ruger.com', 'smith-wesson.com']:
    with config.pattern('*://*.' + domain + '/*') as d:
        d.colors.webpage.darkmode.enabled = False
# Palette =============================================================================
bg0_hard   = "#0d0c0c"
bg0_normal = "#181616"
bg0_soft   = "#201d1d"
bg1        = "#282727"
bg2        = "#393836"
bg3        = "#625e5a"
fg0        = "#c5c9c5"
fg1        = "#b4b3a7"
fg2        = "#a6a69c"
fg3        = "#9e9b93"
# Normal ==============================================================================
red        = "#c34043"
orange     = "#ffa066"
green      = "#98bb6c"
blue       = "#7e9cd8"
purple     = "#957fb8"
cyan       = "#658594"
comment    = "#727169"
# Bright ==============================================================================
red0       = "#c4746e"
orange0    = "#b98d7b"
green0     = "#8a9a7b"
blue0      = "#8ba4b0"
purple0    = "#a292a3"
cyan0      = "#8992a7"
# Completion===========================================================================
c.colors.completion.fg                            = fg3
c.colors.completion.odd.bg                        = bg0_normal
c.colors.completion.even.bg                       = bg0_normal
c.colors.completion.category.fg                   = green
c.colors.completion.category.bg                   = bg0_soft
c.colors.completion.category.border.top           = bg1
c.colors.completion.category.border.bottom        = bg1
c.colors.completion.item.selected.fg              = fg2
c.colors.completion.item.selected.bg              = bg1
c.colors.completion.item.selected.border.top      = bg2
c.colors.completion.item.selected.border.bottom   = bg2
c.colors.completion.item.selected.match.fg        = orange
c.colors.completion.match.fg                      = green
c.colors.completion.scrollbar.fg                  = fg3
c.colors.completion.scrollbar.bg                  = bg1
# Context menu ========================================================================
c.colors.contextmenu.menu.bg                      = bg0_normal
c.colors.contextmenu.menu.fg                      = fg1
c.colors.contextmenu.disabled.bg                  = bg0_hard
c.colors.contextmenu.disabled.fg                  = fg1
c.colors.contextmenu.selected.bg                  = bg1
c.colors.contextmenu.selected.fg                  = fg1
# Downloads ===========================================================================
c.colors.downloads.bar.bg                         = bg0_hard
c.colors.downloads.start.fg                       = fg0
c.colors.downloads.start.bg                       = bg0_normal
c.colors.downloads.stop.fg                        = bg0_hard
c.colors.downloads.stop.bg                        = green
c.colors.downloads.error.fg                       = red
# Hints & Keyhint =====================================================================
c.colors.hints.fg                                 = bg0_hard
c.colors.hints.bg                                 = green0
c.hints.border                                    = f"2 solid {green}"
c.colors.hints.match.fg                           = bg3
c.colors.keyhint.fg                               = fg3
c.colors.keyhint.suffix.fg                        = fg0
c.colors.keyhint.bg                               = bg0_normal
# Messages ============================================================================
c.colors.messages.error.fg                        = bg0_hard
c.colors.messages.error.bg                        = red
c.colors.messages.error.border                    = red
c.colors.messages.warning.fg                      = bg0_hard
c.colors.messages.warning.bg                      = cyan
c.colors.messages.warning.border                  = cyan
c.colors.messages.info.fg                         = fg1
c.colors.messages.info.bg                         = bg0_hard
c.colors.messages.info.border                     = bg0_hard
# Prompts =============================================================================
c.colors.prompts.fg                               = fg1
c.colors.prompts.bg                               = bg0_soft
c.colors.prompts.border                           = f"1px solid {bg1}"
c.colors.prompts.selected.bg                      = bg3
# Statusbar ===========================================================================
c.colors.statusbar.normal.fg                      = fg1
c.colors.statusbar.normal.bg                      = bg0_normal
c.colors.statusbar.insert.fg                      = bg3
c.colors.statusbar.insert.bg                      = bg0_normal
c.colors.statusbar.passthrough.fg                 = bg0_hard
c.colors.statusbar.passthrough.bg                 = green0
c.colors.statusbar.private.fg                     = fg3
c.colors.statusbar.private.bg                     = bg0_hard
c.colors.statusbar.command.fg                     = fg3
c.colors.statusbar.command.bg                     = bg0_normal
c.colors.statusbar.command.private.fg             = fg3
c.colors.statusbar.command.private.bg             = bg0_normal
c.colors.statusbar.caret.fg                       = bg0_hard
c.colors.statusbar.caret.bg                       = green
c.colors.statusbar.caret.selection.fg             = bg0_hard
c.colors.statusbar.caret.selection.bg             = purple
c.colors.statusbar.url.fg                         = bg3
c.colors.statusbar.url.error.fg                   = red
c.colors.statusbar.url.warn.fg                    = orange
c.colors.statusbar.url.success.http.fg            = red
c.colors.statusbar.url.success.https.fg           = bg3
c.colors.statusbar.url.hover.fg                   = bg3
c.colors.statusbar.progress.bg                    = green
# Tabs ================================================================================
c.colors.tabs.bar.bg                              = bg0_normal
c.colors.tabs.odd.fg                              = fg1
c.colors.tabs.odd.bg                              = bg0_normal
c.colors.tabs.even.fg                             = fg1
c.colors.tabs.even.bg                             = bg0_normal
c.colors.tabs.selected.odd.fg                     = fg1
c.colors.tabs.selected.odd.bg                     = bg2
c.colors.tabs.selected.even.fg                    = fg1
c.colors.tabs.selected.even.bg                    = bg2
c.colors.tabs.pinned.even.bg                      = green
c.colors.tabs.pinned.even.fg                      = bg2
c.colors.tabs.pinned.odd.bg                       = green
c.colors.tabs.pinned.odd.fg                       = bg2
c.colors.tabs.pinned.selected.even.bg             = bg2
c.colors.tabs.pinned.selected.even.fg             = fg1
c.colors.tabs.pinned.selected.odd.bg              = bg2
c.colors.tabs.pinned.selected.odd.fg              = fg1
# tooltips ============================================================================
c.colors.tooltip.bg                               = bg0_hard
c.colors.tooltip.fg                               = fg1
# Webpage =============================================================================
c.colors.webpage.bg                               = 'white'
