# Automate pcap search using tshark 


$pcap='C:\Users\DCI Student\Desktop\IOC.pcap'

# **** Can I automate the capture as well?!? 
&(“C:\Program Files\Wireshark\tshark.exe”) -i "Ethernet0" -a duration:15 -w "$pcap" 2>&1 | Out-Null

$iocd='C:\Users\DCI Student\Desktop\IOCdomains.txt'
$ioci='C:\Users\DCI Student\Desktop\IOCips.txt'
$ioch='C:\Users\DCI Student\Desktop\IOChttp.txt'

# Search for IOC Domains
$add_delim=0;$list=""
foreach ($row in (get-content $iocd)) { 
    if ($add_delim -eq 1) { $list=$list+"||" } else { $add_delim=1 }
    $list=$list+"dns.qry.name=="+"""$row"""
   }
&(“C:\Program Files\Wireshark\tshark.exe”) -r  "$pcap" $list

<#
# Search for http references 
$add_delim=0;$list=""
foreach ($row in (get-content $ioch)) { 
    if ($add_delim -eq 1) { $list=$list+"||" } else { $add_delim=1 }
    $list=$list+"http contains "+"""+"$row"+"""
   }
&(“C:\Program Files\Wireshark\tshark.exe”) -r  "$pcap" $list

#>

# Search for IOC IP's
$add_delim=0;$list=""
foreach ($row in (get-content $ioci)) { 
    if ($add_delim -eq 1) { $list=$list+"||" } else { $add_delim=1 }
    $list=$list+"ip.addr=="+"""$row"""
   }
&(“C:\Program Files\Wireshark\tshark.exe”) -r  "$pcap" $list
