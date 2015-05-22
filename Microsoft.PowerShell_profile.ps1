function elevate-process
{
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    [System.Diagnostics.Process]::Start($psi);
}
function kill-command
{
	param (
    		[string]$command,
    		[int]$time
 	)
	
	$p = Start-Process $command -passthru;
	if ( ! $p.WaitForExit((($time)*1000)))
	{ 
		echo "Killed $command after $time seconds"; 
		$p.kill();
	}
}
function egg-timer
{
	param (
    		[string]$command,
    		[int]$time
 	)
 	while ($true)
 	{
 		$p = Start-Process $command -passthru;
		if ( ! $p.WaitForExit((($time)*1000)))
		{ 
			echo "Killed $command after $time seconds"; 
			$p.kill();
		}
	}
}
function kill-drive
{
	manage-bde -lock ( ([string]$args) + ":") ;
}
function clockr
{
	while($true){
	clear
	clockres.exe
	wait -seconds 1
	}
}
function get-command-proper
{
	Get-Command $args | Select -ExpandProperty Definition ;
}
function check-net-alive
{
	ping -t 8.8.8.8 ;
}
function Get-ClipboardText
{
    $command =
    {
        add-type -an system.windows.forms
        [System.Windows.Forms.Clipboard]::GetText()
    }
    powershell -sta -noprofile -command $command
}

set-alias cnet check-net-alive;
set-alias sudow elevate-process;
set-alias killk kill-command;
set-alias eggy egg-timer;
set-alias killd kill-drive;
set-alias pls powerls;
set-alias gcmm get-command-proper;
set-alias clipr Get-ClipboardText;
# Load posh-git example profile
. 'C:\Users\Kaelan\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1' ;

