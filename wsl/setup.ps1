$WshShell = New-Object -comObject WScript.Shell

$conf = "$HOME\.config"

function autostart {
	param (
		$name
	)

	$fromDir = "C:\bin"
	$toDir = "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
	$Shortcut = $WshShell.CreateShortcut("$toDir\$name.lnk")
	$Shortcut.TargetPath = "$fromDir\$name.exe"
	$Shortcut.Arguments = "C:\config\key.binds"
	$Shortcut.Save()
}

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

autostart -name keys
