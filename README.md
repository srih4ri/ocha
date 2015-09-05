ocha
====

This is a sinatra app which uses [text2wave](http://manpages.ubuntu.com/manpages/gutsy/man1/text2wave.1.html) to convert text to an audio file.

The crux of the app is : 
``
"echo '#{words}'| text2wave | lame - #{file_path}" .
``
