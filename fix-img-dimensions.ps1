$root = "C:\Users\pc\Documents\Site web @\Punaise Lit 33"
$count = 0
Get-ChildItem -Path $root -Recurse -Include "*.html" | ForEach-Object {
    $t = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $old = ' style="width:100%;border-radius:10px;margin:24px 0;"'
    if ($t.Contains($old)) {
        $t = $t.Replace($old, '')
        [System.IO.File]::WriteAllText($_.FullName, $t, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host ("Cleaned: " + $_.Name)
    }
}
Write-Host ("Done. " + $count + " files cleaned.")
