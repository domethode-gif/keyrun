addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  // Ambil file script dari repo (keyrun.bat)
  const url = 'https://raw.githubusercontent.com/USERNAME/REPO/main/keyrun.bat'
  const res = await fetch(url)
  const script = await res.text()

  return new Response(script, {
    headers: {
      'content-type': 'text/plain;charset=UTF-8',
      'content-disposition': 'attachment; filename="keyrun.bat"'
    }
  })
}
