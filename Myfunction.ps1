enum ColorEnum {
    red
    green
    blue
    yellow
    black
    cyan

}

class Participant {
    [String] $Name
    [int]$Age
    [ColorEnum] $Color
    [int] $Id

    Participant ([String]$Name, [int]$Age, [ColorEnum]$Color, [int]$Id) {
        $This.Name = $Name
        $This.Age = $Age
        $This.Color = $Color
        $This.Id = $Id

    }



    [string] ToString() {
    Return '{0} {1} {2} {3}' -f $This.Name, $This.Age, $This.Color, $this.Id
    }
}
  function GetUserData    {
    $MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
    try {
        $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    }
    catch {
        throw "insert txt:$_"
    }

    
$MyUserList
    
}

function Get-CourseUser {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Name,
        
        [Parameter()]
        [int]$OlderThan
    )

    $Result = GetUserData

    if (-not [string]::IsNullOrEmpty($Name)) {
        $Result = $Result | Where-Object -Property Name -Like "*$Name*"
    }
    
    if ($OlderThan) {
        $Result = $Result | Where-Object -Property Age -ge $OlderThan
    }

    $Result
}     
function Add-CourseUser {
    [CmdletBinding()]
    Param (
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv",

        [Parameter(Mandatory)]
        [ValidatePattern({'^[A-Z]\w*\s+\[A-Z](\w\s)*$'}, ErrorMessage = 'Name does not match pattern' )]
        [string]$Name,

        [Parameter(Mandatory)]
        [Int]$Age,

        [Parameter(Mandatory)]
       #[ValidateSet('red', 'green', 'blue', 'yellow')]
        [ColorEnum]$Color,

        $UserID = (Get-Random -Minimum 10 -Maximum 100000)
    )

    $MyNewUser = [Participant]::new($Name, $Age, $Color, $Id)
    $MyCsvUser = $MyNewUser.ToString()

    $NewCSv = Get-Content $DatabaseFile -Raw
    $NewCSv += $MyCsvUser

    Set-Content -Value $NewCSv -Path $DatabaseFile
    
    #$MyCsvUser = "$Name,$Age,{0},{1}" -f $Color, $UserId
        
}

function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param (
        
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv"

    )

    $MyUserList = Get-Content -Path $DatabaseFile | ConvertFrom-Csv
    $RemoveUser = $MyUserList | Out-GridView -PassThru

    if ($PSCmdlet.ShouldProcess($DatabaseFile)) {
        $MyUserList = $MyUserList | Where-Object {
            -not (
                $_.Name -eq $RemoveUser.Name -and
                $_.Age -eq $RemoveUser.Age -and
                $_.Color -eq $RemoveUser.Color -and
                $_.Id -eq $RemoveUser.Id
            )
        }
        Set-Content -Value $($MyUserList | ConvertTo-Csv -NoTypeInformation) -Path $DatabaseFile -WhatIf
    }
    else {
        Write-Output "Did not Remove user $($RemoveUser.Name)"
    
    }
    
}

Function  Confirm-CourseUserId {
    Param() 

    $AllUser = GetUserData 

    Foreach ($User in $AllUser) {

    if ($User.Id -notmatch '^\d+$') {
    Write-Output "User $($User.Name) has mismatch id: $($User.id)"}
}
}

#$MyNewUser = (Participant)::new($Name, $Age, $Color, $Id)
#$MyCsvUser = $MyNewUser.ToString()

#$NewCSv = Get-Content $DatabaseFile -Raw
#$NewCSv += $MyCsvUser

#Set-Content -Value $NewCSv -Path $DatabaseFile -WhatIf
