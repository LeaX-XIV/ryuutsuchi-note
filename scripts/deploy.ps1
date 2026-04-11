param (
	[string]$mkdocsroot = (Get-Location),
	[string]$mkdocsconfigfile = "mkdocs.yml",
	[switch]$dryrun = $False
)

$ErrorActionPreference = "Stop"

$ROOT = (Get-Location)

cd $mkdocsroot

While (-not (Get-ChildItem -Filter $mkdocsconfigfile)) {
	cd ..
}

$MKDOCS_ROOT = (Get-Location)
"Found mkdocs root = $mkdocsroot"

Write-Output '<!DOCTYPE html><html><head><meta http-equiv="refresh" content="0; url=Ryuutsuchi.html" /></head></html>' > $mkdocsroot\Note\index.html

if (-not $dryrun) {
	mkdocs gh-deploy
}
else {
	mkdocs build
}

del $mkdocsroot/Note/index.html

cd $ROOT
