@echo off
@setlocal enabledelayedexpansion

echo ※ドメインが2ch.netまたはbbspink.comのdatのみを対象とします。
echo ※フォルダ名、ファイル名はエクスプローラからドラッグ＆ドロップできます。
echo.

set SRCROOT="D:\bbs_2ch\Logs\2ch"
if not exist %SRCROOT% echo %SRCROOT% が存在しません。&goto END
set BRDFILE="D:\bbs_2ch\jane2ch.brd"
if not exist %BRDFILE% echo %BRDFILE% が存在しません。&goto END
set DSTROOT="D:\bbs_2ch\o2on_dat"
if not exist %DSTROOT% (
	set /p YN=%DSTROOT:"=% が存在しません。作成しますか？（はい=y いいえ=n）
	if not "!YN!" == "y" goto END
	echo mkdir %DSTROOT%
	mkdir %DSTROOT%
)
set DSTROOT=%DSTROOT:"=%

set OVERWRITE=n
for /d %%i in (%SRCROOT%\*) do (
	for /d %%j in ("%%i"\*) do (
		echo *** %%~ni\%%~nj ***
		for /f "tokens=1-3 usebackq" %%k in (%BRDFILE%) do (
			if "%%~nj" == "%%m" (
				set HOST=%%k
				if "!HOST:~-7!" == "2ch.net" (
					for %%n in ("%%j"\*.dat) do (
						set SUBDIR=%%~nxn
						set SUBDIR=!SUBDIR:~0,4!
						if not exist "%DSTROOT%\2ch.net\%%l\!SUBDIR!" (
							echo mkdir "%DSTROOT%\2ch.net\%%l\!SUBDIR!"
							mkdir "%DSTROOT%\2ch.net\%%l\!SUBDIR!"
						)

						echo copy %%~nxn "%DSTROOT%\2ch.net\%%l\!SUBDIR!"
						copy /y "%%n" "%DSTROOT%\2ch.net\%%l\!SUBDIR!" > nul
					)
				) else if "!HOST:~-11!" == "bbspink.com" (
					for %%n in ("%%j"\*.dat) do (
						set SUBDIR=%%~nxn
						set SUBDIR=!SUBDIR:~0,4!
						if not exist "%DSTROOT%\bbspink.com\%%l\!SUBDIR!" (
							echo mkdir "%DSTROOT%\bbspink.com\%%l\!SUBDIR!"
							mkdir "%DSTROOT%\bbspink.com\%%l\!SUBDIR!"
						)

						echo copy %%~nxn "%DSTROOT%\bbspink.com\%%l\!SUBDIR!"
						copy /y "%%n" "%DSTROOT%\bbspink.com\%%l\!SUBDIR!" > nul
					)
				) else if "!HOST:~-8!" == "machi.to" (
					for %%n in ("%%j"\*.dat) do (
						set SUBDIR=%%~nxn
						set SUBDIR=!SUBDIR:~0,4!
						if not exist "%DSTROOT%\machi.to\%%l\!SUBDIR!" (
							echo mkdir "%DSTROOT%\machi.to\%%l\!SUBDIR!"
							mkdir "%DSTROOT%\machi.to\%%l\!SUBDIR!"
						)

						echo copy %%~nxn "%DSTROOT%\machi.to\%%l\!SUBDIR!"
						copy /y "%%n" "%DSTROOT%\machi.to\%%l\!SUBDIR!" > nul
					)
				)
			)
		)
	)
)

:END
echo.
