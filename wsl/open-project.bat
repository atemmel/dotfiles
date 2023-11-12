REM usage: tmenu -path <path> -command 'cmd /C open-project.bat' project
@echo off

@set wsl_path=

for /F %%i in ('wsl wslpath %1') do @set "wsl_path=%%i

cd %1
start "" "neovide.exe" "--maximized" "--multigrid" "--wsl" %wsl_path%
