 #!/bin/bash
 echo "============================="
 echo "   Server Health Check"
 echo "============================="
 echo "Hostname   : $(hostname)"
 echo "Logged in  : $(whoami)"
 echo "Date/Time  : $(date)"
 echo ""
 echo "--- Disk Usage ---"
 df -h /c
 echo ""
 echo "--- Git Version ---"
 git --version
 echo "============================="
 EOF
