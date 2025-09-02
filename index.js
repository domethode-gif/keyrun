addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const url = 'https://raw.githubusercontent.com/domethode-gif/keyrun/refs/heads/main/finalkey.bat'
  const res = await fetch(url)
  const script = await res.text()

  return new Response(script, {
    headers: {
      'content-type': 'text/plain;charset=UTF-8',
      'content-disposition': 'attachment; filename="finalkey.bat"'
    }
  })
}
