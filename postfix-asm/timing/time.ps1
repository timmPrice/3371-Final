$exePath = ".\time.exe"
$sw = [System.Diagnostics.Stopwatch]::StartNew()
& $exePath
$sw.Stop()

$totalSeconds = $sw.Elapsed.TotalSeconds
$repeatCount = 100000

$throughput = $repeatCount / $totalSeconds
Write-Output "Ran $exePath $repeatCount times"
Write-Output "Total Time: $([math]::Round($totalSeconds, 4)) seconds"
Write-Output "Throughput: $([math]::Round($throughput)) ops/sec"

$exePath = ".\main.exe"
$sw = [System.Diagnostics.Stopwatch]::StartNew()
& $exePath
$sw.Stop()

$totalSeconds = $sw.Elapsed.TotalSeconds
Write-Output "Latency: $([math]::Round($totalSeconds, 4)) seconds"
