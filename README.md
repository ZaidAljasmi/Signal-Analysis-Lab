Signal Analysis Lab - is this signal periodic?
=====================================

Type an equation, press a button, see the graph and the answer:
periodic or not, and if periodic its period T, frequency f and angular
frequency w. Works for continuous x(t) and discrete x[n] signals.

This file covers the controls for changing the wave and reading the
plot. The maths behind the verdict is in README.md.


Requirements
------------
Any web browser. No internet, no install, no account.


Starting
--------
Open index.html with a double click.

From a USB stick:
  Windows   double click start.bat
  Linux     bash start.sh
Both open the page in the default browser. Keep index.html in the
same folder.

For full screen click the Fullscreen button at the top of the page,
or press F11. A page cannot force full screen by itself, so one click
is needed.


Plotting
--------
1. Type the equation in the first box, e.g. sin(2*pi*t)
2. Fill in start time, end time and number of samples.
3. Press Plot Signal.

The grey text in the boxes is only a hint. Nothing is filled in until
you type it, or click one of the example buttons.

You can use:  t  pi  + - * / ^  ( )  sin cos tan exp sqrt abs
Write 2*t, not 2t.

Discrete signals: press the "Discrete x[n]" button above the equation.
The variable is now n, and start/end must be whole numbers.


Changing the wave
-----------------
Four sliders under the graph reshape the signal you plotted:

  y = A * x( k * (t - t_d) ) + B

  Amplitude A          taller or shorter, can be negative
  Frequency scale k    k = 2 squeezes the wave to half the period,
                       k = 0.5 stretches it to twice the period
  Time shift t_d       slides the wave left or right
  Vertical offset B    moves the wave up or down

Ranges are -5 to 5 for A, t_d and B, and 0.1 to 5 for k. In discrete
mode the shift n_d moves in whole samples, -20 to 20.

The graph and the results update while you drag. The results show an
"Applied parameters" line so you can see what is in effect, and the
period, frequency and angular frequency are the ones of the changed
wave. Reset parameters puts the sliders back to 1, 1, 0, 0.

The sliders work after you have plotted something.


Does moving the sliders change the verdict?
-------------------------------------------
No. A periodic signal stays periodic and an aperiodic one stays
aperiodic, whatever the sliders say. Only the period changes:
T becomes T / k. Amplitude, shift and offset do not change it.

One exception: A = 0 flattens the wave to a constant line, and the
verdict becomes "Constant". That is correct, not a bug.

Why: if the changed wave repeated, the original could be rebuilt from
it by undoing the amplitude, shift and scaling, so it would repeat
too.


Plot scale
----------
Y minimum / Y maximum   fix the vertical axis. Leave both empty
                        for automatic. One filled is allowed.
Vertical zoom + / -     zoom in or out on the vertical axis
Horizontal zoom + / -   zoom in or out on time; this rewrites the
                        start and end boxes and plots again
Vertical axis: auto     give the vertical axis back to the program

With automatic scale the axis rescales itself when you change A, so
the wave looks the same and only the numbers on the axis change. To
see the amplitude change, fix the axis first, for example -5 and 5.

Hover the pointer over the graph to read t and x(t) (or n and x[n]).


Reset
-----
The Reset button empties everything: equation, boxes, sliders,
scale, graph and results. Reloading the page does the same.


Language
--------
The button at the top switches between Arabic and English. Messages
and results change with it.


Examples
--------
sin(2*pi*t), then k = 2        period 0.5 s, still periodic
exp(t), any slider             never periodic
sin(t)+sin(pi*t)               not periodic, whatever k is
cos(pi*n/4)  (discrete)        period N = 8 samples


Notes
-----
"Inconclusive" means the program cannot decide this equation. It does
not guess. Not seeing a repeat in the window does not prove a signal
is aperiodic.

If the page looks stale after an update, press Ctrl+Shift+R.
