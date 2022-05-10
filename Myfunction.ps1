function GetUserData    {
    $MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
    $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    Write-Verbose "tHIS IS A VERBOSE MESSAGE" 
    $MyUserList
    
}

function Get-CourseUser {
    [cmdletbinding] 
    param (
        [Parameter(Mandatory)]
    [string]$UserName
    

    Write-Output "Username is a $($username.GetType())
    )
    

    $MyUserListFile = GetUserData
   
    $MyUserList | Where-Object -Property Name -Like "*$UserName*"
    }