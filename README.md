# PBasmUI

    PureBASIC v5.61 | Windows

This project is an offshoot of Horst Schaeffer's __PBasmUI__ — a PureBASIC IDE Add-In to create, view, edit and re-assemble the intermediate assembly code from PureBASIC source files:

- http://horstmuc.de/pb.htm

Maintained by Tristano Ajmone, with the kind permission of Horst Schaeffer.

---

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="true" lowercase_only_ascii="true" uri_encoding="true" depth="3" -->

- [Files List](#files-list)
- [About This Project](#about-this-project)
    - [Initial Commit](#initial-commit)
    - [Upstreams Archive](#upstreams-archive)
    - [Roadmap](#roadmap)
    - [License](#license)
- [About The Wiki](#about-the-wiki)
- [Contributing](#contributing)

<!-- /MarkdownTOC -->

---

# Files List

- [`CONTRIBUTING.md`](./src/CONTRIBUTING.md) — contribution guidelines
- [`LICENSE`](./src/LICENSE) — MIT License
- [`/src/`](./src/) PBasmUI source files:
    + [`PBasmUI.pb`](./src/PBasmUI.pb) — main PBasmUI source file
    + [`Macro.pbi`](./src/Macro.pbi) — PBasmUI include file
    + [`pb5.ico`](./src/pb5.ico) — PBasmUI icon
    + [`PBasmUI.txt`](./src/PBasmUI.txt) — original changelog
- [`/upstreams/`](./upstreams/) — archived copies of Horst's releases

# About This Project

I wanted to tweak Horst's __PBasmUI__ to my personal needs, so I contacted him and asked permission to do so. He kindly consented to my request, and this repository was born.

## Initial Commit 

This repository takes off from Horst's original source files from __PBasmUI v3.21__ — and this is the current state of the source files, which are unaltered so far! As I'll manage to implement the desired tweaks and new features, I'll be pushing them to the repo.

Horst and I had quite a few email exchanges on the possible features enhancements and changes to implement in __PBasmUI__, and how we could go about them. Having the code accessible on GitHub will now allow us to carry on the exchange through live code examples, and experiment with branches.

It's too early to predict if this project will become an independent offshot of __PBasmUI__, or if might instead become the furnace and testground of its  future official releases. Right now, I'm just publishing the original source code that can be found at Horsts' website, so I can start implementing, testing and sharing ideas.

## Upstreams Archive

The `upstreams` folder is for archiving the sources of Horst's releases of __PBasmUI__ (ie: the _upstream_ version). This will simplify the task of integrating changes from newer versions of Horst's __PBasmUI__ into this project (_downstream_), by diffing the source files of the latest release with those of the release this project was built on (ie: v3.21), or of the latest release whose changes have been integrated.

- [`/upstreams/`](./upstreams/)
    - [`/3-21/`](./upstreams/3-21/)
    - [`History.txt`](./upstreams/History.txt)


## Roadmap

The full Roadmap can be viewed in the repository project board:

- https://github.com/tajmone/PBasmUI/projects/1

Here is a task-list resume of the roadmap status:

- [ ] Direct compiler output and logs to source-file folder ([_link_][card1])
- [ ] Add additional compilers support ([_link_][card2])
- [ ] Add source preprocessing feature ([_link_][card3])
- [ ] Implement compilation with Version Information ([_link_][card4])

<!-- -->

[card1]: https://github.com/tajmone/PBasmUI/projects/1#card-5965436 "View project board card"

[card2]: https://github.com/tajmone/PBasmUI/projects/1#card-5965446  "View project board card"

[card3]: https://github.com/tajmone/PBasmUI/projects/1#card-5965451 "View project board card"

[card4]: https://github.com/tajmone/PBasmUI/projects/1#card-5965444 "View project board card"


## License

- [`LICENSE`](./src/LICENSE)

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

# About The Wiki

- [PBasmUI Wiki][Wiki]

This project has also a [Wiki] for organizing useful information on topics that are of interest in the development of PBasmUI (eg: PureBASIC compiler settings and options, tokens and env vars passed by the IDE to Add-In tools, etc.) 

The Wiki is editbale by any GitHub user, so feel free to add contents, links, or make corrections.

# Contributing

Contributions are welcome. Read the contribution guidelines:

- [`CONTRIBUTING.md`](./src/CONTRIBUTING.md)




[Wiki]: https://github.com/tajmone/PBasmUI/wiki "Visit the PBasmUI Wiki ..."