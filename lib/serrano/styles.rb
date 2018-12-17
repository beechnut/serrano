require 'faraday'
require 'multi_json'

def get_styles
  base = 'https://api.github.com/repos/citation-style-language/styles'
  conn = Faraday.new(url: base) do |f|
    f.use FaradayMiddleware::RaiseHttpException
    f.adapter Faraday.default_adapter
  end
  args = { per_page: 1 }
  tt = conn.get 'commits', args
  commres = MultiJson.load(tt.body)
  sha = commres[0]['sha']
  sty = conn.get 'git/trees/' + sha
  res = MultiJson.load(sty.body)
  files = res['tree'].collect { |x| x['path'] }
  matches = files.collect do |x|
    if x.match('csl').nil?
      nil
    else
      x.match('csl').string
    end
  end
  csls = matches.compact
  csls.collect { |z| z.gsub('.csl', '') }
end
