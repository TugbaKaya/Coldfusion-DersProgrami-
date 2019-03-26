
<CFAPPLiCATiON NAME="CFOgr" CLiENTMANAGEMENT="No" SETCLiENTCOOKiES="Yes" SESSiONMANAGEMENT="Yes" sessiontimeout=#CreateTimeSpan(0,0,30,0)#>

<!--- ENCRYPTION --->
<cfset Session.algorithm = "AES">

<cfset Session.encoding = "hex">

<cfif not isdefined("Session.key") >
	<cfset Session.key = GenerateSecretKey(Session.algorithm) >
</cfif>
<!--- ENCRYPTION --->