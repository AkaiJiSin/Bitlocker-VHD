@echo off
chcp 65001 >nul

mode con: cols=80 lines=20

title Quản Lý Bitlocker VHD - Tien WoW

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    color 0e
    cls
    echo.
    echo.
    echo.
    echo                ==================================================
    echo                         QUẢN LÝ BITLOCKER VHD - TIEN WOW
    echo                ==================================================
    echo.
    echo                    [*] Đang yêu cầu cấp quyền Quản trị viên...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

set VHD_PATH=C:\Tien WoW.vhdx

:MainMenu
title Quản Lý Bitlocker VHD - Tien WoW
color 0e
cls
echo.
echo.
echo.
echo                ==================================================
echo                         QUẢN LÝ BITLOCKER VHD - TIEN WOW
echo                ==================================================
echo.
echo                         [1] Mở khóa ổ đĩa (Attach VHD)
echo                         [2] Khóa ổ đĩa (Detach VHD)
echo                         [3] Thoát script
echo.
echo                ==================================================
echo.
set /p choice="                       👉 Nhập lựa chọn (1-3): "

if "%choice%"=="1" goto AttachDisk
if "%choice%"=="2" goto DetachDisk
if "%choice%"=="3" exit
goto MainMenu

:AttachDisk
title [ĐANG CHẠY] Mở Khóa Ổ Đĩa Bitlocker VHD - Tien WoW
color 0a
cls
echo.
echo.
echo.
echo                ==================================================
echo                     MỞ KHÓA Ổ ĐĨA BITLOCKER VHD - TIEN WOW
echo                ==================================================
echo.
echo                      [*] Đang thiết lập lệnh hệ thống...
echo select vdisk file="%VHD_PATH%" > "%temp%\vdisk_attach.txt"
echo attach vdisk >> "%temp%\vdisk_attach.txt"

echo               [*] Đang tiến hành mở khóa ổ đĩa. Vui lòng đợi...
diskpart /s "%temp%\vdisk_attach.txt" >nul
del "%temp%\vdisk_attach.txt"

echo.
echo                --------------------------------------------------
echo                       [+] ĐÃ MỞ KHÓA Ổ ĐĨA THÀNH CÔNG! [+]
echo                --------------------------------------------------
echo.
echo                      Nhấn phím bất kỳ để thoát script...
pause >nul
exit

:DetachDisk
title [ĐANG CHẠY] Khóa Ổ Đĩa Bitlocker VHD - Tien WoW
color 0b
cls
echo.
echo.
echo.
echo                ==================================================
echo                      KHÓA Ổ ĐĨA BITLOCKER VHD - TIEN WOW
echo                ==================================================
echo.
echo                      [*] Đang thiết lập lệnh hệ thống...
echo select vdisk file="%VHD_PATH%" > "%temp%\vdisk_detach.txt"
echo detach vdisk >> "%temp%\vdisk_detach.txt"

echo                [*] Đang tiến hành khóa ổ đĩa. Vui lòng đợi...
diskpart /s "%temp%\vdisk_detach.txt" >nul
del "%temp%\vdisk_detach.txt"

echo.
echo                --------------------------------------------------
echo                        [+] ĐÃ KHÓA Ổ ĐĨA THÀNH CÔNG! [+]
echo                --------------------------------------------------
echo.
echo                      Nhấn phím bất kỳ để thoát script...
pause >nul
exit