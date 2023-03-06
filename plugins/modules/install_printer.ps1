#!powershell

# (c) 2022, Dan Eckholm <@it-pappa>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Requires -Module Ansible.ModuleUtils.Legacy
#Requires -Module Ansible.ModuleUtils.Backup

$ErrorActionPreference = 'Stop';


$result = @{
  changed = $false
}

$params = Parse-Args -arguments $args -supports_check_mode $true;
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false;
$diff_mode = Get-AnsibleParam -obj $params -name "_ansible_diff" -type "bool" -default $false;
# Install Printer
$printer_name = Get-AnsibleParam -obj $params -name "printer_name" -type "str" -failifempty $true
$printer_driver = Get-AnsibleParam -obj $params -name "printer_driver" -type "str" -failifempty $true
$shared = Get-AnsibleParam -obj $params -name "shared" -type "bool" -default $false
$share_name = Get-AnsibleParam -obj $params -name "share_name" -type "str"
$comment = Get-AnsibleParam -obj $params -name "comment" -type "str"
$location = Get-AnsibleParam -obj $params -name "location" -type "str"
$port_name = Get-AnsibleParam -obj $params -name "port_name" -type "str" -failifempty $true
# Printer configuration
$paper_size = Get-AnsibleParam -obj $params -name "paper_size" -type "str" -default "default"
$duplexmode = Get-AnsibleParam -obj $params -name "duplexmode" -type "str" -default "default"
$color = Get-AnsibleParam -obj $params -name "color" -type "bool" -default $false

$state = Get-AnsibleParam -obj $params -name "state" -validateset "present","absent" -default "present";

#Function to install printer
function Install-Printer()
{
    $addParams = @{
        Name = $printer_name
        DriverName = $printer_driver
        Comment = $comment
        Location = $location
        PortName = $port_name
        Shared = $shared
        ShareName = $share_name
      };
      Add-Printer @addParams
}

function set-config()
{
    $setParams = @{
        PrinterName = $printer_name
        PaperSize = $paper_size
        Color = $color
        DuplexingMode = $duplexmode

      };
      Set-PrintConfiguration @setParams
}

function delete_printer()
{
  $printer = Get-Printer -Name $printer_name
  $printer | Remove-Printer -Confirm:$false
}


if ($state -eq "present") {
  try{
    Install-Printer
    set-config
  }
  catch{
    Fail-Json -obj $result -message "Error! $($_.Exception.Message)"
  }
}
#if state is absent
else {
  try {
      delete_printer
  }
  catch {
      Fail-Json -obj $result -message "Error! $($_.Exception.Message)"
  }
}
Exit-Json -obj $result