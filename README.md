opml2html
=========

### What is this? (aka the Problem to be Solved)

O HAI
Need stuff here

[NosillaCast][NC]
[Omni Group][OMNI]
[OmniOutliner][OO]

### Usage

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

[NC]: http://podfeet.com/ "NosillaCast"
[OMNI]: https://www.omnigroup.com "The Omni Group"
[OO]: https://www.omnigroup.com/omnioutliner "OmniOutliner"
[EMAIL]: mailto:dburr@DonaldBurr.com?subject=opml2html "Email"
[MIT]: http://opensource.org/licenses/MIT "MIT License"
[CL]: https://github.com/jatoben/CommandLine "CommandLine"