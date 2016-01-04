/*
================================================================================
Author: Asger Juul Brunshøj
Email: asgerbrunshoj@gmail.com

Github: https://github.com/plul/Backspace-Up-Instead-Of-Back

Description:
In Windows Explorer: Makes backspace go up one level instead of going back.
Like in the days of Windows XP.
================================================================================
*/

backspace_up_instead_of_back() {
    /*
    This is defined as a function so that the variable, focused, does
    not pollute the global namespace when this script is integrated
    into a larger AHK script.

    The combination Alt+Up in Windows Explorer goes up one level in the
    directory tree. This is what backspace used to do in Windows XP.
    ControlGetFocus is issued because if for example the user is in the process
    of renaming a file, or is using the search field, then backspace should not
    be overridden.

    On Windows 10, the following control IDs were found with the Window Spy to
    be areas where backspace should be overridden:
    DirectUIHWND2
    DirectUIHWND3
    SysTreeView321

    Additionally, the following IDs were identified for controls where backspace
    should not be overridden:
    Edit1         : Address field is active.
    Edit2         : Rename folder/file is active.
    DirectUIHWND1 : Search field is active.
    */

    ControlGetFocus focused, A
    if (focused = "DirectUIHWND2")
    or (focused = "DirectUIHWND3")
    or (focused = "SysTreeView321")
        SendInput, !{Up}
    else
        SendInput, {Backspace}
}

#IfWinActive, ahk_class CabinetWClass
$Backspace::
    backspace_up_instead_of_back()
    return
#IfWinActive
