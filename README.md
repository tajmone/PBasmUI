# PBasmUI

    PBasmUI v3.22 (Tristano Ajmone fork)
    PBasmUI v3.21 (Horst Schaeffer upstream)
    PureBASIC v5.61 | Windows

This project is an offshoot of Horst Schaeffer's __PBasmUI__ — a PureBASIC IDE Add-In to create, view, edit and re-assemble the intermediate assembly code from PureBASIC source files:

- http://horstmuc.de/pb.htm

Maintained by Tristano Ajmone, with the kind permission of Horst Schaeffer.

---

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [Files List](#files-list)
- [Introduction](#introduction)
    - [Features](#features)
    - [Setup](#setup)
    - [Changelog](#changelog)
        - [v3.22 \(2017/12/05\)](#v322-20171205)
- [About This Project](#about-this-project)
    - [Development](#development)
    - [Upstreams Archive](#upstreams-archive)
    - [Roadmap](#roadmap)
- [License](#license)
    - [License for Repository and Sources](#license-for-repository-and-sources)
    - [License for Binary Distribution](#license-for-binary-distribution)
- [About The Wiki](#about-the-wiki)
- [Contributing](#contributing)

<!-- /MarkdownTOC -->

---

# Files List

- [`CONTRIBUTING.md`](./src/CONTRIBUTING.md) — contribution guidelines
- [`LICENSE`](./LICENSE) — MIT License for this project
- [`/src/`](./src/) PBasmUI source files:
    + [`PBasmUI.pb`](./src/PBasmUI.pb) — main PBasmUI source file
    + [`Macro.pbi`](./src/Macro.pbi) — PBasmUI include file
    + [`pb5.ico`](./src/pb5.ico) — PBasmUI icon
    + [`PBasmUI.txt`](./src/PBasmUI.txt) — original changelog
    + [`LICENSE`](./src/LICENSE) — License for binary distribution
- [`/upstreams/`](./upstreams/) — archived copies of Horst's releases

# Introduction

PBasmUI is an elegant and powerful IDE add-in for creating and reassemblying commented assembly files from PureBASIC sourcecode. 

![PBasmUI screenshot](./screenshot.gif "Screenshot of PBasmUI (tajmone fork)")

Thanks to its graphical user interface, working with PureBASIC intermediate assembly code has never been easier. No need to manually invoke the pbcompiler via the command line interface: with PBasmUI accessing advanced compiler features is a breeze — and the source file's original compiler options are preserved too. 

## Features

-  Generate the "`PureBasic.asm`" Assembly file (= `/COMMENTED`  compiler option) and open it     
-  Produce executable file and/or run program     
-  Re-assemble current asm file (= `/REASM` compiler option) 
-  Change/add options
-  Compiler messages are captured into log file ("`<filename>.log`")
-  Compiler options settings are taken from either:
    + the file "`<source filename>.cfg`" (e.g. "`PBasmUI.pb.cfg`"), if found, 
    + the IDE-generated commented section at the end of the source file).

## Setup

Setting up PBasmUI should be quite obvious (if you're working with assembly code in PureBASIC you should be an experienced user already). As a general reminder, here are the basic steps:

1. Compile "`src/PBasmUI.pb`" to "`PBasmUI.exe`"
2. Follow PureBASIC documentation on how to setup an external tool in PureBASIC IDE:

    - [PureBASIC Documentation: Using external tools](http://www.purebasic.com/documentation/reference/ide_externaltools.html)

3. Make sure, in PBasmUI's tool settings, that "`PBasmUI.exe`" is invoked with the following arguments: `"%FILE"` (double quotes included).

## Changelog

This changelog resumes the changes introduced to Horst's code in the various releases of the PBasmUI "tajmone fork". More details can be found in the source files comments.

Please note that the changes and features introduced here reflect my personal needs in using PBasmUI, and not shortcomings in the original application. Also, bare in mind that my changes might disrupt the behaviour of the original tool. Bugs resulting from these changes are my fault, not Horst's. 

Also, bare in mind that PBasmUI is an app that was started in 2004, with PureBASIC 3.x, and updated along the years to keep up with PureBASIC updates. Some parts of its original code might still refer to old behaviors of the PB compiler which are no longer active, but neither problematic. A good example is the `/UNICODE` compiler switch, which ceased to make any difference in the compiler from PureBASIC v5.50 onward, but it's kept for backward compatibility with previous versions — with later versions of PureBASIC this switch is just ignored, silently.

### v3.22 (2017/12/05)

First stable-release fork from Horst's PBasmUI v3.21.

- Added "(tajmone fork)" to UI window title, to avoid confusion with Horst's original version PBasmUI.
- A log file named "`<filename>.log`" is always created in the source file folder (this is the "`Error.out`" file created by the original version in a temporary folder). 
- Now PBasmUI outputs the compiled executable, the "`PureBasic.asm`" and the log file ("`<filename>.log`") to same folder as the source file.
- When "Product &gt; Executable" is unchecked, the executable file is created in Windows TEMP folder ("`%TEMP%\PureBasic.exe`"). Previously the unchecked  "Executable" option was handled by passing the "`/CHECK`" switch to the compiler, but that prevented the creation of the "`PureBasic.asm`" file. There is no way to produce the "`PureBasic.asm`" file without the executable, so this solution seemed the best workaround to me.
- Removed "Product &gt; Inline ASM support" option. This UI option was rasing an "`/INLINEASM: Unknown switch`" error.
- Tweaked Gadget Events behavior:
    * Checking "Source &gt; /REASM" option sets to checked and disables the "Product &gt; Executable" checkbox because with this option creating an executable is mandatory.
    * Checking  "Source &gt; PB File" re-enables "Product &gt; Executable" checkbox.
- Before invoking the compiler with /REASM option, if the "Product &gt; Executable" path string is empty it will be set to "`<filename>_reAsm.exe`" before compiling.
- Added `#PB_Program_Hide` flag to the `RunProgam()` that invokes PB compiler, so that it launches in invisible mode. This fixes the flash of the CMD window that was opnening and closing in the background when clicking the "Run" button. 

# About This Project

I wanted to tweak Horst's __PBasmUI__ to my personal needs, so I contacted him and asked permission to do so. He kindly consented to my request, and this repository was born. 

## Development

My variations on Horst's original code are built on his __PBasmUI v3.21__ release. Development takes place in the [`dev-rc`][dev-rc] branch, were various release candidates are commited and tested before declaring them stable releases. Stable release source files are then just checked out into `master` branch.

## Upstreams Archive

The `upstreams` folder is for archiving the sources of Horst's releases of __PBasmUI__ (ie: the _upstream_ version). This will simplify the task of integrating changes from newer versions of Horst's __PBasmUI__ into this project (_downstream_), by diffing the source files of the latest release with those of the release this project was built on (ie: v3.21), or of the latest release whose changes have been integrated.

- [`/upstreams/`](./upstreams/)
    - [`/3-21/`](./upstreams/3-21/)
    - [`History.txt`](./upstreams/History.txt)


## Roadmap

The full Roadmap can be viewed in the repository project board:

- https://github.com/tajmone/PBasmUI/projects/1

Here is a task-list resume of the roadmap status:

- [x] Direct compiler output and logs to source-file folder ([_link_][card1])
- [ ] Add additional compilers support ([_link_][card2])
- [ ] Add source preprocessing feature ([_link_][card3])
- [ ] Implement compilation with Version Information ([_link_][card4])

These are ideas I would like to implement, in due time. Some of these might end up not being worth implementing — eg, if they would end up departing from the original goal of this app, which is to simplify (rather than make more complex) working with intermediate assembly files. Others might turn out to be too diffcoult or impractical to implement. 

It's just a wishlist, with no real deadline set. PBasmUI already does a great job at what it does, but I feel that some changes could make its use even better, then I'll do my best to implement them.

Most important of all is going to be keeping it up to date with PureBASIC updates and new features (PureBASIC v6 is not far away).

[card1]: https://github.com/tajmone/PBasmUI/projects/1#card-5965436 "View project board card"

[card2]: https://github.com/tajmone/PBasmUI/projects/1#card-5965446  "View project board card"

[card3]: https://github.com/tajmone/PBasmUI/projects/1#card-5965451 "View project board card"

[card4]: https://github.com/tajmone/PBasmUI/projects/1#card-5965444 "View project board card"


# License

This project is MIT licensed. When redistributing compiled binaries, further licenses attributions (all MIT compatible) are required for third party components used by PureBASIC compiler.

## License for Repository and Sources

- [`LICENSE`](./LICENSE)

Having been granted permission by the author to reuse the original code without restrictions, I'm publishing this project under the terms of the MIT License — as this will grant that Horst's name will always be mentioned:

    MIT License

    Copyright (c) 2004-2017, Horst Schaeffer -- http://horstmuc.de/pb/
    Copyright (c) 2017 Tristano Ajmone -- https://github.com/tajmone/PBasmUI

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

These terms do no affect the original files found on Horst's website.

This license file covers the terms for this Git project and PBasmUI source files; the compiled binary of PBasmUI is subject to inclusion of further licenses that cover the third party components used by the PureBASIC compiler (see next section).

## License for Binary Distribution

- [`/src/LICENSE`](./src/LICENSE) 

Please note that publishing/distribution of the compiled (binary/executable) file of PBasmUI requires inclusion of the [`LICENSE`](./src/LICENSE) file found in the `/src/` folder. This license file contains PBasmUI's MIT license plus additional (MIT compatible) licenses for the third party components used by PureBASIC to build the final binary file.

This file should always be included along with "`PBasmUI.exe`".

The third party components' licenses mentioned in that file do not apply to this repository because no file (source or binary) from these components is included in this project. They do however apply to any binary downloadable attachment file — ie: any GitHub release with pre-compiled binary attachments of PBasmUI must contain a copy of this license file and is subjected to its terms.

# About The Wiki

- [PBasmUI Wiki][Wiki]

This project has also a [Wiki] for organizing useful information on topics that are of interest in the development of PBasmUI (eg: PureBASIC compiler settings and options, tokens and env vars passed by the IDE to Add-In tools, etc.) 

The Wiki is editbale by any GitHub user, so feel free to add contents, links, or make corrections.

# Contributing

Contributions are welcome. Read the contribution guidelines:

- [`CONTRIBUTING.md`](./src/CONTRIBUTING.md)




[Wiki]: https://github.com/tajmone/PBasmUI/wiki "Visit the PBasmUI Wiki ..."

[dev-rc]: https://github.com/tajmone/PBasmUI/tree/dev-rc "View the release-candidates development branch"
