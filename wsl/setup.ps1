$WshShell = New-Object -comObject WScript.Shell

function autostart {
	param (
		$name
	)

	$fromDir = "C:\bin"
	$toDir = "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	$Shortcut = $WshShell.CreateShortcut("$toDir\$name.lnk")
	$Shortcut.TargetPath = "$fromDir\$name.exe"
	$Shortcut.Save()
}

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

autostart -name keys
