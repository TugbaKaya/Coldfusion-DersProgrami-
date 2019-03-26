<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Başlıksız Belge</title>
</head>

<body>
<cfoutput>#Bolumid#<br />#OgrGor#</cfoutput>

    <cfquery result="ders" datasource="kou" name="dersler">
        INSERT INTO acilandersler 
        (Bolumid, Katalogid, OgrGor, Donem) VALUES 
        (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Bolumid#" />,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Katalogid#" />,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Kurumid#" />,
         <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Donemid#" /> )
    </cfquery>
    
    <cfquery  name="goster" datasource="kou">
    	select Bolumid, Katalogid, OgrGor, Donem From acilandersler 
        where Dersid = #ders.IDENTITYCOL#
    </cfquery>
    
    <cfdump var="#ders#">
    <cfdump var="#goster#">


<!---<form action="DersProgrami.cfm" method="post">
<cfoutput>
        <cfquery name="gunler" datasource="KOU">       
            SELECT Gunid, GunAd FROM Gunler        
        </cfquery>
        Günler: 
        <select name="Gunid">
            <cfloop query="gunler">
                <option value="#Gunid#">#GunAd#</option>
            </cfloop>
        </select>
        
        <cfquery name="sDersler" datasource="KOU">        
            SELECT Top 30 Katalogid, DersAdi FROM BolognaKatalog         
        </cfquery> <br />
        Dersler:
        <select name="Katalogid">
            <cfloop query="sDersler">
                <option value="#Katalogid#">#DersAdi#</option>
            </cfloop>
        </select>
        
        <cfquery name="derssaati" datasource="KOU">        
            SELECT Top 30 DersBaslangicSaati, DersDilim, DersSaatid FROM DersSaati         
        </cfquery> <br />
        Saat:
        <select name="DersDilim">
            <cfloop query="derssaati">
                <option value="#DersDilim#">#DersBaslangicSaati#</option>
            </cfloop>
        </select>
        <br />
        <input type="submit" value="Ekle" name="ekle">
</cfoutput>
--->

</body>
</html>