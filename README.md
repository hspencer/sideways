sideways
========

![Hopefully this illustration explain what it does](/data/sideways.jpg)

This small program created with Processing creates 2 slit scan bitmaps from a single video.
The video must be a first-person road shoot so both sides (left & right) are created from the edges.


instructions
---------------
* open the sketch in [Processing](http://www.processing.org). Download the program if necessary
* import your video to the sketch or place it in the <code>/data</code> directory
* update <code>filename</code> and <code>extension</code> variables accordingly

important variables
--------------------------

* <code>scanBorderOffset</code> is the sample distance from the edge
* <code>scanWidth</code> is the slice width
* <code>widthFactor</code> is the multiplier of the output width
