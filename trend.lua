local function getTrend(msg, trend1, trend2)

    local trend1_escaped = URL.escape(trend1)
    local trend2_escaped = URL.escape(trend2)
    local receiver = get_receiver(msg)
    local url = "http://www.google.com/trends/fetchComponent?hl=it-IT&q="..trend1_escaped..","..trend2_escaped.."&cid=TIMESERIES_GRAPH_0&export=5&w=1024&h=900"

        --local url_escaped = url:gsub("[^%A/\\]+","")
        os.execute('xvfb-run --server-args="-screen 0, 1024x500x24" cutycapt --url="'..url..'" --out=pic.jpg && convert -crop -0-200 pic.jpg pic.jpg')
        send_photo(receiver, "pic.jpg", trend1.." vs "..trend2, {receiver, trend1.." vs "..trend2, ""})
end


function run(msg, matches)
  local receiver = get_receiver(msg)

  getTrend(msg, matches[1], matches[2])

end


return {
   description = "Show trends",
   usage = {
      "!trend <trend1>,<trend2>"
   },
   patterns = {
      "^!trend (.+),(.+)$",
   },
   run = run
}
