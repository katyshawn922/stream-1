if (Test-Path release) {
    Remove-Item -Recurse -Force release | Out-Null
}

$Env:CGO_ENABLED="0"
$Env:GOROOT_FINAL="/usr"

$Env:GOOS="linux"
$Env:GOARCH="amd64"
go build -a -trimpath -asmflags "-s -w" -ldflags "-s -w" -o release\stream
if (-Not $?) { exit $lastExitCode }

upx --ultra-brute release\stream
if (-Not $?) { exit $lastExitCode }

Copy-Item -Force example.json release
exit 0
