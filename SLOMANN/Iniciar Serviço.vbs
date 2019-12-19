If oNamesDict.Exists(UCASE(oFolder.Name))Then
WScript.Echo "Renaming " & oFolder.Path & " to " & ofolder.ParentFolder.Path & "\" & oNamesDict.Item(UCase(oFolder.Name))
oFolder.Name = oNamesDict.Item(UCase(oFolder.Name))
End If
RenameSubFolders oFolder.Path, oNamesDict




'// =========================================================================================================
'// Name: ControlServiceWMI
'// Purpose: Controls services using WMI
'// Input: strComputer - String - the computer on which we want to control the service. Null means local machine
'// strService - String - the name of the service. If blank, the function will use strDisplayName
'// strDisplayName - String - the display name of the service. If blank, the function will use strService
'// strOperation - String - the operation for the service: START, STOP, PAUSE or CONTINUE
'// intWaitTime - Integer - nbr of times to loop (effectively, the nbr of seconds to wait
'// for 'strOperation' to complete
'// Output: strError - String - contains error text, if operation fails
'// Returns: True/False
'// =========================================================================================================
Function ControlServiceWMI(ByVal strComputer, ByVal strService, ByVal strDisplayName, ByVal strOperation, ByVal intWaitTime, ByRef strError)

'// Define WMI *state* constants these are for the 'State' property
Const WMI_SERVICE_STOPPED = "Stopped"
Const WMI_SERVICE_STARTED = "Running"
Const WMI_SERVICE_START_PENDING = "Start Pending"
Const WMI_SERVICE_STOP_PENDING = "Stop Pending"
Const WMI_SERVICE_RUNNING = "Running"
Const WMI_SERVICE_CONTINUE_PENDING = "Continue Pending"
Const WMI_SERVICE_PAUSE_PENDING = "Pause Pending"
Const WMI_SERVICE_PAUSED = "Paused"
Const WMI_SERVICE_ERROR = "Unknown"

'// Define WMI *status* constants these are for the 'Status' property
Const WMI_SERVICE_OK = "OK"
Const WMI_SERVICE_DEGRADED = "Degraded"
Const WMI_SERVICE_UNKNOWN = "Unknown"
Const WMI_SERVICE_PRED_FAIL = "Pred Fail"
Const WMI_SERVICE_STARTING = "Starting"
Const WMI_SERVICE_STOPPING = "Stopping"
Const WMI_SERVICE_SERVICE = "Service" '// ?

'// Define string constants for service methods
Const START_SERVICE = "START"
Const STOP_SERVICE = "STOP"
Const PAUSE_SERVICE = "PAUSE"
Const CONTINUE_SERVICE = "CONTINUE"
Const SET_AUTOMATIC = "AUTOMATIC"
Const SET_MANUAL = "MANUAL"
Const SET_DISABLED = "DISABLED"

'// Win32_Service Method Return Value Table
Const WMI_Success = 0
Const WMI_NotSupported = 1
Const WMI_AccessDenied = 2
Const WMI_DependentServicesRunning = 3
Const WMI_InvalidServiceControl = 4
Const WMI_ServiceCannotAcceptControl = 5
Const WMI_ServiceNotActive = 6
Const WMI_ServiceRequestTimeout = 7
Const WMI_UnknownFailure = 8
Const WMI_PathNotFound = 9
Const WMI_ServiceAlreadyRunning = 10
Const WMI_ServiceDatabaseLocked = 11
Const WMI_ServiceDependencyDeleted = 12
Const WMI_ServiceDependencyFailure = 13
Const WMI_ServiceDisabled = 14
Const WMI_ServiceLogonFailure = 15
Const WMI_ServiceMarkedForDeletion = 16
Const WMI_ServiceNoThread = 17
Const WMI_StatusCircularDependency = 18
Const WMI_StatusDuplicateName = 19
Const WMI_StatusInvalidName = 20
Const WMI_StatusInvalidParameter = 21
Const WMI_StatusInvalidServiceAccount = 22
Const WMI_StatusServiceExists = 23
Const WMI_ServiceAlreadyPaused = 24

'// Build an array of the possible return values
Dim strWMI_ReturnErrors
Dim arrWMI_ReturnErrors

strWMI_ReturnErrors = ""
strWMI_ReturnErrors = strWMI_ReturnErrors & "Success,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Not Supported,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Access Denied,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Dependent Services Running,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Invalid Service Control,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Cannot Accept Control,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Not Active,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Request Timeout,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Unknown Failure,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Path Not Found,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Already Running,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Database Locked,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Dependency Deleted,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Dependency Failure,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Disabled,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Logon Failure,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Marked For Deletion,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service No Thread,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Circular Dependency,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Duplicate Name,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Invalid Name,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Invalid Parameter,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Invalid Service Account,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Status Service Exists,"
strWMI_ReturnErrors = strWMI_ReturnErrors & "Service Already Paused"

'// Just in case you left the trailing comma in place...
If Left(strWMI_ReturnErrors, 1) = "," Then
strWMI_ReturnErrors = Left(strWMI_ReturnErrors, Len(strWMI_ReturnErrors) - 1)
End If

arrWMI_ReturnErrors = Split(strWMI_ReturnErrors, ",")

Dim strQuery
Dim objComputer
Dim objServiceList
Dim objService
Dim intCounter
Dim blnServiceReturn

ControlServiceWMI = False

If Len(strService) = 0 And Len(strDisplayName) = 0 Then
strMsgText = ""
strMsgText = strMsgText & "Neither the service name or service display name were specified."
Exit Function
End If

On Error Resume Next

'// Get WMI objects and initial variables
'Set objComputer = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objComputer = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

If Err.Number = 0 Then
'// Only interested in controllable services (i.e. not system services, drivers, etc)
'// (well, we would be if ANY service set its 'AcceptStop' flag...)
strQuery = ""
strQuery = strQuery & "Select * From Win32_Service"
strQuery = strQuery & " Where "

If Len(strService) > 0 Then
strQuery = strQuery & "Name = '" & strService & "'"
If Len(strDisplayName) > 0 Then
strQuery = strQuery & " And "
strQuery = strQuery & "DisplayName = '" & strDisplayName & "'"
End If
Else
strQuery = strQuery & "DisplayName = '" & strDisplayName & "'"
End If

'strQuery = strQuery & " And "
'strQuery = strQuery & "AcceptStop = True"

Set objServiceList = objComputer.ExecQuery (strQuery)

If Err.Number = 0 Then
If objServiceList.Count > 0 Then
For Each objService in objServiceList
'// Determine the operation and carry it out
With objService
Select Case (strOperation)
Case SET_AUTOMATIC
If (.StartMode <> SET_AUTOMATIC) Then
Err.Number = .ChangeStartMode("Automatic")
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_STARTED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case SET_MANUAL
If (.StartMode <> SET_MANUAL) Then
Err.Number = .ChangeStartMode("Manual")
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_STARTED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case SET_DISABLED
If (.StartMode <> SET_DISABLED) Then
Err.Number = .ChangeStartMode("Disabled")
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_STARTED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case START_SERVICE
If (.State = WMI_SERVICE_STOPPED) Then
Err.Number = .StartService()
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_STARTED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case STOP_SERVICE
If (.State = WMI_SERVICE_RUNNING) Or (.State = WMI_SERVICE_PAUSED) Then
Err.Number = .StopService()
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_STOPPED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case PAUSE_SERVICE
If (.State = WMI_SERVICE_RUNNING) Then
Err.Number = .PauseService()
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_PAUSED Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If

Case CONTINUE_SERVICE
If (.State = WMI_SERVICE_PAUSED) Then
Err.Number = .ContinueService()
If Err.Number <> 0 Then
Do
If .State = WMI_SERVICE_RUNNING Then
Exit Do
End If
Call Sleep(1)
intCounter = intCounter + 1
Loop Until intCounter = intWaitTime '// We're only going to wait intWaitTime seconds
End If
End If
End Select
End With
Next
Else
With Err
.Description = "The service name specified "
.Raise 999

If Len(strService) > 0 Then
If Len(strDisplayName) > 0 Then
.Description = .Description & "'" & strDisplayName & "'"
End If
Else
.Description = .Description & "=" & strService & "="
End If

.Description = .Description & " does not exist."
.Source = "ControlServiceWMI"
End With
End If
End If
End If

If Err.Number = 0 Then
ControlServiceWMI = True
Else
'// Loop through the error array and, when you hit what Err.Number is,
'// drop out and set the appropriate error text
For intCounter = 0 To UBound(arrWMI_ReturnErrors)
If Err.Number = intCounter Then
Err.Description = arrWMI_ReturnErrors(intCounter)
End If
Next

strMsgText = ""
strMsgText = strMsgText & "Error " & Err.Number & " occured."

If Len(Err.Description) > 0 Then
strMsgText = strMsgText & Err.Description
End If

strError = strMsgText
End If

On Error Goto 0

End Function

Sub Sleep(ByVal intDelayInSecs)
'// Sleep is here because, of course, one can't use WScript.Sleep in embedded VBS CAs
Dim datStart
Dim blnTimesUp

datStart = Now()
blnTimesUp = False

While Not blnTimesUp
If DateDiff("s", datStart, Now()) >= CInt(intDelayInSecs) Then
blnTimesUp = True
End If
Wend
End Sub
