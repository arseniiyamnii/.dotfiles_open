import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})


c.url.start_pages = "https://google.com"
c.url.searchengines = {"DEFAULT": "https://www.google.fi/search?q={}"}
c.content.user_stylesheets = "solarized-dark-all-sites.css"
c.url.default_page = "google.com"
def chstyle():
    c.content.user_stylesheets = ""

