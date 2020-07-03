# 🕷 Inspider

A creepy Instagram scraper to download IGTV metadata.

## Metadata

The following data points are collected:

- `title`: anything before two `<br>` in the post description
- `description`: anything after two `<br>` in the post description
- `post_url`: post url
- `video_url`: video source attribute

Once the script is run successfully, a `results.json` is created with the collected data.

### Example
```json
[
  {
    "title": "Coffee & Stocks ☕️ day#70 (02/07/20)",
    "post_url": "https://www.instagram.com/tv/CCIxzdfhI76/",
    "description": "Karen Hime, da IP Capital, comentou sobre a polêmica envolvendo o Facebook, atualmente a maior participação nos fundos da IP. Em resumo: i) apesar do boicote de grandes empresas, 75% da receita com anunciantes vem de pequenas e médias empresas; ii) não é a primeira vez que vemos tentativas de boicote ao Facebook. Ela também comentou sobre a tese de shoppings no Brasil, onde a IP tem preferência por BR MALLS e MULTIPLAN. No telegram, enviaremos uma análise exclusiva da Karen. Entre na nossa lista pra conferir (link nos stories)",
    "video_url": "https://instagram.flis5-1.fna.fbcdn.net/v/t50.2886-16/10000000_736794140466280_8970513767431235791_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjUwNC5pZ3R2LmRlZmF1bHQiLCJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSJ9&_nc_ht=instagram.flis5-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=5mU-jIG2K-EAX9iY6OP&vs=17942612524368403_3099807156&_nc_vs=HBksFQAYJEdJQ1dtQUJvM0FOQkhKNENBTTlvZldDX3FuMThicUNCQUFBRhUAAsgBABUAGCRHSUNXbUFBLUZVREZKbG9DQUhqc0cyV3hKeTh4YnFDQkFBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAABgAFqainKrArd8%2FFQIoAkMzLBdAnl9YEGJN0xgSZGFzaF9iYXNlbGluZV8xX3YxEQB17AcA&_nc_rid=b3b6a94cd5&oe=5F01D8DF&oh=16d91dda0230502aaf6e5c2faf78baff",
  },
  {
    "title": "Coffee & Stocks ☕️ day#67 (29/06/20)",
    "post_url": "https://www.instagram.com/tv/CCBB_wVh6gN/",
    "description": "Fabio Alperowitch, gestor da Fama Investimentos: quem diz que ESG é mimimi será atropelado pelo mercado. Uma das vozes mais ativas sobre o assunto comentou alguns casos de empresas brasileiras (Arezzo, Klabin, Iguatemi) para explicar como o Brasil está se adaptando a esta “novidade” (que na verdade existe já há muito tempo no mercado mas que demorou um pouco pra se desenvolver no 🇧🇷). Resumo completo + “pílula de análise” irá pro nosso Telegram!",
    "video_url": "https://instagram.flis5-1.fna.fbcdn.net/v/t50.2886-16/10000000_2881074182014923_4608711029975346889_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjUwNC5pZ3R2LmRlZmF1bHQiLCJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSJ9&_nc_ht=instagram.flis5-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=aiIDYYa3348AX8b_xuB&vs=18115888381123899_1682762034&_nc_vs=HBksFQAYJEdJQ1dtQURMeHpCYlVqd0tBTW51R29aRGJ2VS1icUNCQUFBRhUAAsgBABUAGCRHSUNXbUFEbWJTbHB2aE1DQUdhdHpnT01XRFVMYnFDQkFBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAABgAFvbLvpy%2Bk65AFQIoAkMzLBdAl3ysCDEm6RgSZGFzaF9iYXNlbGluZV8xX3YxEQB17AcA&_nc_rid=eb62f64f03&oe=5F019000&oh=679e9d39612949c98f6b74f832dfdccb",
  }
]
```

## Requirements

- Ruby (>= 2.5.0)
- Chrome
- Chromedriver

## Setup

Install the dependencies:

```
bundle install
```

Configure the parameters, the following environment variables are available:

- `INSTAGRAM_USERNAME` *(required)*: username to log in
- `INSTAGRAM_PASSWORD` *(required)*: password to log in
- `INSTAGRAM_TARGET_USERNAME` *(required)*: username whom you want to download its IGTV metadata from
- `PAGES` *(optional, default: 5)*: number of pages to be scraped in the channel page. The more videos a channel has, the more this number must be (Instagram uses infinite scroll as pagination)
- `THREADS` *(optional, default: 4)*: number of threads to be spawned

They must be placed in a `.env` file in the root of the project.

## Usage

```
bundle exec kimurai crawl igtv
```

## Debug

You can take screenshots and save the current page (besides the old `binding.pry`):

```ruby
browser.save_and_open_page
browser.save_and_open_screenshot
browser.save_screenshot
browser.save_page
```

Powered by [Kimurai](https://github.com/vifreefly/kimuraframework).
