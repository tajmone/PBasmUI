# Contributing to PBasmUI

## Development Branch

Development takes place in the [`dev-rc`][dev-rc] branch, were various release candidates are commited and tested before declaring them stable releases. Stable release source files are then just checked out into `master` branch.

When making a pull request, you should consider proposing a candidate release first, on the [`dev-rc`][dev-rc] branch.

## PureBASIC IDE Settings

Before working with PureBASIC projects and Git you need to check the following settings in the PureBASIC IDE's preferences:

- `Preferences » Editor »  Save Settings to:` --- make sure it isn't set to "__The end of the Source file__"; otherwise the IDE will append to the source files your custom settings and Git will see them as changed files even though no significant changes in contents have taken place. If different contributors use different settings, the same file would keep being overwritten and changed back and forth.

    You should set it to either "__A common file project.cfg for every director__ " or "__The file &lt;filename&gt;.pb.cfg__" --- the [`.gitignore`](./.gitignore) file in this project is configured to make Git ignore all of PureBASIC's `*.cfg` configuration files.

The project is already configured to ignore `*.pbp` project files --- beside sharing some personal information on the Internet, project files contain extra files history info that changes every time you close the PureBASIC IDE, causing Git to constantly detect files changes. This would only interfere with branch switiching, and cause lots of spurious commits.

## Questions and Issues

Having said that, contributions via pull-requests are welcome, and for any questions, suggestions and bug reports you can always [open an issue].



[open an issue]: https://github.com/tajmone/PBasmUI/issues/new "Click here to open a new issue"

[dev-rc]: https://github.com/tajmone/PBasmUI/tree/dev-rc "View the release-candidates development branch"


