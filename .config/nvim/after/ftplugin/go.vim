set makeprg=go\ build
"au BufWritePost *.go :silent !go fmt 
"au BufWritePost *.go :e
