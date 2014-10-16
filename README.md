sideways
========

![data/sideways.jpg](sideways)

This small program created with Processing creates 2 slit scan bitmaps from a single video.
The video must be a first-person road shoot so both sides (left & right) are created from the edges.


instructions
---------------
* open the sketch in [Processing](http://www.processing.org). Download the program if necessary
* import your video to the sketch or place it in the <code>/data</code> directory
* update <code>filename</code> and <code>extension</code> variables accordingly

important variables
--------------------------

* **scanBorderOffset** is the sample distance from the edge
* **scanWidth** is the slice width
* **widthFactor** is the multiplier of the output width
