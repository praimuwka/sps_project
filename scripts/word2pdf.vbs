Set objFSO = CreateObject("Scripting.FileSystemObject")
Dim erNum
Set objDoc = nothing
Const wdExportFormatPDF = 17

if  Wscript.Arguments.Count > 0 Then

    if objFSO.FileExists(WScript.Arguments(0)) then
        ' Get the running instance of MS Word. If Word is not running, Create it
        On Error Resume Next
        Set objWord = GetObject(, "Word.Application")
        If Err <> 0 Then
            Set objWord = CreateObject("Word.Application")
        End If
        
        Err.Clear
        Set objDoc = objWord.Documents.Open(WScript.Arguments(0),,TRUE)
        erNum = Err.number + 0
        On Error GoTo 0
        
        If erNum <> 0 Then
            WScript.Echo "Bad File"
        Else
            pdf = objWord.ActiveDocument.SaveAs2(WScript.Arguments(0)+".pdf", wdExportFormatPDF)
    
            if objFSO.FileExists(WScript.Arguments(0)+".pdf") then
                WScript.Echo "Successfull convertation"
            Else
                WScript.Echo "Convertation failed"
            End if
        End If 
        
        'Quit MS Word \ Close MS Word Document
        objWord.DisplayAlerts = False
        On Error Resume Next
            objDoc.Saved = TRUE
            objDoc.Close
        On Error GoTo 0
        If objWord.Documents.Count = 0 Then
            objWord.Quit(False) 
        End If
        Set objDoc = nothing
        set objWord = nothing
        set objFSO = Nothing
    Else
        WScript.Echo "Input File Not Exists"
    End if
Else
    msgbox("You must select a file to convert")
End If