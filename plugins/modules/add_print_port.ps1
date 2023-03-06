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

$ErrorActionPreference = "Stop"

$params = Parse-Args -arguments $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false
$diff_mode = Get-AnsibleParam -obj $params -name "_ansible_diff" -type "bool" -default $false

$port_name = Get-AnsibleParam -obj $params -name "port_name" -type "str" -default "$port_address"
$port_address = Get-AnsibleParam -obj $params -name "port_address" -type "str" -failifempty $true
$snmp = Get-AnsibleParam -obj $params -name "snmp" -type "str" -default "public"
$protocol = Get-AnsibleParam -obj $params -name "protocol" -type "int" -default 1

$state = Get-AnsibleParam -obj $params -name "state" -type "str" -default "present" -validateset "absent","present"

$result = @{
    changed = $false
}

function Add-PrinterPort()
{
  try{
    $port = [WMIClass]"Win32_TcpIpPrinterPort"
    $port.psbase.scope.options.EnablePrivileges = $true
    $newPort = $port.CreateInstance()
    $newport.name = $port_name
    $newport.Protocol = $protocol
    $newport.HostAddress = $port_address
    $newport.PortNumber = 9100
    $newport.SnmpEnabled = $true
    $newport.SNMPCommunity = $snmp
    $newport.SNMPDevIndex = 1
    $newport.Put()

    $result.changed = $true
  }catch{
    Fail-Json -obj $result -message "Error! $($_.Exception.Message)"
  }
}

function Delete_PrinterPort()
{
  Remove-PrinterPort -Name $port_name;
}

if ($state -eq "present") {
  try{
    Add-PrinterPort
  }
  catch{
    Fail-Json -obj $result -message "Error! $($_.Exception.Message)"
  }
}  
else {
  try {

      Delete_PrinterPort
  }
  catch {
      Fail-Json -obj $result -message "Error! $($_.Exception.Message)"
  }
}
Exit-Json -obj $result
