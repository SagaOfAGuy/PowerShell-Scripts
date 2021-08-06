# arguments for scheduling program to run at a specific time
$name = $args[0]
$day = $args[1]
$time = $args[2]
$program = $args[3]
$desc = $args[4]

# Check if program being executed exists
if([System.IO.File]::Exists($program) -eq $false) {
    Write-Host "Invalid Filepath. Please try again"
    exit 0 
} 
# Stop program if the number of arguments is not equal to 5
elseif (!$args.Length -eq 5) {
    write-host "Not enough parameters!";
    exit 0
}
# Create a new task based on the arguments
else { 
    $taskName = $name
    $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $day -At $time
    $action = New-ScheduledTaskAction -Execute $program
    $description = $desc

    Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Description $description
}
<#
Example Usage:
.\ProgramSchedule.ps1 "Chrome Test" "Friday" "12:43AM" "C:\Program Files\Google\Chrome\Application\chrome.exe" "Test opens Chrome browser at 12:43AM every Friday"
#>
