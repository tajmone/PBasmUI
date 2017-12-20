# PBasmUI TODOs List

An organized and commented list of pending tasks and features wishlist in the development of PBasmUI.

# Changes Wishlist

Wishist of changes and new features to implement.

- [ ] Rename "PureBasic.asm" to "`<filename>.asm`" — In order to do that, all compile operations should be carried out in the system TEMP folder:
      
    - When creating asm file, the "PureBasic.asm" shall be copied renamed to "`<filename>.asm`" in the source file folder. This will also allow to avoid producing the exe file when the corresponding checkbox is unchecked (currently, there seems no way to produce only the `.asm` file, the compiler will always produce the exe file too; using the "`/CHECK`" option will prevent creating the `.asm` file!)

    - When reAsming the current source, the correct "`<filename>.asm`" will be copied to the TEMP folder, reAsmed, and the final exe copied to the source file folder.

- [ ] When "Product > Executable" is checked and Exe's path/name string is empty, the exe is compiled as "`PureBasic.exe`" in `%TEMP%` folder. But because the "Executable" checkbox is checked, the user intention is to build a exe in the source folder, probably he just messed up the path string.

    In this case PBasmUI could behave like with /REASM, and provide a default exe name ("`<filename>.exe`" or "`<filename>_pb.exe`").

    I'm not sure about this, unlike for /REASM option, here it might be imposing too many assumption on the user intentions. Maybe it's better to add a "Restore" button that will reset all the string fields to the default values instead. Also, this change should be postponed to after implementing /REASM with "`<filename>.asm`" anyway.

- [ ] EDGE-CASE FIX: /REASM disabled & activated! (LOW-PRIORITY)

    If the user deletes the "`PureBasic.asm`" file after the UI ackowledge it, /REASM attempt will fail and "Source > /REASM" becomes both activated and disabled. This messes up the gadgets states, and the source remains  "PureBasic.asm" even when trying to compile exe file! And because the user can't select /REASM any more, the situation is stalled. Since /REASM option is disabled, checking "Source > PB File" won't change its state to disactivated. I need to add a check somewhere that detects when /REASM is both disabled and activated, and set it to disactivated and activate "Source > PB File" instead.

    This isn't a high priority fix because it pertains only to bad usage of PBasmUI, and the easy solution would be to quit adn restart PBasmUI.  Neverthlesse, it's worth adding some further gadget checks. Maybe, checking that the Asm file is still there could be done when "Run" button is pressed, and before invoking the actual `RunCompiler()` procedure.