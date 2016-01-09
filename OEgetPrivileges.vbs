Set UAC = CreateObject("Shell.Application")  
UAC.ShellExecute "elevate_UAC", "ELEV", "", "runas", 1  
