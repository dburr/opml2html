opml2html
=========

### What is this? (aka the Problem to be Solved)

I frequently contribute product reviews to the [NosillaCast][NC], a "technology geek
podcast with an EVER so slight Macintosh bias" put out by my friend [Allison Sheridan][ALLISON].
She insists that reviews must be submitted in both audio as well as text form, so that those with
disabilities can still play along. Being a low vision user myself, I applaud this decision.

When working on a writing project of any length, I always use the [Omni Group][OMNI] excellent
[OmniOutliner][OO] to organize my thoughts, so I figured that once I've organized my outline to
my satisfaction and fleshed it out, it would serve as a good set of show notes to send along with
my audio review. Unfortunately, OmniOutliner's export formats leave much to be desired; none of
them produce output that Allison can use without heavy editing.

I was hemming and hawing about how to solve this particular problem when I realized that, hey,
I'm a developer; surely I could put together some sort of tool to turn OmniOutliner's output
into a usable, simple HTML document. (I'm not sure why I didn't realize this until sooner!)
It also gave me an excuse to "get my hands dirty" with Apple's new programming language,
[Swift][SWIFT]. About half an hour later, I put together a (IMHO) rather nice tool that produces
simple, indented HTML using the OPML format which OmniOutliner can export to.

### Usage

Export your outline from OmniOutliner (`File -> Export...`) and be sure and choose the
"OPML (Outline Processor Markup Language)" format. Now run `opml2html` in a Terminal
window. The usage is as follows:

```
Usage: opml2html [options]
  -f, --input-file:
      Path to the input file. (Required)
  -o, --output-file:
      Path to the output file. (Optional, default = <filename without extension>.html)
  -l, --full-mode:
      Create full HTML output (including <head>, etc.)
  -h, --help:
      Prints a help message.
```

The only mandatory command line argument is `-f` (or `--input-file`), which tells the
tool what file to read from. By default, the output gets stored into a file named
the same as the original filename, but with `.html` instead of `.opml` as its extension.
(So running the tool on a file `foo.opml` would place the results in a `foo.html` file
in the same directory as the original file.) This can be changed using the `-o` or
`--output-file` argument. Finally, the `-f` or `--full-mode` creates a fully-formed
HTML file (including `<HEAD>`, `<BODY>`, etc. tags.) By default the tool only outputs
the HTML necessary for rendering the outline.

### Building

This project includes Ben Gollmer's Swift [CommandLine][CL] library as a dependency
(using git submodules.) You must install it before you can build this project. This
is pretty easy to do however; just run the following commands.

```
git submodule init
git submodule update
```

### License

This software is licensed under the terms of the [MIT License][MIT].

Copyright (c) 2015 Donald Burr <[dburr@DonaldBurr.com][EMAIL]>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

### Credits

Uses Ben Gollmer's Swift [CommandLine][CL] library.

[ALLISON]: https://twitter.com/podfeet "Allison Sheridan"
[NC]: http://podfeet.com/ "NosillaCast"
[OMNI]: https://www.omnigroup.com "The Omni Group"
[OO]: https://www.omnigroup.com/omnioutliner "OmniOutliner"
[SWIFT]: https://developer.apple.com/swift/ "Swift"
[EMAIL]: mailto:dburr@DonaldBurr.com?subject=opml2html "Email"
[MIT]: http://opensource.org/licenses/MIT "MIT License"
[CL]: https://github.com/jatoben/CommandLine "CommandLine"