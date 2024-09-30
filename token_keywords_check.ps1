param (
    [string]$keywords
)
Write-Host "keywords params: $keywords"

$keywordArray = $keywords.Split(',')

# Define two variables to store lines that contain and do not contain all keywords
$containsKeywords = @()
$notContainsKeywords = @()
$otherKeywords = @()

# Read the tokensonly.txt file from the current directory
$tokensFilePath = Join-Path -Path (Get-Location) -ChildPath "tokensonly.txt"
if (Test-Path $tokensFilePath) {
    $tokens = Get-Content -Path $tokensFilePath

    # Iterate through each line and check if it contains all keywords
    foreach ($token in $tokens) {
        $containsAny = $false
        foreach ($keyword in $keywordArray) {
            if ($token -match [regex]::Escape($keyword)) {
                $containsAny = $true
                break  # No need to check further once a match is found
            }
        }

        # Check if the line contains "XblGrts" anywhere in the string
        $xblCheck = $token -match [regex]::Escape('XblGrts')
        if (-Not $xblCheck) {
            $otherKeywords += $token
        }
        elseif ($containsAny) {
            $containsKeywords += $token
        } else {
            $notContainsKeywords += $token
        }
    }

    # Define the output file paths
    $containsKeywordsFilePath = Join-Path -Path (Get-Location) -ChildPath "tokens_contains_keywords.txt"
    $notContainsKeywordsFilePath = Join-Path -Path (Get-Location) -ChildPath "tokens_not_contains_keywords.txt"
    $otherKeywordsFilePath = Join-Path -Path (Get-Location) -ChildPath "tokens_not_XblGrts.txt"


    # Output the results to two txt files, using -Force to overwrite the files
    $containsKeywords | Out-File -FilePath $containsKeywordsFilePath -Force -Encoding UTF8
    $notContainsKeywords | Out-File -FilePath $notContainsKeywordsFilePath -Force -Encoding UTF8
    $otherKeywords | Out-File -FilePath $otherKeywordsFilePath -Force -Encoding UTF8

    Write-Host "Lines containing all keywords have been written to: $containsKeywordsFilePath"
    Write-Host "Lines not containing all keywords have been written to: $notContainsKeywordsFilePath"
    Write-Host "Lines not containing 'XblGrts' have been written to: $otherKeywordsFilePath"
} else {
    Write-Host "The file tokensonly.txt does not exist!"
}
