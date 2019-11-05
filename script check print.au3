$_strComputer = @ComputerName ; "."
$_objWMIService = ObjGet ( "winmgmts:{impersonationLevel=impersonate}!\\" & $_strComputer & "\root\cimv2" )
$_colInstalledPrinters =  $_objWMIService.ExecQuery ( "Select * from Win32_Printer" )
For $_objPrinter in $_colInstalledPrinters
    ConsoleWrite ( "+->-- Name : " & $_objPrinter.Name & @Crlf )
    ConsoleWrite ( "+->-- Location : " & $_objPrinter.Location & @Crlf )
    Switch  $_objPrinter.PrinterStatus
        Case 1
            $_strPrinterStatus = "не заебумба"
        Case 2
            $_strPrinterStatus = "Unknown"
        Case 3
            $_strPrinterStatus = "заебумба"
        Case 4
            $_strPrinterStatus = "Printing"
        Case 5
            $_strPrinterStatus = "Warmup"
    EndSwitch
    MsgBox(0,$_objPrinter.Name,$_strPrinterStatus,100)
Next